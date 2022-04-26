package com.belhard.module1;

import java.util.List;

public interface BookDao {
    List<Book> getAllBooks();

    Book getBookById(Long id);

    Book createBook(Book book);

    Book updateBook(Book book);

    void deleteBook(Long id);
}