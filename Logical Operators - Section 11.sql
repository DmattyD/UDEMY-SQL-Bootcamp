-- Locial Operators
  -- adding logic to SQL statements
  
  '!=' = NOT EQUAL
  
  SELECT title FROM books WHERE released_year !=2017
  -- above will return every book EXCEPT those published in 2017.

-- NOT LIKE
  -- the opposite of LIKE

SELECT title FROM books WHERE title NOT LIKE 'W%';
-- will return all books that DO NOT START with 'W'

-- GREATERT THAN - represented by >
SELECT title, released_year FROM books WHERE released_year > 2000;

-- >= - means Greater than OR equal to

-- when compairing strings, CASE does not matter

SELECT title, released_year FROM books 
WHERE released_year >= 2000 ORDER BY released_year;
--- all books published after 2000, including those from 2000

-- < - less than
-- opposite of greater than


--- && - the LOGICAL AND
-- BOTH parts must be true to return the values
-- keyword is AND or can be represented by &&
-- not limited to 2 statements

SELECT * FROM books WHERE author_lname='EGGERS' AND released_year > 2010;
-- will select books written by Eggers after 2010.

Select * from books WHERE author_lname='Eggers' && released_year > 2010 AND title LIKE '%novel%';
-- will return any books from Eggers after 2010 that contain the word 'Novel'

-- Logical OR
-- || / OR
-- will return values when 1 or more of the conditions is true
SELECT * FROM books WHERE author_lname='EGGERS' OR released_year > 2010;
-- will select all books by Eggers, OR every book published after 2010
-- can chain multiple OR statements.


-- BETWEEN
-- a combination of WHERE and Less Than or Greater than

-- NOT BETWEEN
-- everything outside of the selected bounds

-- CAST() - can change string values to DATE, tTIME, or DATETIME

SELECT CAST('2017-05-02' AS DATETIME);
-- will result in 2017-05-02 00:00:00

-- IN / NOT IN
SELECT title, author_lname FROM books WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
-- will return all books written by the above 3 authors
-- faster than multiple OR statements

-- NOT IN - excludes values from the query

-- % or MODULO
-- tests for remainder
SELECT title, released_year FROM books WHERE released_year >= 2000 AND released_year & 2 != 0;
-- returns all books released in odd years after 2000

-- CASE Statments
SELECT title, rleased_year, 
   CASE 
    WHEN released_year >= 2000 
      THEN 'Modern Lit'
      ELSE '20th Century Lit' 
    END AS GENRE 
  FROM books;
  -- will add a genre category to the table based on published year
  
  SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books; 
--- will add Stock category with appropriate number of *'s depending on stock_quantity.

//// CHALLENGE Questions and Solutions

-- Evaluate the following:
SELECT 10 != 10
-- will evaluate to 0 or false,  as 10 IS equal to 10

SELECT 15 > 14 && 99 - 5 <= 94;
-- will evaluate to 1 or true

SELECT 1 IN (5,3) || 9 BETWEEN 8 AND 10;
-- will evaluate to 1 because one of the statments is true

--Select all books written before 1980
SELECT title FROM books WHERE release_year <1980

-- Select all books written by Eggers or Chabon
SELECT title, author_lname FROM books WHERE author_lname IN ('Eggers', 'Chabon');

-- Select all books written by Lahiri, published after 2000
SELECT title, author_lname 
FROM books WHERE author_lname = 'Lahiri'
AND released_year >= 2000;

-- Select all books with pagecounts between 100 and 200
SELECT title, pages FROM books 
WHERE pages BETWEEN 100 and 200;

-- Select all books where author_lname stars with 'C' or 'S'
SELECT title, author_lname FROM books 
WHERE author_lname LIKE 'C%' ||
author_lname LIKE 'S%';

-- If title contains 'stories' - make it a short story, 'just kids' & 'a heartbreaking novel' - memoir, ' everything else - Novel
SELECT title, author_lname,
  CASE
    WHEN title LIKE '%stories% THEN 'Short Stories'
    WHEN title LIKE 'Just Kids' THEN 'Memoir'
    WHEN title LIKE '%heartbreaking%' THEN 'Memoir'
    ELSE 'Novel'   
  END AS Type
  FROM books;
  
  -- Group the books by author, along with the pluralized number of books
  SELECT author_lname, 
    CASE
      WHEN COUNT(*) = 1 THEN '1 BOOK'
      ELSE CONCAT(COUNT(*), ' books')
    END AS COUNT
  FROM books
  GROUP BY author_lname, author_fname;
