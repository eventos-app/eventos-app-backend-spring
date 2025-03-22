package com.example.eventos_backend.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.eventos_backend.models.ProductEntity;
import com.example.eventos_backend.models.converters.ProductConverter;
import com.example.eventos_backend.models.dtos.ProductDto;
import com.example.eventos_backend.models.specifications.ProductSpecification;
import com.example.eventos_backend.repositories.ProductRepository;
import com.example.eventos_backend.utils.exceptions.custom_exceptions.NotFoundException;

import java.util.ArrayList;
import java.util.List;
@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ProductConverter productConverter;

    @Autowired
    private CryptoService cryptoService;

    @Transactional(readOnly = true)
    public List<ProductDto> obtenerProducts(String name, Integer page, Integer size) {
        List<ProductEntity> productEntities = new ArrayList<>();
        Specification<ProductEntity> spec = Specification.where(ProductSpecification.obtenerProductsPorParametros(name));
        
        if (page != null && size != null) {
            Pageable pageable = PageRequest.of(page, size);
            Page<ProductEntity> productEntitiesPage = productRepository.findAll(spec, pageable);
            productEntities = productEntitiesPage.getContent();
        } else {
            productEntities = productRepository.findAll(spec);
        }

        List<ProductDto> productDtos = new ArrayList<>();
        for (ProductEntity productEntity : productEntities) {
            productDtos.add(productConverter.entityToDto(productEntity));
        }
        return productDtos;
    }

    @Transactional(readOnly = true)
    public ProductDto obtenerProductDtoPorId(String id) {
        int idDesencriptado = desencriptarIdProduct(id);
        ProductEntity productEntity = obtenerProductEntity(idDesencriptado);
        return productConverter.entityToDto(productEntity);
    }

    @Transactional
    public ProductDto crearProduct(ProductDto productDto) {
        ProductEntity productEntity = productConverter.dtoToEntity(productDto);
        ProductEntity savedEntity = productRepository.save(productEntity);
        return productConverter.entityToDto(savedEntity);
    }

    @Transactional
    public ProductDto actualizarProduct(String id, ProductDto productDto) {
        int idDesencriptado = desencriptarIdProduct(id);
        ProductEntity productEntity = obtenerProductEntity(idDesencriptado);
        productEntity.setName(productDto.getName());
        ProductEntity updatedEntity = productRepository.save(productEntity);
        return productConverter.entityToDto(updatedEntity);
    }

    @Transactional
    public void eliminarProduct(String id) {
        int idDesencriptado = desencriptarIdProduct(id);
        ProductEntity productEntity = obtenerProductEntity(idDesencriptado);
        productEntity.markAsDeleted();
        productRepository.save(productEntity);
    }

    public int desencriptarIdProduct(String idEncriptado) {
        return Integer.parseInt(cryptoService.decrypt(idEncriptado));
    }

    private ProductEntity obtenerProductEntity(int id) {
        return productRepository.findByIdProductAndDeletedAtIsNull(id)
                .orElseThrow(() -> new NotFoundException("Product not found"));
    }
}
