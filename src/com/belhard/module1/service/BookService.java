package com.belhard.module1.service;

import com.belhard.module1.service.dto.BookDto;

import java.math.BigDecimal;
import java.util.List;

public interface BookService {
    List<BookDto> getAll();

    BookDto getById(Long id);

    BookDto getByIsbn(String isbn);

    List<BookDto> getByAuthor(String author);

    BookDto create(BookDto bookDto);

    BookDto update(BookDto bookDto);

    void delete(Long id);

    int countAll();

    public BigDecimal countPriceOfAllBooksByAuthor(String author);
}

