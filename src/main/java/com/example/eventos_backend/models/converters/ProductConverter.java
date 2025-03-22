package com.example.eventos_backend.models.converters;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.example.eventos_backend.models.ProductEntity;
import com.example.eventos_backend.models.dtos.ProductDto;
import com.example.eventos_backend.services.CryptoService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;

@Component
public class ProductConverter {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
    private final Validator validator = validatorFactory.getValidator();

    @Autowired
    private CryptoService cryptoService;

    public ProductDto entityToDto(ProductEntity productEntity) {
        if (productEntity == null) {
            return null;
        }

        return ProductDto.builder()
                .idProduct(cryptoService.encrypt(Integer.toString(productEntity.getIdProduct())))
                .name(productEntity.getName())
                .description(productEntity.getDescription())
                .amount(productEntity.getAmount())
                .stock(productEntity.getStock())
                .expirationDate(productEntity.getExpirationDate())
                .size(productEntity.getSize())
                .createdAt(productEntity.getCreatedAt())
                .updatedAt(productEntity.getUpdatedAt())
                .deletedAt(productEntity.getDeletedAt())
                .build();
    }

    public ProductEntity dtoToEntity(ProductDto productDto) {
        if (productDto == null) {
            return null;
        }

        return ProductEntity.builder()
                .idProduct(Integer.getInteger(cryptoService.decrypt(productDto.getIdProduct())))
                .name(productDto.getName())
                .description(productDto.getDescription())
                .amount(productDto.getAmount())
                .stock(productDto.getStock())
                .expirationDate(productDto.getExpirationDate())
                .size(productDto.getSize())
                .createdAt(productDto.getCreatedAt())
                .updatedAt(productDto.getUpdatedAt())
                .deletedAt(productDto.getDeletedAt())
                .build();
    }

    public ProductDto fromJsonToDto(String data) {
        try {
            ProductDto productDto = objectMapper.readValue(data, ProductDto.class);
            Set<ConstraintViolation<ProductDto>> violations = validator.validate(productDto);
            if (!violations.isEmpty()) {
                StringBuilder errorMessage = new StringBuilder("Errores de validación:");
                for (ConstraintViolation<ProductDto> violation : violations) {
                    errorMessage.append("\n").append(violation.getPropertyPath()).append(": ").append(violation.getMessage());
                }
                throw new IllegalArgumentException(errorMessage.toString());
            }
            return productDto;
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Error convert JSON to ProductDto", e);
        }
    }
}
