package com.example.eventos_backend.services.implementations;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
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
import com.example.eventos_backend.services.CryptoService;
import com.example.eventos_backend.services.ProductService;
import com.example.eventos_backend.utils.exceptions.custom_exceptions.NotFoundException;

@Service
public class ProductServiceImp implements ProductService{

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CryptoService cryptoService;

    @Autowired
    private ProductConverter productConverter;

    @Transactional(readOnly = true)
    @Cacheable(value = "products", key = "#root.methodName + '_' + T(java.util.Objects).toString(#name, 'null') + '_' + T(java.util.Objects).toString(#page, 'null') + '_' + T(java.util.Objects).toString(#size, 'null')")
    public Page<ProductDto> obtenerProducts(String name, Integer page, Integer size) {
        Pageable pageable = PageRequest.of(0, Integer.MAX_VALUE);
        if(page!=null && size!=null){
            pageable = PageRequest.of(page, size);
        } 
        Specification<ProductEntity> spec = Specification.where(ProductSpecification.obtenerProductsPorParametros(name));
        Page<ProductEntity> productEntitiesPage = productRepository.findAll(spec, pageable);
        return productEntitiesPage.map(productConverter::entityToDto);
    }

    @Transactional(readOnly = true)
    @Cacheable(value = "product", key = "#id")
    public ProductDto obtenerProductDtoPorId(String id) {
        int idDesencriptado = desencriptarIdProduct(id);
        ProductEntity productEntity = obtenerProductEntity(idDesencriptado);
        return productConverter.entityToDto(productEntity);
    }

    @Transactional
    @CachePut(value = "product", key = "#result.id")
    public ProductDto crearProduct(ProductDto productDto) {
        ProductEntity productEntity = productConverter.dtoToEntity(productDto);
        ProductEntity savedEntity = productRepository.save(productEntity);
        return productConverter.entityToDto(savedEntity);
    }

    @Transactional
    @CachePut(value = "product", key = "#id")
    public ProductDto actualizarProduct(String id, ProductDto productDto) {
        int idDesencriptado = desencriptarIdProduct(id);
        ProductEntity productEntity = obtenerProductEntity(idDesencriptado);
        productEntity.setName(productDto.getName());
        ProductEntity updatedEntity = productRepository.save(productEntity);
        return productConverter.entityToDto(updatedEntity);
    }

    @Transactional
    @CacheEvict(value = "product", key = "#id")
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
