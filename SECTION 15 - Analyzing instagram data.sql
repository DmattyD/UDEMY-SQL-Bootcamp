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

-- 5. How many times does the average user post?
-- CALCULATE average number of photos per user
SELECT COUNT(*) FROM photos;
SELECT COUNT(*) from users;

SELECT
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS Average ;
    
-- 6. What are the top 5 hastags?

SELECT * FROM tags;
SELECT * FROM photo_tags;

SELECT 
tag_id,
tag_name,
COUNT(*) AS total
FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY tag_name
ORDER BY total DESC
LIMIT 5;

-- 7. Find users who have liked every single post
-- FIND THE BOTS

SELECT 
	username,
    COUNT(*) AS num_likes
FROM users
INNER JOIN likes on likes.user_id = users.id
GROUP BY username
HAVING num_likes = (SELECT COUNT(*) FROM photos);
-- HAVING in this case is similar to WHERE, and the subquery makes this query dynamic
-- it also limits this to the number of photos and will auto-update as opposed to being hardcoded.

-- CREATE a trigger to prevent self-follows;
DELIMITER $$
CREATE TRIGGER prevent_self_follows
	BEFORE INSERT ON follows FOR EACH ROW
    BEGIN
		IF NEW.follower_id = New.followee_id
		THEN
			SIGNAL sqlstate '45000'
            SET MESSAGE_TEXT = 'Cannot follow yourself';
		END IF;
        END;
$$
DELIMITER ;

-- UNFOLLOWS Trigger
DELIMITER $$ 
CREATE TRIGGER capture_unfollow
	AFTER DELETE ON follows FOR EACH ROW
    BEGIN
		INSERT INTO unfollows
        SET 
        follower_id = OLD.follower_id,
        followee_id = OLD.followee_id;
        END;
$$

DELIMITER ;

SELECT * from follows LIMIT 5;

DELETE FROM follows WHERE follower_id = 2 AND followee_id = 1;

SELECT * from unfollows;

-- SHOW triggers
SHOW TRIGGERS;

-- DROP TRIGGER trigger_name - how to drop a trigger;
