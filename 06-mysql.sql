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