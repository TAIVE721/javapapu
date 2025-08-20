package com.neko.arc.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.neko.arc.Entities.products;

public interface productrepo extends JpaRepository<products, Long> {

}
