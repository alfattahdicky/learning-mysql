-- Table Relationship => use Foreign Key to reference another table
/*
  - id_product should have same type for products id as table reference
  - if data insert into data table use foreign key should exist in table reference
  - if data was added and want to remove data in table reference will rejected by MySQL (RESTRIC)
    - Because this data use by table has foreign key 
    - Behavior Foreign Key => RESTRIC, CASCADE, NO ACTION, SET NULL 
*/
CREATE TABLE wishlist(
  id INT NOT NULL AUTO_INCREMENT,
  id_product VARCHAR(10) NOT NULL,
  description TEXT,
  PRIMARY KEY (id),
  CONSTRAINT fk_wishlist_key
    FOREIGN KEY (id_product) REFERENCES products(id)
)ENGINE = InnoDB;

-- Edit table wishtlist and add/delete foreign key 
ALTER TABLE wishlist
  DROP CONSTRAINT fk_wishlist_key;

ALTER TABLE wishlist
  ADD CONSTRAINT fk_wishlist_key
    FOREIGN KEY (id_product) REFERENCES products(id);

DESCRIBE wishlist;

INSERT INTO wishlist(id_product, description) 
VALUES('P0001', 'Sangat menggiurkan');

INSERT INTO wishlist(id_product, description) 
VALUES('test', 'Sangat menggiurkan');

INSERT INTO wishlist(id_product, description) 
VALUES('Pyyy', 'tester ajah');

-- Insert mode foreign key 
ALTER TABLE wishlist
  ADD CONSTRAINT fk_wishlist_key
    FOREIGN KEY (id_product) REFERENCES products(id)
      ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO products(id, name, category, price, quantity)
VALUES('P0006', 'Sop Ayam', 'Makanan', 13000, 10);

INSERT INTO products(id, name, category, price, quantity)
VALUES('Pyyy', 'sabeb', 'Makanan', 1000, 10);

DELETE FROM products WHERE id = 'Pyyy';

SELECT * FROM wishlist;
SELECT * FROM sellers;
SHOW CREATE TABLE sellers;
/*
  Join => combine 2/more table fit to foreign key although not rule join should foreign key
  if you join table greater than 5 then perform query heavy and slow
*/

-- Get all table join
SELECT * FROM wishlist 
JOIN products ON (wishlist.id_product = products.id);  
-- get one table join column reference
SELECT products.id, products.name, wishlist.description
FROM wishlist
JOIN products ON (products.id = wishlist.id_product);
-- get one table join column reference use alias
SELECT  w.id AS id_wishlist, 
        p.id AS id_product , 
        p.name AS product_name, 
        w.description AS product_description
FROM wishlist AS w
JOIN products AS p ON (p.id = w.id_product);

-- Edit table for relation to table customers
ALTER TABLE wishlist
  ADD COLUMN id_customer INT AFTER id_product,
  ADD CONSTRAINT fk_wishlist_customer
    FOREIGN KEY (id_customer) REFERENCES customers(id);

ALTER TABLE wishlist
  DROP id_customer,
  DROP CONSTRAINT fk_wishlist_customer;    

DESC wishlist;
SELECT * FROM customers;

UPDATE wishlist SET id_customer = 1 WHERE id = 1; 
SELECT * FROM wishlist;

-- Join Multiple Table
SELECT c.email, p.id, p.name, w.description
FROM wishlist AS w
JOIN products AS p ON (p.id = w.id_product)
JOIN customers AS c ON (c.id = w.id_customer);

-- One to One Relationship
/*
  Two Ways Create One to One
    - Create column foreign key, set the column use UNIQUE KEY so that avoid the column duplicate data  
    - Create table with the same primary key 
*/

CREATE TABLE wallet
(
  id INT NOT NULL AUTO_INCREMENT,
  id_customer INT NOT NULL,
  balance INT NOT NULL DEFAULT 0,
  PRIMARY KEY(id),
  UNIQUE KEY fk_id_customer_unique(id_customer),
  CONSTRAINT fk_wallet_customer
    FOREIGN KEY (id_customer) REFERENCES customers(id) 
)ENGINE = InnoDB;

SELECT * FROM wallet;
INSERT INTO wallet(id_customer) VALUES (1), (3);

SELECT wl.balance, c.email
FROM wallet AS wl JOIN customers AS c ON (wl.id_customer = c.id);

-- One to Many Relationship

-- Create table categories
CREATE TABLE categories(
  id VARCHAR(10) NOT NULL,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY(id)
)ENGINE = InnoDB;  

-- Delete column category and create column id_category then 
-- make foreign key id_category references to categories id
ALTER TABLE products
  DROP COLUMN category;

ALTER TABLE products
  ADD COLUMN id_category VARCHAR(10);

ALTER TABLE products
  ADD CONSTRAINT fk_products_category
    FOREIGN KEY (id_category) REFERENCES categories(id);

SELECT * FROM products;

-- Insert id, name for categories
INSERT INTO categories(id,name) 
VALUES ('C0001','Makanan'),
       ('C0002', 'Minuman'),
       ('C0003', 'Lain-lain'); 

SELECT * FROM categories;

-- update products on id_category use id categories
UPDATE products SET id_category = 'C0001'
WHERE id IN ('P0001', 'P0002', 'P0004', 'P0005', 'P0006');

UPDATE products SET id_category = 'C0002'
WHERE id IN ('P0003');

-- Join table products and categories to show 
SELECT products.id, products.name, categories.name
FROM products
JOIN categories ON (categories.id = products.id_category); 

-- Many to many Relationship
/*
  Solving create table relationship between table have many to many
*/
-- Create table order
CREATE TABLE orders
(
  id INT NOT NULL AUTO_INCREMENT,
  total INT NOT NULL,
  order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
)ENGINE = InnoDB;

-- Create Table order detail bridge order and products

CREATE TABLE orders_detail
(
  id_product VARCHAR(10) NOT NULL,
  id_order INT NOT NULL,
  price INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (id_product, id_order)
)ENGINE = InnoDB;

-- Add foreign key to orders_detail for product(id) and orders(id)
ALTER TABLE orders_detail
  ADD CONSTRAINT fk_orders_detail_product
    FOREIGN KEY (id_product) REFERENCES products (id);

ALTER TABLE orders_detail
  ADD CONSTRAINT fk_orders_detail_order
    FOREIGN KEY (id_order) REFERENCES orders (id);

DESC orders_detail;

-- Insert data to order and orders_detail
INSERT INTO orders(total) VALUES(50000);

INSERT INTO orders_detail(id_product, id_order, price, quantity)
VALUES ('P0001', 1, 25000, 1),
        ('P0002', 1, 25000, 1);
INSERT INTO orders_detail(id_product, id_order, price, quantity)
VALUES ('P0003', 2, 25000, 1),
        ('P0004', 2, 25000, 1);

SELECT * FROM orders_detail; 

SELECT orders.id, products.id, products.name, orders_detail.quantity, orders_detail.price FROM orders
JOIN orders_detail ON (orders_detail.id_order = orders.id)
JOIN products ON (products.id = orders_detail.id_product);