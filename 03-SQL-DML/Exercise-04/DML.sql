USE UAS_2

-- A

SELECT
    Kategori,
    SUM(Jumlah * Harga_Satuan) AS TotalPenjualan
FROM Penjualan
GROUP BY Kategori;

-- B

SELECT
    Kategori,
    SUM(Jumlah * Harga_Satuan) AS TotalPenjualan
FROM Penjualan
GROUP BY Kategori
HAVING SUM(Jumlah * Harga_Satuan) > 5000000;

-- C

SELECT
    Tanggal,
    Produk,
    Jumlah
FROM Penjualan
WHERE Kategori = 'Elektronik' AND (Jumlah BETWEEN 1 AND 3)
ORDER BY Tanggal DESC;

-- D

SELECT
    Kategori,
    AVG(Total_Penjualan) AS RataRataPenjualan
FROM Penjualan
GROUP BY Kategori
HAVING AVG(Total_Penjualan) > 7000000;

-- E

SELECT
    Tanggal,
    Produk,
    Jumlah,
    Total_Penjualan
FROM Penjualan
WHERE Kategori = 'Aksesoris'
  AND Tanggal BETWEEN '2024-08-01' AND '2024-08-20'
ORDER BY Jumlah ASC;