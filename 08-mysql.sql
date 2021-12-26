-- Set Operator => Two query merge in one result
CREATE TABLE guestbooks(
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(100) NOT NULL,
  title VARCHAR(100) NOT NULL,
  content TEXT,
  PRIMARY KEY (id)
) ENGINE = InnoDB;

INSERT INTO guestbooks(email, title, content)
VALUE ('guest@gmail.com', 'Hello', 'Hello'),
      ('guest2@gmail.com', 'Hello', 'Hello'),
      ('guest3@gmail.com', 'Hello', 'Hello'),
      ('dicky@gmail.com', 'Hello', 'Hello'),
      ('dicky@gmail.com', 'Hello', 'Hello'),
      ('dicky@gmail.com', 'Hello', 'Hello');

-- Union => merge same data table to one produce (not duplicate)
SELECT DISTINCT email FROM customers
UNION
SELECT DISTINCT email FROM guestbooks;

-- Union All => same union but data duplicate to show query result
SELECT email FROM customers
UNION ALL
SELECT email FROM guestbooks;

SELECT email, COUNT(emails.email) FROM (
SELECT email FROM customers
UNION ALL
SELECT email FROM guestbooks) AS emails
GROUP BY emails.email;

-- Intersect => show query result query one and query two (slice)
-- Subquery
SELECT DISTINCT email FROM customers
WHERE email IN (SELECT DISTINCT email FROM guestbooks);
-- Inner Join
SELECT DISTINCT customers.email FROM customers
INNER JOIN guestbooks ON (guestbooks.email = customers.email);

-- MINUS => where first query removed by second query
SELECT DISTINCT customers.email, guestbooks.email FROM customers
LEFT JOIN guestbooks ON (guestbooks.email = customers.email)
WHERE guestbooks.email IS NULL;

/*
  Database Transaction 
      - Doing some command at once so that data consistent
      - one command process failed, so automatic before command canceled
      - a transaction success, so all command confirmed success
      - Keyword: START TRANSACTION, COMMIT, ROLLBACK
      - Only do command DML(Data Manipulation Language) like INSERT, UPDATE & DELETE
      - When use database transaction, only can look user itself
*/

-- Success Transaction
START TRANSACTION;

INSERT INTO guestbooks(email, title, content)
VALUE ('azka@gmail.com', 'Hai', 'Hai'),
       ('azka2@gmail.com', 'Hai', 'Hai'),
       ('azka3@gmail.com', 'Hai', 'Hai'); 

COMMIT;

-- Failed Transaction
START TRANSACTION;
DELETE FROM guestbooks;
ROLLBACK;

SELECT * FROM guestbooks;