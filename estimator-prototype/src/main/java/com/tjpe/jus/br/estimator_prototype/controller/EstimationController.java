package com.tjpe.jus.br.estimator_prototype.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.tjpe.jus.br.estimator_prototype.dto.EstimativeResponse;
import com.tjpe.jus.br.estimator_prototype.service.EstimationService;

@RestController
@RequestMapping("api/v1/estimator")
public class EstimationController {

    @Autowired
    private EstimationService service;

    @GetMapping("/estimate")
    public ResponseEntity<EstimativeResponse> getEstimative(@RequestParam String description) {
        return ResponseEntity.ok(this.service.estimate(description));
    }
}
