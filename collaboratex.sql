===========================================
-- CollaborateX Database
-- ===========================================

CREATE DATABASE IF NOT EXISTS CollaborateX;
USE CollaborateX;

-- ===========================================
-- USERS TABLE
-- ===========================================

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('Student','Lecturer','Admin') DEFAULT 'Student',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================
-- PROJECTS TABLE
-- ===========================================

CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    project_title VARCHAR(150) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ===========================================
-- FORUMS TABLE
-- ===========================================

CREATE TABLE forums (
    forum_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    topic VARCHAR(150) NOT NULL,
    message TEXT NOT NULL,
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ===========================================
-- RESOURCES TABLE
-- ===========================================

CREATE TABLE resources (
    resource_id INT AUTO_INCREMENT PRIMARY KEY,
    resource_name VARCHAR(150) NOT NULL,
    description TEXT,
    file_link VARCHAR(255),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================
-- CONTACT MESSAGES TABLE
-- ===========================================

CREATE TABLE contact_messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    subject VARCHAR(150),
    message TEXT,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================
-- PASSWORD RESETS TABLE
-- ===========================================

CREATE TABLE password_resets (
    reset_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    reset_token VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================
-- SAMPLE USERS
-- ===========================================

INSERT INTO users (full_name, email, password, role)
VALUES
('Admin User','admin@collaboratex.com','admin123','Admin'),
('John Student','john@student.com','student123','Student'),
('Mary Lecturer','mary@college.com','lecturer123','Lecturer');

-- ===========================================
-- SAMPLE PROJECTS
-- ===========================================

INSERT INTO projects (user_id, project_title, description, category)
VALUES
(2,'Website Development','Student collaboration website','Web Development'),
(2,'Database Design','MySQL Database Project','Database');

-- ===========================================
-- SAMPLE FORUM POSTS
-- ===========================================

INSERT INTO forums (user_id, topic, message)
VALUES
(2,'Welcome','Welcome to CollaborateX!'),
(3,'Assignment Help','Feel free to ask assignment questions here.');

-- ===========================================
-- SAMPLE RESOURCES
-- ===========================================

INSERT INTO resources (resource_name, description, file_link)
VALUES
('HTML Guide','Introduction to HTML','resources/html-guide.pdf'),
('MySQL Notes','Database fundamentals','resources/mysql-notes.pdf');

-- ===========================================
-- SAMPLE CONTACT MESSAGE
-- ===========================================

INSERT INTO contact_messages (full_name,email,subject,message)
VALUES
('Test User','test@example.com','General Enquiry','This is a sample contact message.');

-- ===========================================
-- END OF DATABASE
-- ===========================================
