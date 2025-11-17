CREATE TABLE BOOK (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    publication_year INT,
    genre VARCHAR(100),
    is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE MEMBER (
    member_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    membership_date DATE
);

CREATE TABLE LOAN (
    loan_id INT PRIMARY KEY,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    book_id INT,
    member_id INT,
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id),
    FOREIGN KEY (member_id) REFERENCES MEMBER(member_id)
);

CREATE TABLE FINE (
    fine_id INT PRIMARY KEY,
    loan_id INT UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    fine_date DATE,
    paid_status BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (loan_id) REFERENCES LOAN(loan_id)
);
