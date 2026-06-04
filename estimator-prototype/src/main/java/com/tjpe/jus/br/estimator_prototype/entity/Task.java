package com.tjpe.jus.br.estimator_prototype.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import lombok.Data;

@Data
@Document(indexName = "tasks")
public class Task {
    
    @Id
    private String id;

    private String projectName;
    
    private String description;
    
    private Estimative estimativeTime;    
}