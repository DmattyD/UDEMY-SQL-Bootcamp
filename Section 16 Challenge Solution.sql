-- Challenges to Section 16

# Challenge 1 - valid
# Find the earliest date a user joined
SELECT 
	DATE_FORMAT(MIN(created_at), '%M %D %Y') AS earliest_date 
	FROM users ;
# ^^^ DATE FORMAT with '%M %D %Y is how to convert to the written calendar date

# Challenge 2 - kinda valid
# Find email of earliest user 
SELECT * FROM users 
	WHERE created_at = (SELECT MIN(created_at) 
	FROM users;

# Challenge 3 - not valid
# Order users according to the month they joined
# SELECT COUNT({fn MONTHNAME(created_at)}) as Count from users group by month
# ^^^ I failed this challenge
SELECT 
	MONTHNAME(created_at) as Month,
	COUNT(*) as Count
	FROM users GROUP BY Month
	ORDER BY COUNT(*) DESC;
						

# CHALLENGE 4 - valid
# Count the number of users with yahoo emails
SELECT COUNT(email) AS yahoo_users from users WHERE email Like '%@yahoo.com';

# Challenge 5 - not valid lol
# Count the total number of users for each email host
SELECT 
	CASE 
	WHEN email like '%yahoo.com' THEN "yahoo" 
	WHEN email like '%gmail.com' THEN "gmail" 
	WHEN email like '%hotmail.com' THEN "hotmail" 
	ELSE 'other' 
	END AS provider, 
		COUNT(*) total_users FROM users 
		GROUP BY provider 
		ORDER BY total_users DESC;
