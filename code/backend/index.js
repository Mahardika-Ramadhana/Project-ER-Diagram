const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'db_perpustakaan',
  port: 3306
});

db.connect(err => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('Terhubung ke database MySQL.');
});

app.get('/', (req, res) => {
  res.send('Selamat datang di API Library Borrowing Tracker!');
});

app.post('/api/books', (req, res) => {
  const { title, author, publication_year, genre } = req.body;
  
  const newBook = { title, author, publication_year, genre, is_available: 1 };
  const sql = "INSERT INTO BOOK SET ?";

  db.query(sql, newBook, (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Gagal menambah buku' });
    }
    res.status(201).json({ id: result.insertId, ...newBook });
  });
});

app.get('/api/books', (req, res) => {
  const sql = "SELECT * FROM BOOK";
  db.query(sql, (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Gagal mengambil data buku' });
    }
    res.json(results);
  });
});

app.get('/api/books/:id', (req, res) => {
  const { id } = req.params;
  const sql = "SELECT * FROM BOOK WHERE book_id = ?";
  db.query(sql, [id], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Gagal mengambil data buku' });
    }
    if (result.length === 0) {
      return res.status(404).json({ message: 'Buku tidak ditemukan' });
    }
    res.json(result[0]);
  });
});

app.put('/api/books/:id', (req, res) => {
  const { id } = req.params;
  const { title, author, publication_year, genre } = req.body;
  const sql = "UPDATE BOOK SET title = ?, author = ?, publication_year = ?, genre = ? WHERE book_id = ?";

  db.query(sql, [title, author, publication_year, genre, id], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Gagal memperbarui buku' });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Buku tidak ditemukan' });
    }
    res.json({ message: 'Data buku berhasil diperbarui' });
  });
});

app.delete('/api/books/:id', (req, res) => {
  const { id } = req.params;
  const sql = "DELETE FROM BOOK WHERE book_id = ?";

  db.query(sql, [id], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Gagal menghapus buku' });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Buku tidak ditemukan' });
    }
    res.json({ message: 'Buku berhasil dihapus' });
  });
});

const port = 3000;
app.listen(port, () => {
  console.log(`Server backend berjalan di http://localhost:${port}`);
});