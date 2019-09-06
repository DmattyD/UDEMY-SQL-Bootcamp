-- three types of relationships
-- ONE to ONE
-- ONE to MANY - this is the most common relationship
-- MANY to MANY

CREATE TABLE customer(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(100),
);

CREATE TABLE orders(
	id INT AUTO_INCREMENT PRIMARY KEY,
	order_date DATE,
	amount DECIMAL(8,2),
	customer_id INT,
	FOREIGN KEY(customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

-- SUBQUERY EXAMPLE
SELECT * FROM orders WHERE customer_id =
	(
		SELECT id FROM customers
		WHERE last_name='George'
		);
		

-- JOIN EXAMPLE
SELECT * FROM customers, orders;
-- the above is a CROSS JOIN, where the two tables are combined in every combination possible


SELECT * FROM customers, orders WHERE customers.id = orders.customer_id;
-- Also known as an implicit join

-- EXPLICIT INNER JOIN
SELECT * FROM customers
JOIN orders
	ON customers.id = orders.customer_id;
	
SELECT first_name, last_name, order_date, amount FROM customers
JOIN orders
	ON customers.id = orders.customer_id;

SELECT * FROM orders
JOIN customers
	ON customers.id = orders.customer_id;
	
-- GETTING FANCY
SELECT first_name, last_name, order_date, amount FROM customers
JOIN orders
	ON customers.id = orders.customer_id
	GROUP BY orders.customer_id;
	
SELECT
	first_name,
	last_name,
	SUM(amount) AS total_spent
FROM customers
JOIN orders
	ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;


-- LEFT JOINS
SELECT * FROM customers
LEFT JOIN orders
	ON customers.id = orders.customer_id;
-- grabs everything from the customers table.
-- if values are not present for both tables, NULL is the response

SELECT 
	first_name,
	last_name,
	IFNULL(SUM(amount), 0) AS total_spent
FROM customers
LEFT JOIN orders
	ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent DESC;

-- RIGHT JOINS
SELECT * FROM customers
RIGHT JOIN orders
	ON customer_id = orders.customer_id;

-- JOINS Exerecises PART 1 ----------------------------------

-- Create a schema with students table and papers table
CREATE TABLE students(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50)
	);
	
CREATE TABLE papers(
	title VARCHAR(50),
	grade INT,
	student_id INT,
	FOREIGN KEY(student_id) REFERENCES students(id)
	);

-- Print a table with only the graded papers in descending order
SELECT 
	first_name,
	title,
	grade,
FROM students LEFT JOIN papers ON student_id = students.id
WHERE grade IS NOT NULL
ORDER BY grade DESC;

-- Print a table with name, title, and grade from the two tables with NULL values included
SELECT 
	first_name,
	title,
	grade,
FROM students LEFT JOIN papers ON student_id = students.id;

-- Print the above, but replace NULL with Missing / 0
SELECT 
	first_name,
	IFNULL(title, 'MISSING'),
	IFNULL(grade, 0)
FROM students LEFT JOIN papers ON student_id = students.id;

-- Print the average of the scores
SELECT
	first_name,
	IFNULL(AVG(grade),0) AS Average
FROM students LEFT JOIN papers ON student_id = students.id
GROUP BY students.id
ORDER BY grade DESC;
-- GROUP BY is required otherwise it will average all the scores

-- Print student, average, and if passing or failing - 75.00 and above is passing - this is a case statement
SELECT
	first_name,
	IFNULL(AVG(grade),0) AS Average
	CASE
		WHEN AVG(grade) >= 75 THEN 'Passing'
		WHEN AVG(grade) IS NULL THEN 'Failing'
		ELSE 'Failing'
	end AS passing_status
FROM students LEFT JOIN papers ON student_id = students.id
GROUP BY students.id
ORDER BY grade DESC;
