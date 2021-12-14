-- Create table products
CREATE TABLE products(
  id    VARCHAR(10) NOT NULL,
  name  VARCHAR(100) NOT NULL,
  description TEXT,
  price INT UNSIGNED NOT NULL,
  quantity INT UNSIGNED NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  -- PRIMARY KEY (id, 
) ENGINE = InnoDB;

DESCRIBE products;
DROP TABLE products;

-- Insert one data products
INSERT INTO products(id, name, price, quantity)
VALUES ('P0001', 'Nasi Goreng',20000, 50);

INSERT INTO products(id, name, description, price, quantity)
VALUES ('P0002', 'Ayam Goreng', 'Ayam Goreng Surabaya' ,15000, 30);

-- Insert more data products
INSERT INTO products(id, name, price, quantity)
VALUES('P0003', 'Sop Buah', 20000, 30),
      ('P0004', 'Nasi Lemak Khas Madura', 30000, 10),
      ('P0005', 'Sop Daging', 18000, 35);
      
-- GET all column data table use *
SELECT * FROM products;

-- Get any column data table
SELECT id, name, price, quantity FROM products; 

-- Add primary key in table
ALTER TABLE products
  ADD PRIMARY KEY (id);

-- Filter Data table products with WHERE Clause
SELECT id, name, quantity FROM products WHERE quantity = 30;
SELECT * FROM products WHERE price = 20000;

-- Add column category
ALTER TABLE products
  ADD COLUMN category ENUM('Makanan', 'Minuman', 'Lain-lain')
    AFTER name;

-- update one column
UPDATE products SET category = 'Makanan' WHERE id = 'P0001';
UPDATE products SET category = 'Minuman' WHERE id = 'P0003';
UPDATE products SET category = 'Makanan' WHERE name = 'Ayam Goreng';
UPDATE products SET category = 'Makanan' WHERE price = 18000;

-- Update more column
UPDATE products SET category = 'Makanan', description = 'Nasi Lemak No. 1' WHERE id = 'P0004';

-- Update value column
UPDATE products SET price = price + 5000 WHERE id = 'P0004';

-- Delete data table
DELETE FROM products WHERE id = 'P0005';

SELECT * FROM products; 