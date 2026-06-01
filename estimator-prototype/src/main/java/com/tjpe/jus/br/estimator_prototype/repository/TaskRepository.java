package com.tjpe.jus.br.estimator_prototype.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.annotations.Query;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;
import com.tjpe.jus.br.estimator_prototype.entity.Task;

@Repository
public interface TaskRepository extends ElasticsearchRepository<Task, String> {
    
    //Get the top 3 most similar tasks
    @Query("{\"match\":{\"description\":{\"query\":\"?0\",\"fuzziness\":\"AUTO\"}}}")
    List<Task> findTop3ByDescription(String description, Pageable pageable);
}
