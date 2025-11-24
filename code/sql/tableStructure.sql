-- Create Database
CREATE DATABASE IF NOT EXISTS library_system;
USE library_system;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS FINE;
DROP TABLE IF EXISTS LOAN;
DROP TABLE IF EXISTS BOOK;
DROP TABLE IF EXISTS MEMBER;

-- Create BOOK table
CREATE TABLE BOOK (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publication_year INT,
    genre VARCHAR(100),
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create MEMBER table
CREATE TABLE MEMBER (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    member_code VARCHAR(15) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    membership_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Create LOAN table
CREATE TABLE LOAN (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES MEMBER(member_id) ON DELETE CASCADE,
    CHECK (due_date > borrow_date)
);

-- Create FINE table
CREATE TABLE FINE (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    fine_date DATE DEFAULT CURRENT_DATE,
    paid_status BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (loan_id) REFERENCES LOAN(loan_id) ON DELETE CASCADE
);
