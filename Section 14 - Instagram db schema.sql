--- Challenge section regarding Instagram DB schemas

-- CREATING THE USERS TABLE
CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (username) VALUES
('BlueTheCat'),
('CharlieBrown'),
('ColtSteele');

-- CREATING THE PHOTO TABLE
CREATE TABLE photos (
	id INT AUTO_INCREMENT PRIMARY KEY,
	image_url VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id)
);

-- CREATING THE COMMENTS TABLE
CREATE TABLE comments (
	id INT AUTO_INCREMENT PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INTEGER NOT NULL,
	photo_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (photo_id) REFERENCES photos(id)
);

-- CREATING THE LIKES TABLE
CREATE TABLE likes (
	user_id INTEGER NOT NULL,
	photo_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (photo_id) REFERENCES photos(id),
	PRIMARY KEY (user_id, photo_id)
);
-- ^^ Likes ID isn't necessary as it will not be referenced anywhere else.
-- creating a primary key of user/photo id covers all unique combinations

-- CREATING THE FOLLOWING TABLE
-- THIS is a one way relationship

CREATE TABLE follows (
	follower_id INTEGER NOT NULL,
	followee_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY (follower_id) REFERENCES users(id),
	FOREIGN KEY (followee_id) REFERENCES users(id),
	PRIMARY KEY (follower_id, followee_id)
);

-- CREATING THE HASHTAG table
-- one photo can have multiple hastags
-- one hastag can be associated with many photos
-- a many to many relationship
-- will involve 3 tables

CREATE TABLE tags (
	id INT AUTO_INCREMENT PRIMARY KEY,
	tag_name VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
	photo_id INT NOT NULL,
	tag_id INT NOT NULL,
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	FOREIGN KEY (tag_id) REFERENCES tags(id),
	PRIMARY KEY(photo_id, tag_id)
);
