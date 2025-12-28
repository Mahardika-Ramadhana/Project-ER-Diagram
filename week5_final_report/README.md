# Library Borrowing Tracker System

## Project Overview
A comprehensive database-driven web application for managing library book borrowing operations. This system allows librarians to track books, manage members, and monitor borrowing activities with real-time fine calculation logic.

**Project Duration:** 5 Weeks  
**Team Size:** 3 Students  
**Database:** PostgreSQL (Neon DBaaS)  
**Frontend:** React (Vite) + Tailwind CSS  
**Backend:** NestJS  

---

## Team Members - Group 12
- **Mahardika Ramadhana** (24/538247/PA/22831)
- **Hammam Muhammad Yazid** (24/534894/PA/22687)
- **Daffa M. Siddiq** (24/533358/PA/22569)

---

## System Objectives
- **Automated Circulation:** Handle borrowing and returning processes in real-time.
- **Business Logic Enforcement:** Automatically calculate due dates (14 days) and fines (IDR 1,000/day).
- **Data Integrity:** Ensure data accuracy using 3NF normalization and Foreign Key constraints.
- **API Documentation:** Provide clear API specs using Swagger.

---

## Technologies Used

### Backend
- **Framework:** NestJS (Node.js)
- **Language:** TypeScript
- **API Docs:** Swagger (OpenAPI)

### Frontend  
- **Framework:** React.js (via Vite)
- **Styling:** Tailwind CSS
- **HTTP Client:** Axios

### Database
- **RDBMS:** PostgreSQL
- **Hosting:** Neon (Serverless Postgres)

---

## Database Design

### Relational Schema (3NF)
The database is normalized to the Third Normal Form (3NF) to reduce redundancy.

**Key Tables:**
1. **BOOK**: Stores inventory data (`book_id`, `title`, `author`, `is_available`).
2. **MEMBER**: Stores user data (`member_id`, `name`, `email`).
3. **LOAN**: Transaction table linking Books and Members (`borrow_date`, `due_date`).

> *Note: Fine calculation is handled dynamically via application logic based on the difference between `return_date` and `due_date`.*

---

## Installation & Setup

### Prerequisites
- Node.js (v18 or higher)
- PostgreSQL (Local or Cloud URL)
- Git

### Step-by-Step Setup

1. **Clone Repository**
   ```bash
   git clone [https://github.com/Mahardika-Ramadhana/Project-ER-Diagram.git](https://github.com/Mahardika-Ramadhana/Project-ER-Diagram.git)
   cd Project-ER-Diagram

```

2. **Backend Setup (NestJS)**
```bash
cd backend
npm install

# Setup Environment Variables
cp .env.example .env
# Update DATABASE_URL with your PostgreSQL connection string

npm run start:dev

```


3. **Frontend Setup (Vite)**
```bash
cd frontend
npm install
npm run dev

```


4. **Access Application**
* **Frontend UI:** http://localhost:5173
* **Backend API:** http://localhost:3000
* **Swagger Docs:** http://localhost:3000/api



---

## Features Implemented

### 1. Dashboard & Statistics

* Real-time overview of total books, members, and active loans.
* Visual indicators for overdue items.

### 2. Loan Management

* **Borrowing:** Select Member and Book -> System sets Due Date automatically (Today + 14 days).
* **Returning:** System checks for overdue days and calculates fines instantly.

### 3. Inventory Control

* Add/Edit/Delete Books.
* Filter books by availability status.

### 4. API Documentation

* Fully integrated Swagger UI for testing endpoints (`POST`, `GET`, `DELETE`).

---

## Repository Structure
```text
Project-ER-Diagram/
├── code/
│   ├── frontend/
│   │   └── index.html
│   └── sql/
│       ├── insertData.sql
│       ├── operationsCRUD.sql
│       └── tableStructure.sql
├── week1_proposal_ERD/
│   ├── LibrarySystem.erdplus
│   └── Proposal Project Database Design.pdf
├── week2_schema_SQL/
│   ├── Relational_Schema.erdplus
│   └── SQLImplementation.sql
├── week3_CRUD/
│   ├── index.js
│   ├── package.json
│   └── package-lock.json
├── week4_integration/
│   └── LibraryProject/         # Full Stack Application source code
└── week5_final_report/
    ├── final_project.pdf       <-- COMPLETE REPORT
    └── README.md

---

## Sample Queries (PostgreSQL)

### 1. Check Overdue Books

```sql
SELECT m.name, b.title, l.due_date, 
       (CURRENT_DATE - l.due_date) * 1000 AS estimated_fine
FROM LOAN l
JOIN MEMBER m ON l.member_id = m.member_id
JOIN BOOK b ON l.book_id = b.book_id
WHERE l.return_date IS NULL AND l.due_date < CURRENT_DATE;

```

### 2. Get Most Popular Books

```sql
SELECT b.title, COUNT(l.loan_id) as borrow_count
FROM LOAN l
JOIN BOOK b ON l.book_id = b.book_id
GROUP BY b.title
ORDER BY borrow_count DESC
LIMIT 5;

```

---

## Troubleshooting

**"Client does not support authentication protocol"**

* Ensure you are using the correct PostgreSQL connection string from Neon/Local.

**"CORS Error in Frontend"**

* Make sure to enable CORS in `main.ts` in the NestJS app: `app.enableCors();`

---

*Last Updated: December 2025* *Course Project: Database Design and Implementation*

```

```
