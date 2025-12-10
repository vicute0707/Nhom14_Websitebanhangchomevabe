package iuh.student.www.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import iuh.student.www.dto.ChatbotRequest;
import iuh.student.www.dto.ChatbotResponse;
import iuh.student.www.dto.ChatHistoryDTO;
import iuh.student.www.entity.Feedback;
import iuh.student.www.entity.Order;
import iuh.student.www.entity.Product;
import iuh.student.www.entity.User;
import iuh.student.www.repository.FeedbackRepository;
import iuh.student.www.repository.OrderRepository;
import iuh.student.www.repository.ProductRepository;
import iuh.student.www.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class GeminiAIChatbotService {

    private final UserRepository userRepository;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final FeedbackRepository feedbackRepository;
    private final ObjectMapper objectMapper;

    @Value("${gemini.api.key}")
    private String geminiApiKey;
    @Value("${gemini.model:gemini-2.0-flash-exp}")
    private String geminiModel;
    private static final String GEMINI_URL =
            "https://generativelanguage.googleapis.com/v1beta/models/%s:generateContent?key=%s";
    private final OkHttpClient httpClient = new OkHttpClient();

    private final Cache<Long, String> contextCache = Caffeine.newBuilder()
            .expireAfterWrite(60, TimeUnit.SECONDS)
            .maximumSize(1_000)
            .build();

    private final Map<String, Deque<ChatHistoryDTO>> historyMap = new ConcurrentHashMap<>();

    public ChatbotResponse chat(ChatbotRequest request, Long userId) {
        try {
            String context = contextCache.get(userId,
                    uid -> buildContextData(uid, request.getContextType()));

            String history = formatHistory(request.getSessionId());

            String prompt = buildPrompt(request.getMessage(), context, history);

            String aiReply = callGeminiAPI(prompt);
            aiReply = factCheck(aiReply);

            saveHistory(request.getSessionId(), "user", request.getMessage());
            saveHistory(request.getSessionId(), "assistant", aiReply);

            return ChatbotResponse.builder()
                    .message(aiReply)
                    .sessionId(request.getSessionId())
                    .success(true)
                    .suggestedActions(getSuggestedActions(request.getMessage()))
                    .relatedData(userId != null ? Map.of("userId", userId) : null)
                    .build();

        } catch (Exception e) {
            log.error("❌ Chatbot error", e);
            return ChatbotResponse.builder()
                    .message("Xin lỗi, tôi đang gặp sự cố. Vui lòng thử lại sau.")
                    .success(false)
                    .error(e.getMessage())
                    .build();
        }
    }

    // ---------- Context ----------
    private String buildContextData(Long userId, String contextType) {
        StringBuilder sb = new StringBuilder();
        if (userId != null) {
            User u = userRepository.findById(userId).orElse(null);
            if (u != null) {
                sb.append("## USER\n");
                sb.append("- Name: ").append(u.getFullName()).append("\n");
                sb.append("- Email: ").append(u.getEmail()).append("\n");
                sb.append("- Role: ").append(u.getRole()).append("\n");

                List<Order> orders = orderRepository.findByUserIdOrderByOrderDateDesc(u.getId())
                        .stream().limit(5).toList();
                if (!orders.isEmpty()) {
                    sb.append("## LAST 5 ORDERS\n");
                    orders.forEach(o -> sb.append("- Order #")
                            .append(o.getId()).append(" | ")
                            .append(o.getStatus()).append(" | ")
                            .append(o.getTotalAmount()).append("₫\n"));
                }
            }
        }
        if ("product".equals(contextType)) {
            List<Product> pros = productRepository.findByActiveTrue()
                    .stream().limit(10).toList();
            sb.append("## TOP 10 PRODUCTS\n");
            pros.forEach(p -> sb.append("- ")
                    .append(p.getName()).append(" | ")
                    .append(p.getPrice()).append("₫ | ")
                    .append("Stock: ").append(p.getStockQuantity()).append("\n"));
        }
        return sb.toString();
    }

    // ---------- Prompt ----------
    private String buildPrompt(String userMessage, String context, String history) {
        String fewShot = """
                Ví dụ:
                H: Tôi muốn xem đơn hàng gần nhất
                A: Đơn hàng #123456 của bạn đã được giao vào 01/12/2025 ✅
                H: Còn hàng không?
                A: Sản phẩm "Áo cotton trẻ em size M" còn 25 chiếc 🍼
                """;
        return String.format("""
                %s
                LỊCH SỬ TRÒ CHUYỆN:
                %s
                DỮ LIỆU:
                %s
                CÂU HỎI: %s
                TRẢ LỜI:
                """, fewShot, history, context, userMessage);
    }

    // ---------- Gemini call ----------
    private String callGeminiAPI(String prompt) throws IOException {
        String url = String.format(GEMINI_URL, geminiModel, geminiApiKey);
        Map<String, Object> body = Map.of(
                "contents", List.of(Map.of("parts", List.of(Map.of("text", prompt)))),
                "generationConfig", Map.of("temperature", 0.7, "maxOutputTokens", 1024)
        );
        Request req = new Request.Builder()
                .url(url)
                .post(RequestBody.create(objectMapper.writeValueAsBytes(body),
                        MediaType.get("application/json")))
                .build();
        try (Response res = httpClient.newCall(req).execute()) {
            if (!res.isSuccessful())
                throw new IOException("Gemini error " + res.code());
            String json = res.body().string();
            return objectMapper.readTree(json)
                    .at("/candidates/0/content/parts/0/text")
                    .asText("Xin lỗi, tôi không thể trả lời.");
        }
    }

    // ---------- Fact-check ----------
    private String factCheck(String answer) {
        // Bắt tên trong ngoặc kép
        java.util.regex.Pattern p = java.util.regex.Pattern.compile("\"([^\"]*)\"");
        java.util.regex.Matcher m = p.matcher(answer);
        StringBuffer sb = new StringBuffer();

        while (m.find()) {
            String name = m.group(1);
            boolean exists = productRepository.searchAllProducts(name.toLowerCase()).size() > 0;
            if (!exists) {
                m.appendReplacement(sb, "\"" + name + " (không tồn tại)\"");
            } else {
                m.appendReplacement(sb, "\"" + name + "\"");
            }
        }
        m.appendTail(sb);
        return sb.toString();
    }
    // ---------- History ----------
    private void saveHistory(String sessionId, String role, String content) {
        historyMap.computeIfAbsent(sessionId, k -> new ArrayDeque<>())
                .addLast(new ChatHistoryDTO(role, content));
        if (historyMap.get(sessionId).size() > 7)
            historyMap.get(sessionId).removeFirst();
    }

    private String formatHistory(String sessionId) {
        return historyMap.getOrDefault(sessionId, new ArrayDeque<>())
                .stream()
                .map(d -> d.role() + ": " + d.content())
                .collect(Collectors.joining("\n"));
    }

    public List<Object> getHistory(String sessionId) {
        return List.copyOf(historyMap.getOrDefault(sessionId, new ArrayDeque<>()));
    }

    // ---------- Feedback ----------
    public void saveFeedback(String sessionId, String message, int rating) {
        Feedback fb = new Feedback();
        fb.setSessionId(sessionId);
        fb.setMessage(message);
        fb.setRating(rating);
        fb.setCreatedAt(LocalDateTime.now());
        feedbackRepository.save(fb);
    }

    // ---------- Suggested actions ----------
    private List<String> getSuggestedActions(String message) {
        String m = message.toLowerCase();
        List<String> out = new ArrayList<>();
        if (m.contains("đơn")) out.add("Xem đơn hàng");
        if (m.contains("sản phẩm")) out.add("Xem sản phẩm mới");
        if (m.contains("thanh toán")) out.add("Hướng dẫn thanh toán");
        if (out.isEmpty()) out.addAll(List.of("Xem đơn hàng", "Xem sản phẩm", "Liên hệ hỗ trợ"));
        return out;
    }
}