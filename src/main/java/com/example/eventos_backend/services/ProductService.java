package com.example.eventos_backend.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.example.eventos_backend.models.dtos.ProductDto;

public interface ProductService {

    Page<ProductDto> obtenerProducts(String name, Integer page, Integer size);

    ProductDto obtenerProductDtoPorId(String id);

    ProductDto crearProduct(ProductDto productDto);

    ProductDto actualizarProduct(String id, ProductDto productDto);

    void eliminarProduct(String id);
}
