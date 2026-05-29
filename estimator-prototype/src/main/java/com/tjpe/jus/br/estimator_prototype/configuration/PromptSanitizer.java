package com.tjpe.jus.br.estimator_prototype.configuration;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.stereotype.Component;

@Component
public class PromptSanitizer {
    
    private static final Map<String, Pattern> SENSITIVE_PATTERNS = new HashMap<>();

    static {
        // Matches common password assignments: password=xyz, db_pass: "xyz"
        SENSITIVE_PATTERNS.put("<PASSWORD_REDACTED>", 
            Pattern.compile("(?i)(password|passwd|pass|pwd|secret)\\s*[:=]\\s*['\"\\s]?([^'\"\\s,;]+)['\"\\s]?"));
        
        // Matches classic environment variable configurations: DB_HOST=localhost
        SENSITIVE_PATTERNS.put("<ENV_VAR_REDACTED>", 
            Pattern.compile("(?i)[A-Z_-]{3,30}\\s*=\\s*[^\\s]+"));
            
        // Matches standard API Keys / Bearer Tokens
        SENSITIVE_PATTERNS.put("<API_KEY_REDACTED>", 
            Pattern.compile("(?i)(api[-_]?key|bearer|token|secret_key)\\s*[:=]\\s*['\"\\s]?([a-zA-Z0-9_\\-\\.]{16,})['\"\\s]?"));
            
        // Matches Emails (PII)
        SENSITIVE_PATTERNS.put("<EMAIL_REDACTED>", 
            Pattern.compile("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}"));
    }

    public String sanitize(String rawInput) {
        if (rawInput == null || rawInput.isBlank()) {
            return rawInput;
        }

        String sanitizedText = rawInput;

        // Loop through all defined patterns and swap secrets with their placeholder tag
        for (Map.Entry<String, Pattern> entry : SENSITIVE_PATTERNS.entrySet()) {
            String placeholder = entry.getKey();
            Pattern pattern = entry.getValue();
            Matcher matcher = pattern.matcher(sanitizedText);
            
            // For passwords/keys, we preserve the variable name but mask the sensitive value
            if (placeholder.equals("<PASSWORD_REDACTED>") || placeholder.equals("<API_KEY_REDACTED>")) {
                sanitizedText = matcher.replaceAll(mr -> mr.group(1) + "=: " + placeholder);
            } else {
                sanitizedText = matcher.replaceAll(placeholder);
            }
        }

        return sanitizedText;
    }
}
