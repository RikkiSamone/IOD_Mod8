-- @block 
USE blogapp;

-- @block
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    bio TEXT,
    profile_picture VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- @block
INSERT INTO users (username, email, password_hash, bio, profile_picture)
VALUES
('john_doe', 'johndoe@example.com', 'hashedpassword123', 'Tech enthusiast and blogger.', 'profilepic.png'),
('RikkiSamone', 'rikkisamone@email.com', 'hashedpasswordabc123', 'Student', 'profile1.png');

-- @block
SELECT *
FROM users


-- @block
CREATE TABLE posts(
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- @block
INSERT INTO posts(user_id, title, content)
VALUES
(1, 'My First Blog Post', 'Welcome to my first blog post!'),
(2, 'How to Blog', 'Tips and tricks on how to make an engaging blog post');

-- @block
SELECT *
FROM posts


-- @block
CREATE TABLE comments(
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  post_id INT,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- @block
SELECT *
FROM comments

-- @block
INSERT INTO comments(user_id, post_id, content)
VALUES
(1, 2, 'Super Helful tips'),
(2, 1, 'Awesome Content!');

-- @block
CREATE TABLE likes(
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  post_id INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (post_id) REFERENCES posts(id),
  UNIQUE (user_id, post_id)  -- Ensure each user can like a post only once
); 

-- @block
INSERT INTO likes (user_id, post_id)
VALUES
(2, 1),
(1, 2);