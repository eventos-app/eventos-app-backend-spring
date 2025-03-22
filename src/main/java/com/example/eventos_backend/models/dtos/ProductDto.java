package com.example.eventos_backend.models.dtos;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDto {
    
    @NotNull(message = "El ID del producto no puede estar vacío.")
    private String idProduct;

    @NotEmpty(message = "El nombre no puede estar vacío.")
    @Size(max = 100, message = "El nombre no puede exceder los 100 caracteres.")
    private String name;

    @NotEmpty(message = "La descripción no puede estar vacía.")
    @Size(max = 500, message = "La descripción no puede exceder los 500 caracteres.")
    private String description;

    @NotNull(message = "El monto no puede estar vacío.")
    @PositiveOrZero(message = "El monto debe ser mayor o igual a 0.")
    private Double amount;

    @NotNull(message = "El stock no puede estar vacío.")
    @PositiveOrZero(message = "El stock debe ser mayor o igual a 0.")
    private Integer stock;

    @NotNull(message = "La fecha de expiración no puede estar vacía.")
    private Date expirationDate;

    @Size(max = 50, message = "El tamaño no puede exceder los 50 caracteres.")
    private String size;

    private Date createdAt;
    private Date updatedAt;
    private Date deletedAt;
}