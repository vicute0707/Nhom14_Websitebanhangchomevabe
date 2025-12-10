package iuh.student.www.dto;

import lombok.*;


@Builder
public record ChatHistoryDTO(String role, String content) {}