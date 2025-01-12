CREATE DATABASE UAS_2

USE UAS_2

-- Membuat Tabel Penjualan
CREATE TABLE Penjualan (
    Id_Penjualan INT PRIMARY KEY,
    Tanggal DATE,
    Produk VARCHAR(50),
    Kategori VARCHAR(50),
    Jumlah INT,
    Harga_Satuan DECIMAL(15, 2),
    Total_Penjualan DECIMAL(15, 2)
);

-- Menambahkan Data ke Tabel Penjualan
INSERT INTO Penjualan (Id_Penjualan, Tanggal, Produk, Kategori, Jumlah, Harga_Satuan, Total_Penjualan) VALUES
(1, '2024-08-01', 'Laptop', 'Elektronik', 3, 10000000, 30000000),
(2, '2024-08-02', 'Headphone', 'Aksesoris', 5, 500000, 2500000),
(3, '2024-08-10', 'Laptop', 'Elektronik', 2, 12000000, 24000000),
(4, '2024-08-12', 'Keyboard', 'Aksesoris', 4, 700000, 2800000),
(5, '2024-08-15', 'Monitor', 'Elektronik', 2, 3000000, 6000000),
(6, '2024-08-20', 'Mouse', 'Aksesoris', 10, 200000, 2000000);