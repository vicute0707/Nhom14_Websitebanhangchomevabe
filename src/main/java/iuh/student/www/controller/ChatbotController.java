package iuh.student.www.controller;

import iuh.student.www.dto.ChatbotRequest;
import iuh.student.www.dto.ChatbotResponse;
import iuh.student.www.entity.User;
import iuh.student.www.repository.UserRepository;
import iuh.student.www.service.GeminiAIChatbotService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/chatbot")
@RequiredArgsConstructor

@Slf4j
public class ChatbotController {

    private final GeminiAIChatbotService chatbotService;
    private final UserRepository userRepository;

    @PostMapping("/chat")
    public ResponseEntity<ChatbotResponse> chat(
            @RequestBody ChatbotRequest request,
            Authentication auth) {

        Long userId = null;
        if (auth != null && auth.isAuthenticated()) {
            String email = auth.getName();
            User user = userRepository.findByEmail(email).orElse(null);
            userId = (user != null) ? user.getId() : null;
        }

        log.info("📩 Chat request from userId={}: {}", userId, request.getMessage());
        return ResponseEntity.ok(chatbotService.chat(request, userId));
    }

    @GetMapping("/history/{sessionId}")
    public ResponseEntity<List<Object>> getHistory(@PathVariable String sessionId) {
        return ResponseEntity.ok(chatbotService.getHistory(sessionId));
    }

    @PostMapping("/feedback")
    public ResponseEntity<Void> sendFeedback(
            @RequestParam String sessionId,
            @RequestParam String message,
            @RequestParam int rating) {

        chatbotService.saveFeedback(sessionId, message, rating);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/health")
    public ResponseEntity<String> health() {
        return ResponseEntity.ok("🤖 Chatbot AI is running");
    }
}