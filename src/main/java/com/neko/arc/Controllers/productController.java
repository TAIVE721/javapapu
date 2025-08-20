package com.neko.arc.Controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.neko.arc.Entities.products;
import com.neko.arc.Repositories.productrepo;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/productos")
public class productController {

    @Autowired
    private productrepo productrepo;

    @GetMapping()
    public List<products> getAllProducts() {
        return productrepo.findAll();
    }

    @GetMapping("/{id}")
    public products getbyid(@PathVariable Long id) {
        return productrepo.findById(id).orElseThrow(() -> new RuntimeException("product not found"));
    }

    @PostMapping
    public products postMethodName(@RequestBody products entity) {

        return productrepo.save(entity);
    }

}
