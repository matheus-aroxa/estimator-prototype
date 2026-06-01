package com.tjpe.jus.br.estimator_prototype.service;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.PageRequest;
import org.springframework.ai.chat.client.AdvisorParams;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.ollama.api.OllamaChatOptions;
import org.springframework.stereotype.Service;
import com.tjpe.jus.br.estimator_prototype.configuration.PromptSanitizer;
import com.tjpe.jus.br.estimator_prototype.dto.EstimativeResponse;
import com.tjpe.jus.br.estimator_prototype.entity.Task;
import com.tjpe.jus.br.estimator_prototype.repository.TaskRepository;

@Service
public class EstimationService {
    private static final Logger logger = LoggerFactory.getLogger(EstimationService.class);
    
    private final TaskRepository taskRepository;
    private final ChatClient chatClient;
    private final PromptSanitizer sanitizer;

    private static final String SYSTEM_PROMPT_BASE = """
        You are an expert Agile Scrum Master and Senior Software Engineer. Your job is to estimate the development time (in hours) for a technical task based on its description.
        Don't inflate your estimated time to complete the task just to stay below the estimate. Be realistic and estimate as if you were part of a big tech company with tight deadlines.
        The estimative should always consider the 'Happy Path'.

        You will be provided with historical examples of similar tasks. These examples include a 'Historical Planning Poker Size' using an enum notation (E0 (N/A), E1(1H), E2(3H), E3(1D), E5(1D-2D), E8(3D-5D), E13(6D-9D) and E21(10D-15D)).
        Use these historical poker sizes as a baseline benchmark to calibrate your understanding of complexity, and then calculate and extrapolate the final response strictly in HOURS.

        CRITICAL RULES FOR YOUR JSON OUTPUT:
        1. 'confidenceRateInTheEstimatedHours' MUST be an integer between 1 and 10. Never use 0. If there are high risks or missing details, give a low score (e.g., 1-4). If the task is clear, give a high score.
        2. 'justification' MUST be specific to the user's task description. Do not invent context unless explicitly mentioned in the input. Explain the logic behind the hours and the confidence rate. You should always mention the tasks you received as examples and their time estimative.
        """;
    
    public EstimationService(TaskRepository taskRepository, ChatClient.Builder builder, PromptSanitizer sanitizer) {
        this.taskRepository = taskRepository;
        this.sanitizer = sanitizer;
        this.chatClient = builder.build();
    }

    public EstimativeResponse estimate(String description) {
        logger.info("Received request to estimate task with description: " + description);

        List<Task> similarTasks = getTop3Taks(description);

        String fewShotExamples = formatFewShotExamples(similarTasks);

        String fullSystemPrompt = SYSTEM_PROMPT_BASE + "\n" + fewShotExamples;

        String sanitizedPrompt = this.sanitizer.sanitize("Estimate the hours needed to build this task: " + description);
        logger.info("Sanitized prompt: " + sanitizedPrompt);

        EstimativeResponse response = this.chatClient.prompt()
        .system(fullSystemPrompt)
        .options(OllamaChatOptions.builder()
                .temperature(0.0)
                .topP(0.1))
        .advisors(AdvisorParams.ENABLE_NATIVE_STRUCTURED_OUTPUT)
        .user(sanitizedPrompt)
        .call()
        .entity(EstimativeResponse.class);

        return new EstimativeResponse(
            response.estimatedHoursToCompleteTheTask(),
            response.confidenceRateInTheEstimatedHours(),
            response.riskFactorsThatMayAffectTheTimeToCompleteTheTask(),
            response.justification(),
            formatSimilarTasks(similarTasks));
    }

    private List<Task> getTop3Taks(String description) {
        logger.info("Searching for similar tasks");

        List<Task> similarTasks = this.taskRepository.findTop3ByDescription(description, PageRequest.of(0, 3));
        logger.info(similarTasks.toString());

        return similarTasks;
    }

    private String formatFewShotExamples(List<Task> tasks) {
        if (tasks == null || tasks.isEmpty()) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        sb.append("Here are some examples of similar tasks with their historical Planning Poker sizes to guide your hours calculation:\n\n");

        for (int i = 0; i < tasks.size(); i++) {
            Task task = tasks.get(i);
            
            // Valida se a task possui a estimativa preenchida
            if (task.getEstimativeTime() == null) {
                continue;
            }

            // Pega o nome do enum (ex: "E1", "E2", "E3", "E5")
            String pokerSize = task.getEstimativeTime().name(); 

            sb.append("### Example ").append(i + 1).append(":\n");
            sb.append("Task Description: ").append(task.getDescription()).append("\n");
            sb.append("Historical Planning Poker Size: ").append(pokerSize).append("\n");
            sb.append("-------------------------------------------\n\n");
        }
        
        return sb.toString();
    }

    private List<String> formatSimilarTasks(List<Task> tasks) {
        return tasks.stream()
                .map(task -> {
                    String pokerSize = task.getEstimativeTime() != null ? task.getEstimativeTime().name() : "N/A";
                    String projectName = task.getProjectName() != null ? task.getProjectName() : "Projeto não informado";
                    String description = task.getDescription() != null ? task.getDescription() : "Descrição não informada";

                    return projectName + " | " + description + " | Planning Poker: " + pokerSize;
                })
                .toList();
    }
}
