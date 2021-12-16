-- change name column use alias
SELECT id AS 'Kode',
       name AS 'Nama', 
       category AS 'Kategori', 
       price AS 'Harga', 
       quantity AS 'Stok' FROM products;

-- Change name table use alias
SELECT p.id AS 'Kode',
       p.name AS 'Nama', 
       p.category AS 'Kategori', 
       p.price AS 'Harga', 
       p.quantity AS 'Stok' FROM products AS p;

-- Search Data with comparison operator
SELECT * FROM products WHERE quantity > 30; 
SELECT * FROM products WHERE category != 'Minuman';
SELECT * FROM products WHERE category <> 'Minuman';
SELECT * FROM products WHERE quantity < 20;

-- Search Data with AND Operator
SELECT * FROM products WHERE quantity > 30 && price > 15000;

-- Search Data with OR Operator
SELECT * FROM products WHERE category != 'Makanan' OR quantity < 20;

-- Priority Comparison with parenthesis (Note: Calcualtion AND)
SELECT * FROM products WHERE (category != 'Makanan' OR quantity < 20) AND price > 15000;

-- Search half word/string with LIKE Operator (if huge data thousand LIKE operator not recommended)
SELECT * FROM products WHERE name LIKE '%as%';
SELECT * FROM products WHERE name LIKE 'a%';
SELECT * FROM products WHERE name LIKE '%a';

-- Search Data Null with NULL Operator
SELECT * FROM products WHERE description IS NULL;
SELECT * FROM products WHERE description IS NOT NULL;

-- Search Data with between operator alternative( price > 20000 AND price < 30000 ) 
SELECT * FROM products WHERE price BETWEEN 20000 AND 30000;
SELECT * FROM products WHERE price NOT BETWEEN 20000 AND 30000;

-- Search Data with IN Operator 
-- SELECT * FROM products WHERE category = 'Makanan' OR category = 'Minuman'; old Ways
SELECT * FROM products WHERE category IN ('Makanan', 'Minuman');
SELECT * FROM products WHERE category NOT IN ('Makanan', 'Minuman');

-- Sort Data with ORDER BY Clause (Default => Ascending)
SELECT price, name FROM products WHERE price > 15000 ORDER BY category; -- one column
SELECT id, price, category, name FROM products ORDER BY category ASC,price DESC; -- more column

-- Limit data Query use LIMIT clause (pagination)
SELECT * FROM products WHERE price > 15000 ORDER BY id LIMIT 3;
SELECT * FROM products ORDER BY id LIMIT 3;

-- Skip data query (0 => skip data, 2 => limit data)
SELECT * FROM products ORDER BY id LIMIT 0, 2;
SELECT * FROM products ORDER BY id LIMIT 2, 2;

-- Remove Data Duplicate with distinct before field name
SELECT DISTINCT category FROM products;

-- Numeric Function (Arithmetic Operator dan Mathematical Function)

-- Arithmetic Operator (%, -, +, *, /, DIV)
SELECT 10 + 10 AS 'twenty' FROM products;
SELECT id, name, price DIV 1000 AS 'Price in K' FROM products;
-- Mathematical Function
SELECT PI();
SELECT POWER(10,2);
SELECT id, COS(price), SIN(price), TAN(price) FROM products;

