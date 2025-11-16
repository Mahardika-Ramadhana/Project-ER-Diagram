-- Insert Sample NON-FICTION Books
INSERT INTO BOOK (isbn, title, author, publication_year, genre) VALUES
('978-0133970777', 'Database Systems: The Complete Book', 'Hector Garcia-Molina', 2008, 'Computer Science'),
('978-0321122267', 'Introduction to Algorithms', 'Thomas H. Cormen', 2009, 'Computer Science'),
('978-0062316097', 'Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 2015, 'History'),
('978-0143124174', 'The Power of Habit', 'Charles Duhigg', 2012, 'Psychology'),
('978-1455586691', 'The Innovators', 'Walter Isaacson', 2014, 'Biography'),
('978-1594205381', 'The Sixth Extinction', 'Elizabeth Kolbert', 2014, 'Science'),
('978-0316017930', 'Outliers: The Story of Success', 'Malcolm Gladwell', 2008, 'Psychology'),
('978-0544272996', 'What If?', 'Randall Munroe', 2014, 'Science'),
('978-0062457714', 'The Subtle Art of Not Giving a F*ck', 'Mark Manson', 2016, 'Self-Help'),
('978-0735211292', 'Atomic Habits', 'James Clear', 2018, 'Self-Help');

-- Insert Sample Members
INSERT INTO MEMBER (member_code, name, email, phone) VALUES
('STU001', 'Alice Johnson', 'alice.johnson@email.com', '123-456-7890'),
('STU002', 'Bob Smith', 'bob.smith@email.com', '123-456-7891'),
('STU003', 'Carol Davis', 'carol.davis@email.com', '123-456-7892'),
('STU004', 'David Wilson', 'david.wilson@email.com', '123-456-7893');

-- Insert Sample Loans
INSERT INTO LOAN (book_id, member_id, borrow_date, due_date) VALUES
(1, 1, '2024-01-10', '2024-02-10'),  -- Database Systems
(3, 2, '2024-01-12', '2024-02-12'),  -- Sapiens
(6, 3, '2024-01-15', '2024-02-15');  -- The Sixth Extinction

-- Insert Sample Fines
INSERT INTO FINE (loan_id, amount, fine_date) VALUES
(1, 5.00, '2024-02-15');