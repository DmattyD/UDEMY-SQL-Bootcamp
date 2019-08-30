
--- DECIMAL Section
CREATE TABLE items(price DECIMAL(5,2));
--creates a table where there can be 3 digits in front of decimal point, and 2 digits after
 
INSERT INTO items(price) VALUES(7);
-- returns value 7.00
 
INSERT INTO items(price) VALUES(7987654);
 -- returns value 999.99
INSERT INTO items(price) VALUES(34.88);
-- returns value 34.88
 
INSERT INTO items(price) VALUES(298.9999);
 -- returns value 299.00
                                 
INSERT INTO items(price) VALUES(1.9999);
-- returns value 2.00
 
--- DATE & TIME
CREATE TABLE people (name VARCHAR(100), birthdate DATE, birthtime TIME, birthdt DATETIME);
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Padma', '1983-11-11', '10:07:35', '1983-11-11 10:07:35');
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Larry', '1943-12-25', '04:10:42', '1943-12-25 04:10:42');
 
SELECT * FROM people;
                                 
-- DATE AND TIME
                                 SELECT name, birthdate FROM people;
 
SELECT name, DAY(birthdate) FROM people;
 
SELECT name, birthdate, DAY(birthdate) FROM people;
 
SELECT name, birthdate, DAYNAME(birthdate) FROM people;
 
SELECT name, birthdate, DAYOFWEEK(birthdate) FROM people;
 
SELECT name, birthdate, DAYOFYEAR(birthdate) FROM people;
 
SELECT name, birthtime, DAYOFYEAR(birthtime) FROM people;
 
SELECT name, birthdt, DAYOFYEAR(birthdt) FROM people;
 
SELECT name, birthdt, MONTH(birthdt) FROM people;
 
SELECT name, birthdt, MONTHNAME(birthdt) FROM people;
 
SELECT name, birthtime, HOUR(birthtime) FROM people;
 
SELECT name, birthtime, MINUTE(birthtime) FROM people;
 
SELECT CONCAT(MONTHNAME(birthdate), ' ', DAY(birthdate), ' ', YEAR(birthdate)) FROM people;
 
SELECT DATE_FORMAT(birthdt, 'Was born on a %W') FROM people;
 
SELECT DATE_FORMAT(birthdt, '%m/%d/%Y') FROM people;
 
SELECT DATE_FORMAT(birthdt, '%m/%d/%Y at %h:%i') FROM people;
                                                               
-- DATE MATH
SELECT * FROM people;
 
SELECT DATEDIFF(NOW(), birthdate) FROM people;
 
SELECT name, birthdate, DATEDIFF(NOW(), birthdate) FROM people;
 
SELECT birthdt FROM people;
 
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 1 MONTH) FROM people;
 
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 10 SECOND) FROM people;
 
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 3 QUARTER) FROM people;
 
SELECT birthdt, birthdt + INTERVAL 1 MONTH FROM people;
 
SELECT birthdt, birthdt - INTERVAL 5 MONTH FROM people;
 
SELECT birthdt, birthdt + INTERVAL 15 MONTH + INTERVAL 10 HOUR FROM people;

-- TIMESTAMPS
CREATE TABLE comments (
    content VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);
 
INSERT INTO comments (content) VALUES('lol what a funny article');
 
INSERT INTO comments (content) VALUES('I found this offensive');
 
INSERT INTO comments (content) VALUES('Ifasfsadfsadfsad');
 
SELECT * FROM comments ORDER BY created_at DESC;
 
CREATE TABLE comments2 (
    content VARCHAR(100),
    changed_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
);
 
INSERT INTO comments2 (content) VALUES('dasdasdasd');
 
INSERT INTO comments2 (content) VALUES('lololololo');
 
INSERT INTO comments2 (content) VALUES('I LIKE CATS AND DOGS');
 
UPDATE comments2 SET content='THIS IS NOT GIBBERISH' WHERE content='dasdasdasd';
 
SELECT * FROM comments2;
 
SELECT * FROM comments2 ORDER BY changed_at;
 
CREATE TABLE comments2 (
    content VARCHAR(100),
    changed_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
  
 --- CHALLENGES
  
  -- Q1: good use case for CHAR 
  -- CHAR 2 - State designation
  
  -- Q2: Fill in the blanks
  CREATE TABLE inventory (
    item_name ___________,
    price _____________,
    quantity___________
    );
  --- ANSWER
  CREATE TABLE inventory (
    item_name VARCAR(100),
    price DECIMAL(8,2),
    quantity INT
    );
  
  --Q3 Difference between DATETIME and TIMESTAMP
  --A3: DATETIME - date and time formatted
  -- TIMESTAMP - a record of a chamnge at exact moment in time
  
  --Q4: PRINT OUT CurRENT TIME
  --A4
  SELECT NOW();
  
  --Q5 Print out Current Date but not time
  --A5
  SELECT CURDATE();
  
  --Q6 - Print out current day of the week
  --A6
  SELECT DAYOFWEEK(CURDATE());
  
  --Q7 - Print out name of current day of week
  --A7
  SELECT DAYNAME(CURDATE());
                 
 --Q8 - Print current day in MM/DD/YYY format
  SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');
 
  --Q9 Print Date with Name, Number and time
  SELECT DATE_FORMAT(NOW(), '%M %D at %h:%i');
                 
  -- Create a table that stores: Tweet Content, usesrname, time it was created
  CREATE TABLE tweets(
                tweet VARCHAR(280), 
                username VARCHAR(25), 
                posted TIMESTAMP DEFAULT NOW()
    );
