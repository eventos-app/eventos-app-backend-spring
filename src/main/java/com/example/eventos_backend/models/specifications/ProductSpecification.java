package com.example.eventos_backend.models.specifications;

import org.springframework.data.jpa.domain.Specification;

import com.example.eventos_backend.models.ProductEntity;

public class ProductSpecification {

    public static Specification<ProductEntity> obtenerProductsPorParametros(String name) {
        return (root, query, criteriaBuilder) -> {
            if (name != null) {
                return criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), "%" + name.toLowerCase() + "%");
            }
            return criteriaBuilder.conjunction();
        };
    }
}
