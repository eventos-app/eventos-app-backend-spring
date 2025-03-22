package com.example.eventos_backend.models.specifications;

import org.springframework.data.jpa.domain.Specification;

import com.example.eventos_backend.models.ProductEntity;

import jakarta.persistence.criteria.Predicate;

public class ProductSpecification {

    public static Specification<ProductEntity> obtenerProductsPorParametros(String name) {
        return (root, query, criteriaBuilder) -> {
            Predicate predicadoFinal =criteriaBuilder.isNull(root.get("deletedAt"));
            if (name != null) {
                predicadoFinal = criteriaBuilder.and(predicadoFinal,criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), "%" + name.toLowerCase() + "%"));
            }
            return predicadoFinal;
        };
    }
}
