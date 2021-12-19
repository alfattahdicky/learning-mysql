-- Unique Constraint => cannot insert data duplicate to mysql 
-- Note: email_unique => name constraint (free name)
CREATE TABLE customers (
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(100) NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100),
  PRIMARY KEY(id),
  UNIQUE KEY email_unique (email)
)ENGINE = InnoDB; 

ALTER TABLE customers
  ADD CONSTRAINT email_unique UNIQUE (email);

ALTER TABLE customers
  DROP CONSTRAINT email_unique;

INSERT INTO customers(email, first_name, last_name)
VALUES ('dicky@gmail.com', 'Dicky', 'AL Fattah');

INSERT INTO customers(email, first_name, last_name)
VALUES ('al@gmail.com', 'Dicky', 'AL Fattah');

SELECT * FROM customers;

-- Check Constraint to products => use to check data before insert to database
ALTER TABLE products
  ADD CONSTRAINT price_check CHECK (price >= 1000);
ALTER TABLE products
  DROP CONSTRAINT price_check;

DESC products;
-- Error because price 900 not 1000
-- INSERT INTO products(id,name,category,price,quantity)
-- VALUES('P0006', 'CIKI', 'Makanan', 900, 1000);
SELECT * FROM products;

-- Index => optimization search data use to Balancing Tree(B-Tree) can be fast
/*
  Note: side effect create index : slow down process manipulate data
        no need index if you create PRIMARY KEY and UNIQUE constraint in table
*/
CREATE TABLE sellers(
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  -- name2 VARCHAR(100),
  -- name3 VARCHAR(100),
  -- name4 VARCHAR(100),
  PRIMARY KEY(id),
  UNIQUE KEY email_unique(email),
  INDEX name_index (name),
  -- INDEX name_index2 (name2),
  -- INDEX name_index24 (name2,name3,name4),
)ENGINE = InnoDB;

ALTER TABLE sellers
  ADD INDEX name_index(name);

ALTER TABLE sellers 
  DROP INDEX name_index;

DESC sellers;

-- Full Text Search => search full text
ALTER TABLE products 
  ADD FULLTEXT product_search (name, description);

ALTER TABLE products
  DROP INDEX product_search;
/*
  Mode Full-Text Search => 
   - Natural Language(by words), 
   - boolean, 
   - Query Expansion => twice search, first search use natural language, 
   second search similarity result first search
*/
-- Use where
SELECT * FROM products WHERE name LIKE '%goreng%' OR description LIKE '%goreng%';
-- Natural Language Mode
SELECT * FROM products 
  WHERE MATCH(name, description)
  AGAINST('goreng' IN NATURAL LANGUAGE MODE); 
-- Boolean Mode 
SELECT * FROM products 
  WHERE MATCH(name, description)
  AGAINST('+goreng -Nasi' IN BOOLEAN MODE); 
-- Query Expansion Mode
SELECT * FROM products 
  WHERE MATCH(name, description)
  AGAINST('ayam' WITH QUERY EXPANSION); 