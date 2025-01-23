CREATE DATABASE lab3;

USE lab3;

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    registration_date DATE,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

INSERT INTO students (first_name, last_name, date_of_birth, email, city) VALUES
('Alice', 'Johnson', '2001-05-14', 'alice.johnson@example.com', 'Almaty'),
('Bob', 'Smith', '2000-09-20', 'bob.smith@example.com', 'New York'),
('Cathy', 'Williams', '2002-01-10', 'cathy.williams@example.com', 'Almaty'),
('David', 'Brown', '1999-03-22', 'david.brown@example.com', 'Los Angeles');

INSERT INTO courses (course_code, course_name, credits) VALUES
('CS101', 'Introduction to Computer Science', 4),
('MATH201', 'Calculus I', 3),
('PHYS301', 'General Physics', 3),
('HIST101', 'World History', 2);

INSERT INTO registration (student_id, course_id, registration_date, grade) VALUES
(1, 1, '2023-09-01', NULL),
(2, 2, '2023-09-01', NULL),
(3, 3, '2023-09-01', NULL),
(4, 1, '2023-09-01', NULL),
(1, 4, '2023-09-01', NULL);

SELECT last_name FROM students;

SELECT DISTINCT last_name FROM students;

SELECT * FROM students WHERE last_name = 'Johnson';

SELECT * FROM students WHERE last_name IN ('Johnson', 'Smith');

SELECT s.* FROM students s
JOIN registration r ON s.student_id = r.student_id
JOIN courses c ON r.course_id = c.course_id
WHERE c.course_code = 'CS101';

SELECT s.* FROM students s
JOIN registration r ON s.student_id = r.student_id
JOIN courses c ON r.course_id = c.course_id
WHERE c.course_code IN ('MATH201', 'PHYS301');

SELECT SUM(credits) AS total_credits FROM courses;

SELECT r.course_id, COUNT(*) AS number_of_students
FROM registration r
GROUP BY r.course_id;

SELECT r.course_id
FROM registration r
GROUP BY r.course_id
HAVING COUNT(*) > 2;

SELECT course_name
FROM courses
ORDER BY credits DESC
LIMIT 1 OFFSET 1;

SELECT s.first_name, s.last_name
FROM students s
JOIN registration r ON s.student_id = r.student_id
JOIN courses c ON r.course_id = c.course_id
WHERE c.credits = (SELECT MIN(credits) FROM courses);

SELECT first_name, last_name FROM students WHERE city = 'Almaty';

SELECT * FROM courses
WHERE credits > 3
ORDER BY credits ASC, course_id DESC;

UPDATE courses
SET credits = credits - 1
WHERE course_id = (SELECT course_id FROM courses ORDER BY credits ASC LIMIT 1);

UPDATE registration
SET course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101')
WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'MATH201');

DELETE FROM registration
WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101');

DELETE FROM students;
