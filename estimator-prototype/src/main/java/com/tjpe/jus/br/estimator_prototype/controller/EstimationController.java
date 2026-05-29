package com.tjpe.jus.br.estimator_prototype.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.AdvisorParams;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.ollama.api.OllamaChatOptions;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.tjpe.jus.br.estimator_prototype.configuration.PromptSanitizer;
import com.tjpe.jus.br.estimator_prototype.dto.EstimativeResponse;

@RestController
@RequestMapping("api/v1/estimator")
public class EstimationController {

    private static final Logger logger = LoggerFactory.getLogger(EstimationController.class);
    
    private final ChatClient chatClient;
    private final PromptSanitizer sanitizer;

    public EstimationController(ChatClient.Builder builder, PromptSanitizer sanitizer) {
        this.sanitizer = sanitizer;
        this.chatClient = builder
            .defaultSystem("""
                You are an expert Agile Scrum Master and Senior Software Engineer. Your job is to estimate the development time (in hours) for a technical task based on its description.
                Don't inflate your estimated time to complete the task just to stay below the estimate. Be realistic and estimate as if you were part of a big tech company with tight deadlines.
                The estimative should always consider the 'Happy Path'.

                CRITICAL RULES FOR YOUR JSON OUTPUT:
                1. 'confidenceRateInTheEstimatedHours' MUST be an integer between 1 and 10. Never use 0. If there are high risks or missing details, give a low score (e.g., 1-4). If the task is clear, give a high score.
                2. 'justification' MUST be specific to the user's task description. Do not invent context unless explicitly mentioned in the input. Explain the logic behind the hours and the confidence rate.
                """)
            .build();
    }

    @GetMapping("/estimate")
    public EstimativeResponse getEstimative(@RequestParam String description) {
        logger.info("Received request to estimate task with description: " + description);

        String sanitizedPrompt = this.sanitizer.sanitize("Estimate the hours needed to build this task: " + description);
        logger.info("Sanitized prompt: " + sanitizedPrompt);

        return this.chatClient.prompt()
        .options(OllamaChatOptions.builder()
                .temperature(0.0)
                .topP(0.1))
        .advisors(AdvisorParams.ENABLE_NATIVE_STRUCTURED_OUTPUT)
        .user(sanitizedPrompt)
        .call()
        .entity(EstimativeResponse.class);
    }
}
