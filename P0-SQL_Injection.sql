CREATE DATABASE User_Authentication;
CREATE DATABASE Product_Information;
CREATE DATABASE Employee_Information;

USE User_Authentication;

CREATE TABLE users (
  id INT PRIMARY KEY,
  username VARCHAR(50),
  password VARCHAR(50),
  email VARCHAR(100)
);
INSERT INTO users (id, username, password, email)
VALUES
(1, 'admin', 'password123', 'admin@example.com'),
(2, 'user1', 'pass456', 'user1@example.com'),
(3, 'user2', 'pass789', 'user2@example.com'),
(4, 'john_doe', 'jdpassword', 'john@example.com'),
(5, 'jane_doe', 'jdpw123', 'jane@example.com');
SELECT * FROM users;

CREATE TABLE user_roles (
  id INT PRIMARY KEY,
  role_name VARCHAR(50),
  description VARCHAR(100)
);
INSERT INTO user_roles (id, role_name, description)
VALUES
(1, 'Admin', 'Administrator role with full access'),
(2, 'User', 'Regular user with limited access'),
(3, 'Moderator', 'Can moderate content'),
(4, 'Editor', 'Can edit content'),
(5, 'Guest', 'Guest user with minimal access');
SELECT * FROM user_roles;

CREATE TABLE login_attempts (
  id INT PRIMARY KEY,
  username VARCHAR(50),
  attempt_date DATETIME,
  success BOOLEAN
);
INSERT INTO login_attempts (id, username, attempt_date, success)
VALUES
(1, 'admin', '2024-09-14 08:30:00', TRUE),
(2, 'user1', '2024-09-14 09:15:00', FALSE),
(3, 'john_doe', '2024-09-14 10:00:00', TRUE),
(4, 'user2', '2024-09-14 11:45:00', FALSE),
(5, 'jane_doe', '2024-09-14 12:30:00', TRUE);
SELECT * FROM login_attempts;

CREATE TABLE user_sessions (
  id INT PRIMARY KEY,
  user_id INT,
  session_start DATETIME,
  session_end DATETIME
);
INSERT INTO user_sessions (id, user_id, session_start, session_end)
VALUES
(1, 1, '2024-09-14 08:30:00', '2024-09-14 09:00:00'),
(2, 2, '2024-09-14 09:15:00', '2024-09-14 09:45:00'),
(3, 3, '2024-09-14 10:00:00', '2024-09-14 10:30:00'),
(4, 4, '2024-09-14 11:45:00', '2024-09-14 12:15:00'),
(5, 5, '2024-09-14 12:30:00', '2024-09-14 01:00:00');
SELECT * FROM user_sessions;

CREATE TABLE password_resets (
  id INT PRIMARY KEY,
  user_id INT,
  reset_date DATETIME,
  reset_token VARCHAR(100)
);
INSERT INTO password_resets (id, user_id, reset_date, reset_token)
VALUES
(1, 1, '2024-09-13 10:00:00', 'reset_token_123'),
(2, 2, '2024-09-13 11:00:00', 'reset_token_456'),
(3, 3, '2024-09-13 12:00:00', 'reset_token_789'),
(4, 4, '2024-09-13 01:00:00', 'reset_token_012'),
(5, 5, '2024-09-13 02:00:00', 'reset_token_345');
SELECT * FROM password_resets;

-- Test for SQL Injection
SELECT * FROM users WHERE username = 'user1' AND password = 'password456' OR '1'='1';

-- Time-based SQL Injection:
SELECT * FROM users WHERE username = 'user1' AND password = 'password456' OR SLEEP(5);

-- Data Manipulation
UPDATE users SET password = 'newpassword' WHERE id = 1 OR '1'='1';
UPDATE users SET password = 'password123' WHERE id = 1;

-- Sample Query to Fetch Data: 
SELECT * FROM users WHERE username = 'admin' -- ' AND password = 'password';

-- Union-Based SQL Injection:
SELECT username, password FROM users WHERE username = 'admin' UNION SELECT database(), version();

-- Blind SQL Injection Query:
SELECT * FROM users WHERE username = 'admin' AND IF(1=1, SLEEP(5), 0);

-- Error-Based SQL Injection Query
SELECT * FROM users WHERE id = 1' AND 1=2;
