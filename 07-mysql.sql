-- Types Join
-- Inner Join (Default Join MySQL) => slice data between table relationship

SELECT * FROM categories;

INSERT INTO categories(id, name)
VALUES('C0004', 'Gadget'),
      ('C0005', 'Elektronik');

SELECT * FROM products;
INSERT INTO products(id, name, price, quantity)
VALUES ('X0001', 'X Satu', 30000, 100),
       ('X0002', 'X Tiga', 15000, 20);  

SELECT * FROM categories
INNER JOIN products ON (products.id_category = categories.id);


-- Left join => get all data in first table and slice data and if not have relation on table two, result null
SELECT * FROM categories
LEFT JOIN products ON (products.id_category = categories.id); 

/* Right Join => get all data in two table and slice data table 
    and if not have relation on table two, result null
*/

SELECT * FROM categories 
RIGHT JOIN products ON (products.id_category = categories.id);

-- Cross Join => Join seldom use and multiple first table and two table
SELECT * FROM categories
CROSS JOIN products;

CREATE TABLE numbers(
  id INT NOT NULL,
  PRIMARY KEY(id)
)ENGINE = InnoDB;

INSERT INTO numbers(id) VALUES (1),(2),(3),(5),(6),(7),(8),(9),(10);

SELECT numbers1.id, numbers2.id, (numbers1.id * numbers2.id) FROM numbers AS numbers1 
    CROSS JOIN numbers AS numbers2
    ORDER BY numbers1.id, numbers2.id;

DROP table numbers;

-- Subquery => select query in use another select query
-- Manual
SELECT AVG(price) FROM products;
SELECT * FROM products WHERE price > 21375; 
-- Use Subquery on Where Clause
SELECT * FROM products WHERE price > (SELECT AVG(price) FROM products); 

-- Use Subquery on FROM clause 
UPDATE products
SET price = 1000000
WHERE id = 'X0001';
SELECT MAX(price) FROM products;

SELECT MAX(cp.price) FROM (
  SELECT price FROM categories 
  JOIN products ON (products.id_category = categories.id)) 
  AS cp;


