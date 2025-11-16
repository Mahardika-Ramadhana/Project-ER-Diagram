-- ==================== CREATE OPERATIONS ====================

-- Add new non-fiction book
INSERT INTO BOOK (isbn, title, author, publication_year, genre) 
VALUES ('978-1984877860', 'Range: Why Generalists Triumph', 'David Epstein', 2019, 'Psychology');

-- Register new member
INSERT INTO MEMBER (member_code, name, email, phone) 
VALUES ('STU005', 'Emma Brown', 'emma.brown@email.com', '123-456-7894');

-- Create new loan for science book
INSERT INTO LOAN (book_id, member_id, borrow_date, due_date) 
VALUES (8, 4, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY));  -- What If? book

-- ==================== READ OPERATIONS ====================

-- Search non-fiction books by topic
SELECT book_id, isbn, title, author, genre, is_available 
FROM BOOK 
WHERE title LIKE '%History%' OR genre LIKE '%Science%';

-- Search available computer science books
SELECT book_id, title, author, publication_year
FROM BOOK 
WHERE genre = 'Computer Science' AND is_available = TRUE;

-- Get all active loans with member and book details
SELECT 
    l.loan_id,
    m.name AS member_name,
    m.member_code,
    b.title AS book_title,
    b.genre,
    l.borrow_date,
    l.due_date,
    DATEDIFF(l.due_date, CURRENT_DATE) AS days_remaining
FROM LOAN l
JOIN MEMBER m ON l.member_id = m.member_id
JOIN BOOK b ON l.book_id = b.book_id
WHERE l.return_date IS NULL;

-- ==================== UPDATE OPERATIONS ====================

-- Return a book
UPDATE LOAN SET return_date = CURRENT_DATE WHERE loan_id = 1;
UPDATE BOOK SET is_available = TRUE WHERE book_id = 1;

-- Update book availability when borrowed
UPDATE BOOK SET is_available = FALSE WHERE book_id = 3;

-- Update member information
UPDATE MEMBER SET phone = '123-555-9999' WHERE member_id = 2;

-- Pay a fine
UPDATE FINE SET paid_status = TRUE WHERE fine_id = 1;

-- ==================== DELETE OPERATIONS ====================

-- Remove a member (only if they have no active loans)
DELETE FROM MEMBER 
WHERE member_id = 4 
AND NOT EXISTS (
    SELECT 1 FROM LOAN 
    WHERE member_id = 4 AND return_date IS NULL
);

-- Remove a book (only if not currently borrowed)
DELETE FROM BOOK 
WHERE book_id = 5 
AND NOT EXISTS (
    SELECT 1 FROM LOAN 
    WHERE book_id = 5 AND return_date IS NULL
);

-- ==================== NON-FICTION SPECIFIC QUERIES ====================

-- Books by genre (non-fiction categories)
SELECT 
    genre,
    COUNT(*) AS book_count,
    SUM(CASE WHEN is_available = TRUE THEN 1 ELSE 0 END) AS available_count
FROM BOOK 
GROUP BY genre 
ORDER BY book_count DESC;

-- Most popular non-fiction genres
SELECT 
    b.genre,
    COUNT(l.loan_id) AS total_loans,
    COUNT(DISTINCT l.member_id) AS unique_borrowers
FROM BOOK b
LEFT JOIN LOAN l ON b.book_id = l.book_id
GROUP BY b.genre
ORDER BY total_loans DESC;

-- Overdue science/history books
SELECT 
    m.member_code,
    m.name AS member_name,
    b.title AS book_title,
    b.genre,
    l.borrow_date,
    l.due_date,
    DATEDIFF(CURRENT_DATE, l.due_date) AS days_overdue
FROM LOAN l
JOIN MEMBER m ON l.member_id = m.member_id
JOIN BOOK b ON l.book_id = b.book_id
WHERE l.return_date IS NULL 
AND l.due_date < CURRENT_DATE
AND b.genre IN ('Science', 'History', 'Computer Science');

-- Member borrowing preferences by genre
SELECT 
    m.member_code,
    m.name AS member_name,
    b.genre,
    COUNT(l.loan_id) AS books_borrowed,
    AVG(DATEDIFF(COALESCE(l.return_date, CURRENT_DATE), l.borrow_date)) AS avg_reading_days
FROM MEMBER m
JOIN LOAN l ON m.member_id = l.member_id
JOIN BOOK b ON l.book_id = b.book_id
GROUP BY m.member_code, m.name, b.genre
ORDER BY m.name, books_borrowed DESC;

-- Recent non-fiction publications (last 5 years)
SELECT 
    title,
    author,
    genre,
    publication_year,
    is_available
FROM BOOK
WHERE publication_year >= YEAR(CURRENT_DATE) - 5
ORDER BY publication_year DESC;

-- Library statistics for non-fiction collection
SELECT 
    COUNT(*) AS total_books,
    COUNT(DISTINCT genre) AS unique_genres,
    AVG(publication_year) AS avg_publication_year,
    SUM(CASE WHEN is_available = TRUE THEN 1 ELSE 0 END) AS available_books,
    (SELECT title FROM BOOK ORDER BY publication_year DESC LIMIT 1) AS newest_book,
    (SELECT title FROM BOOK ORDER BY publication_year ASC LIMIT 1) AS oldest_book
FROM BOOK;