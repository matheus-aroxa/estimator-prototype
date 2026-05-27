package com.tjpe.jus.br.estimator_prototype.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/estimator")
public class EstimationController {

    private static final Logger logger = LoggerFactory.getLogger(EstimationController.class);
    
    private final ChatClient chatClient;

    public EstimationController(ChatClient.Builder builder) {
        this.chatClient = builder
            .build();
    }

    @GetMapping("/estimate")
    public String getEstimative(@RequestParam String description) {
        logger.info("Received request to estimate task with description: " + description);

        String basicPrompt = "Estimate the hours needed to build this task: " + description;

        return this.chatClient.prompt().user(basicPrompt).call().content();
    }
}
