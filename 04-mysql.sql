-- Auto Increment => id count but if you remove middle data ,id still count
CREATE TABLE admin(
  id  INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  PRIMARY KEY (id)
)ENGINE = InnoDB; 

ALTER TABLE admin
  MODIFY first_name VARCHAR(100) NOT NULL,
  MODIFY last_name VARCHAR(100) NOT NULL;

DESC admin;  

INSERT INTO admin(first_name, last_name) VALUES('Farraz', 'Jasrial');
 ('Azka', 'Faiz Ramadhan'), ('Adilia', 'Vera');

-- Check last id
SELECT LAST_INSERT_ID(); 

SELECT * FROM admin ORDER BY id ;

-- String Function 
SELECT id, LOWER(first_name) AS 'Name Lower', 
UPPER(first_name) AS 'Name Uppder', 
LENGTH(first_name) AS 'Name Length'
FROM admin; 

-- Date Time Function(ex: EXTRACT/YEAR/MONTH)
SELECT id, created_at, 
  EXTRACT(YEAR FROM created_at) AS 'Year', 
  EXTRACT(MONTH FROM created_at) AS 'Month'
FROM products;

SELECT id, created_at, YEAR(created_at) AS 'Year', MONTH(created_at) AS 'Month' FROM products;

-- Flow Control Function with CASE (similary switch case)
SELECT id, 
  CASE category 
    WHEN 'Makanan' THEN 'Enak'
    WHEN 'Minuman' THEN 'Segar'
    ELSE 'Apa Itu?'
  END
  AS 'Category'
FROM products;

-- Flow Control IF(condition, value, value)
SELECT id, price,
  IF(price <= 20000, 'Murah', 
    IF(price >= 25000, 'Mahal', 'Apa itu mahal')
  ) AS 'Murah?'
FROM products;

-- Flow control IFNULL(change value)
SELECT id, name , IFNULL(description,'Kosong') FROM products;
