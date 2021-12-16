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
