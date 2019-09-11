-- 1. FIND the 5 oldest users
-- DESC users;
Select * FROM users ORDER BY created_at LIMIT 5;
    
-- 2. What is the most popular registration date?
-- need to figure out when to schedule an ad campaign
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;

-- 3. Who has never posted a photo?
-- find the users who have never posted a photo
SELECT username
FROM users
LEFT JOIN photos 
ON users.id = photos.user_id 
WHERE photos.id IS NULL;

-- 4. Who got the most likes on a single photo?
-- find the user with the most likes
SELECT 
	photos.id, 
	photos.image_url, 
    COUNT(*) AS total_likes
FROM photos
INNER JOIN likes
ON likes.photo_id = photos.id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;
-- ^ the above is the query for the most liked photo

SELECT 
	photos.id, 
	photos.image_url, 
    users.username,
    COUNT(*) AS total_likes
FROM photos
INNER JOIN likes
	ON likes.photo_id = photos.id
INNER JOIN users
	ON photos.user_id = users.id
    -- SECOND JOIN ABOVE!!! THIS IS WHERE USER IS ADDED
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;
-- ^^ this query is with the aditional join for the user name
