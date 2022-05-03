package com.belhard.bookstore.service.impl;

import com.belhard.bookstore.dao.beans.Book;
import com.belhard.bookstore.dao.BookDao;
import com.belhard.bookstore.dao.impl.BookDaoJdbcImpl;
import com.belhard.bookstore.service.BookService;
import com.belhard.bookstore.service.dto.BookDto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class BookServiceImpl implements BookService {
    private final BookDao bookDao = new BookDaoJdbcImpl();


    @Override
    public List<BookDto> getAll() {
        List<Book> books = bookDao.getAllBooks();
        return booksToBooksDtos(books);
    }

    private BookDto bookToDto(Book book) {
        BookDto bookDto = new BookDto();
        bookDto.setId(book.getId());
        bookDto.setIsbn(book.getIsbn());
        bookDto.setTitle(book.getTitle());
        bookDto.setAuthor(book.getAuthor());
        bookDto.setPrice(book.getPrice());
        bookDto.setCoverDto(BookDto.CoverDto.valueOf(book.getCover().toString()));
        return bookDto;
    }

    private List<BookDto> booksToBooksDtos(List<Book> books) {
        List<BookDto> bookDtos = new ArrayList<>();
        for (Book book : books) {
            BookDto bookDto = bookToDto(book);
            bookDtos.add(bookDto);
        }
        return bookDtos;
    }

    @Override
    public BookDto getById(Long id) {
        Book book = bookDao.getBookById(id);
        if (book == null) {
            throw new RuntimeException("There is no book with such id!");
        }
        return bookToDto(book);
    }

    @Override
    public BookDto getByIsbn(String isbn) {
        Book book = bookDao.getBookByIsbn(isbn);
        if (book == null) {
            throw new RuntimeException("There is no book with such isbn!");
        }
        return bookToDto(book);
    }

    @Override
    public List<BookDto> getByAuthor(String author) {
        List<Book> books = bookDao.getBooksByAuthor(author);
        if (books.isEmpty()) {
            throw new RuntimeException("No books by such author!");
        }
        return booksToBooksDtos(books);
    }

    @Override
    public BookDto create(BookDto bookDto) {
        Book checkBook = bookDao.getBookByIsbn(bookDto.getIsbn());
        if (checkBook != null) {
            throw new RuntimeException("Book with such ISBN already exists!");
        }
        Book book = dtoToBook(bookDto);
        book = bookDao.createBook(book);
        return bookToDto(book);
    }

    private Book dtoToBook(BookDto bookDto) {
        Book book = new Book();
        book.setId(bookDto.getId());
        book.setIsbn(bookDto.getIsbn());
        book.setTitle(bookDto.getTitle());
        book.setAuthor(bookDto.getAuthor());
        book.setPrice(bookDto.getPrice());
        book.setCover(Book.Cover.valueOf(bookDto.getCoverDto().toString()));
        return book;
    }

    @Override
    public BookDto update(BookDto bookDto) {
        Book checkBook = bookDao.getBookByIsbn(bookDto.getIsbn());
        if (checkBook != null && checkBook.getId() != bookDto.getId()) {
            throw new RuntimeException("Book with such ISBN already exists!");
        }
        Book book = dtoToBook(bookDto);
        book = bookDao.updateBook(book);
        return bookToDto(book);
    }

    @Override
    public void delete(Long id) {
        if (!bookDao.deleteBook(id)) {
            throw new RuntimeException("Deletion was not completed! There is no book with such id!");
        }
    }

    @Override
    public int countAll() {
        return bookDao.countAllBooks();
    }

    public BigDecimal countPriceOfAllBooksByAuthor(String author) {
        BigDecimal sumPrice = new BigDecimal(0.0);
        List<BookDto> bookDtos = getByAuthor(author);
        for (BookDto bookDto : bookDtos) {
            sumPrice = sumPrice.add(bookDto.getPrice());
        }
        return sumPrice;
    }
}
