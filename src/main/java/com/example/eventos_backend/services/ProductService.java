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

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CryptoService cryptoService;

    @Autowired
    private ProductConverter productConverter;

    @Transactional(readOnly = true)
    public Page<ProductDto> obtenerProducts(String name, Integer page, Integer size) {
        Pageable pageable = Pageable.unpaged();
        if(page!=null && size!=null){
            pageable = PageRequest.of(page, size);
        } 
        Specification<ProductEntity> spec = Specification.where(ProductSpecification.obtenerProductsPorParametros(name));
        Page<ProductEntity> productEntitiesPage = productRepository.findAll(spec, pageable);
        return productEntitiesPage.map(productConverter::entityToDto);
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
