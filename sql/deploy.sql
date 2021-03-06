DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS covers;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

TRUNCATE books CASCADE;
TRUNCATE covers CASCADE;
TRUNCATE users CASCADE;
TRUNCATE roles CASCADE;

CREATE TABLE covers (
	id BIGSERIAL PRIMARY KEY,
	name VARCHAR(20)
);

CREATE TABLE books (
	id BIGSERIAL PRIMARY KEY,
	isbn CHAR(17) UNIQUE NOT NULL,
	title VARCHAR(100) NOT NULL,
	author VARCHAR(100),
	price DECIMAL(7,2) DEFAULT 0.0 NOT NULL,
	cover_id BIGINT REFERENCES covers,
	deleted BOOLEAN DEFAULT false NOT NULL
);

CREATE TABLE roles (
	id BIGSERIAL PRIMARY KEY,
	name VARCHAR(20)
);

CREATE TABLE users (
	id BIGSERIAL PRIMARY KEY,
	firstname VARCHAR(50) NOT NULL,
	lastname VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	userpassword VARCHAR(100) NOT NULL,
	role_id BIGINT REFERENCES roles,
	deleted BOOLEAN DEFAULT false NOT NULL
);

INSERT INTO covers (name)
VALUES ('SOFT'),
	('HARD'),
	('SPECIAL');

INSERT INTO books (isbn, title, author, price, cover_id)
VALUES ('901-1-13-141401-0', 'Pride and Prejudice', 'Jane Austen', 10.75, (SELECT id FROM covers WHERE name='SOFT')),
	('902-2-13-141401-9', 'To Kill a Mockingbird', 'Harper Lee', 9.25, (SELECT id FROM covers WHERE name='HARD')),
	('903-3-13-141401-8', 'The Great Gatsby', 'F. Scott Fitzgerald', 11.55, (SELECT id FROM covers WHERE name='SPECIAL')),
	('904-4-13-141401-7', 'One Hundred Years of Solitude', 'Gabriel Garcia Marquez', 17.35, (SELECT id FROM covers WHERE name='SPECIAL')),
	('905-5-13-141401-6', 'In Cold Blood', 'Truman Capote', 9.45, (SELECT id FROM covers WHERE name='HARD')),
	('906-6-13-141401-5', 'Wide Sargasso Sea', 'Jean Rhys', 5.75, (SELECT id FROM covers WHERE name='SOFT')),
	('907-7-13-141401-4', 'Brave New World', 'Aldous Huxley', 19.25, (SELECT id FROM covers WHERE name='HARD')),
	('908-8-13-141401-3', 'I Capture The Castle', 'Dodie Smith', 7.75, (SELECT id FROM covers WHERE name='SOFT')),
	('909-9-13-141401-2', 'Jane Eyre', 'Charlotte Bronte', 8.75, (SELECT id FROM covers WHERE name='SOFT')),
	('910-0-13-141401-1', 'Crime and Punishment', 'Fyodor Dostoevsky', 18.55, (SELECT id FROM covers WHERE name='SPECIAL')),
	('911-1-13-141401-0', 'The Secret History', 'Donna Tartt', 17.55, (SELECT id FROM covers WHERE name='SPECIAL')),
	('912-2-13-141401-9', 'The Call of the Wild', 'Jack London', 14.25, (SELECT id FROM covers WHERE name='HARD')),
	('913-3-13-141401-8', 'The Brothers Karamazov', 'Fyodor Dostoevsky', 15.35, (SELECT id FROM covers WHERE name='HARD')),
	('914-4-13-141401-7', 'War and Peace', 'Leo Tolstoy', 9.15, (SELECT id FROM covers WHERE name='SOFT')),
	('915-5-13-141401-6', 'Anna Karenina', 'Leo Tolstoy', 15.25, (SELECT id FROM covers WHERE name='HARD')),
	('916-6-13-141401-5', 'Nineteen Eighty-Four', 'George Orwell', 18.25, (SELECT id FROM covers WHERE name='HARD')),
	('917-7-13-141401-4', 'The Master and Margarita', 'Mikhail Bulgakov', 11.25, (SELECT id FROM covers WHERE name='HARD')),
	('918-8-13-141401-3', 'Frankenstein', 'Mary Shelley', 7.75, (SELECT id FROM covers WHERE name='SOFT')),
	('919-9-13-141401-2', 'To the Lighthouse', 'Virginia Woolf', 13.95, (SELECT id FROM covers WHERE name='HARD')),
	('920-0-13-141401-1', 'Moby-Dick', 'Herman Melville', 19.95, (SELECT id FROM covers WHERE name='SPECIAL'));

INSERT INTO roles (name)
VALUES ('ADMIN'),
	('MANAGER'),
	('CUSTOMER');

INSERT INTO users (firstname, lastname, email, userpassword, role_id)
VALUES ('Alex', 'Baker', 'test1111@gmail.com', '1111', (SELECT id FROM roles WHERE name='ADMIN')),
	('John', 'Carpenter', 'test2222@gmail.com', '2222', (SELECT id FROM roles WHERE name='MANAGER')),
	('James', 'Smith', 'test3333@gmail.com', '3333', (SELECT id FROM roles WHERE name='CUSTOMER')),
	('John', 'Smith', 'test4444@gmail.com', '4444', (SELECT id FROM roles WHERE name='CUSTOMER')),
	('Michael', 'Carver', 'test5555@gmail.com', '5555', (SELECT id FROM roles WHERE name='MANAGER')),
	('William', 'Fisher', 'test6666@gmail.com', '6666', (SELECT id FROM roles WHERE name='CUSTOMER')),
	('George', 'Shepherd', 'test7777@gmail.com', '7777', (SELECT id FROM roles WHERE name='CUSTOMER')),
	('James', 'Hunter', 'test8888@gmail.com', '8888', (SELECT id FROM roles WHERE name='CUSTOMER')),
	('John', 'Baker', 'test9999@gmail.com', '9999', (SELECT id FROM roles WHERE name='MANAGER')),
	('Nicholas', 'Carver', 'test0000@gmail.com', '0000', (SELECT id FROM roles WHERE name='CUSTOMER'));
