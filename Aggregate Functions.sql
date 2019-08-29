

--COUNT Notes
SELECT COUNT(*) FROM books;

SELECT COUNT(author_fname) FROM books;
-- returns total number, not unique count;

SELECT COUNT(DISTINCT author_fname) FROM books;
-- counts the unique authors

SELECT COUNT(DISTINCT author_lname, author_fname) FROM books;
-- adds additional filter for potential multiple last names
 
SELECT title FROM books WHERE title LIKE '%the%';
-- selects all the books containing 'the'
 
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';
-- 'counts the books containing 'the'

--GROUP BY Notes

SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname;
-- returns the count of the unique books by author;

SELECT title, author_lname FROM books;
 
SELECT title, author_lname FROM books
GROUP BY author_lname
SELECT author_lname, COUNT(*) 
FROM books GROUP BY author_lname;
 
 
SELECT title, author_fname, author_lname FROM books;
 
SELECT title, author_fname, author_lname FROM books GROUP BY author_lname;
 
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname;
 
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname;
 
SELECT released_year FROM books;
 
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;
 
SELECT CONCAT('In ', released_year, ' ', COUNT(*), ' book(s) released') AS year FROM books GROUP BY released_year;

-- MAX AND MIN
SELECT MIN(released_year) 
FROM books;
 
SELECT MIN(released_year) FROM books;
 
SELECT MIN(pages) FROM books;
 
SELECT MAX(pages) 
FROM books;
 
SELECT MAX(released_year) 
FROM books;
 
SELECT MAX(pages), title
FROM books;

--SUBQUERIES and potential issues with MIN/MAX
SELECT * FROM books 
WHERE pages = (SELECT Min(pages) 
                FROM books); 
 
SELECT title, pages FROM books 
WHERE pages = (SELECT Max(pages) 
                FROM books); 

-- Runs 2 distinct queries
SELECT title, pages FROM books 
WHERE pages = (SELECT Min(pages) 
                FROM books); 
 
SELECT * FROM books 
ORDER BY pages ASC LIMIT 1;
 
-- much faster
SELECT title, pages FROM books 
ORDER BY pages ASC LIMIT 1;
 
SELECT * FROM books 
ORDER BY pages DESC LIMIT 1;

--- MIN / MAX and GROUP BY
-- Find the year each author published their first book
SELECT author_fname, author_lname, MIN(released_year) FROM books GROUP BY author_lname, author_fname;

SELECT author_fname, 
       author_lname, 
       Min(released_year) 
FROM   books 
GROUP  BY author_lname, 
          author_fname;
 
SELECT
  author_fname,
  author_lname,
  Max(pages)
FROM books
GROUP BY author_lname,
         author_fname;
 
SELECT
  CONCAT(author_fname, ' ', author_lname) AS author,
  MAX(pages) AS 'longest book'
FROM books
GROUP BY author_lname,
         author_fname;

-- SUM 
SELECT SUM(pages)
FROM books;
 
SELECT SUM(released_year) FROM books;
 
SELECT author_fname,
       author_lname,
       Sum(pages)
FROM books
GROUP BY
    author_lname,
    author_fname;
 
SELECT author_fname,
       author_lname,
       Sum(released_year)
FROM books
GROUP BY
    author_lname,
    author_fname;
    
--- AVG
SELECT SUM(pages)
FROM books;
 
SELECT SUM(released_year) FROM books;
 
SELECT author_fname,
       author_lname,
       Sum(pages)
FROM books
GROUP BY
    author_lname,
    author_fname;
 
SELECT author_fname,
       author_lname,
       Sum(released_year)
FROM books
GROUP BY
    author_lname,
    author_fname;

-- CHALLENGE SECTION SOLUTIONS
ELECT COUNT(*) FROM books;
 
SELECT COUNT(*) FROM books GROUP BY released_year;
 
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;
 
SELECT Sum(stock_quantity) FROM BOOKS;
 
SELECT AVG(released_year) FROM books GROUP BY author_lname, author_fname;
 
SELECT author_fname, author_lname, AVG(released_year) FROM books GROUP BY author_lname, author_fname;
 
SELECT CONCAT(author_fname, ' ', author_lname) FROM books
WHERE pages = (SELECT Max(pages) FROM books);
 
SELECT CONCAT(author_fname, ' ', author_lname) FROM books
ORDER BY pages DESC LIMIT 1;
 
SELECT pages, CONCAT(author_fname, ' ', author_lname) FROM books
ORDER BY pages DESC;
 
SELECT released_year AS year,
    COUNT(*) AS '# of books',
    AVG(pages) AS 'avg pages'
FROM books
    GROUP BY released_year;
