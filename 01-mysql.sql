-- Show all List database
SHOW DATABASES;

-- Create Database
CREATE DATABASE belajar_mysql;

-- Delete Database
DROP DATABASE belajar_mysql;

-- Use database
use belajar_mysql;

-- Show engine mysql
SHOW ENGINES;

-- Show all list table
SHOW TABLES;

-- Create Table
CREATE TABLE barang(
  id INT,
  nama VARCHAR(100) NOT NULL,
  harga INT NOT NULL DEFAULT 0,
  jumlah INT NOT NULL DEFAULT 0
)ENGINE = InnoDB;

-- SHOW Structure Table
DESC barang;

-- Syntax create table
SHOW CREATE TABLE barang;

-- CREATE TABLE `barang` ( `id` int(11) DEFAULT NULL, `nama` varchar(100) DEFAULT NULL, `harga` int(11) DEFAULT NULL, `jumlah` int(11) DEFAULT NULL ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4	

-- Update add column table 
ALTER TABLE barang
  ADD COLUMN deskripsi VARCHAR(255),
  ADD COLUMN wrong TEXT;

-- Update delete column table 
ALTER TABLE barang
  DROP COLUMN wrong;

-- Update modify column table and move after harga
ALTER TABLE barang
  MODIFY deskripsi VARCHAR(100) AFTER jumlah;

-- Update modify column table null
ALTER TABLE barang
  MODIFY id INT NOT NULL;

-- Update modify column table default
ALTER TABLE barang
  MODIFY jumlah INT NOT NULL DEFAULT 0,
  MODIFY harga INT NOT NULL DEFAULT 0;

INSERT INTO barang(id, nama) VALUES(1, 'Mangga');
SELECT * FROM barang;

-- Remake table and clear data table
TRUNCATE barang;

-- Delete Table
DROP TABLE barang;