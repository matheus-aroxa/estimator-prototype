package com.tjpe.jus.br.estimator_prototype.dto;

import java.util.List;
import com.fasterxml.jackson.annotation.JsonPropertyDescription;

public record EstimativeResponse (

    @JsonPropertyDescription("A estimativa de horas recomendada para completar a tarefa descrita. Este campo é obrigatório")
    int estimatedHoursToCompleteTheTask,

    @JsonPropertyDescription("Índice de confiança na estimativa de horas para completar a tarefa descrita. Deve ser um número de 1 a 10.Tarefas com muitos riscos, incertezas e/ou falta de dados similares tem índices de confiança menores. Este campo é obrigatório")
    int confidenceRateInTheEstimatedHours, // 1-10

    @JsonPropertyDescription("Lista de fatores de risco para o desenvolvimento da tarefa. Caso não haja nenhum fator de risco, o resultado deve ser uma lista com apenas uma String 'Não foram mapeados fatores de risco para esta tarefa'. Este campo é obrigatório")
    List<String> riskFactorsThatMayAffectTheTimeToCompleteTheTask,

    @JsonPropertyDescription("Justificativa detalhada sobre o motivo da quantidade de horas estimadas para conclusão da tarefa, do índice de confiança e dos fatores de risco")
    String justification
) {}