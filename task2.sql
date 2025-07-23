-- 1.Create a new database named school_db
CREATE DATABASE school_db;
USE school_db;

-- 2.Create a table for students with ID and name
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 3.Create a table for courses with ID and title
CREATE TABLE courses  (
    id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

-- 4.Create a table for enrollments linking students to courses with references
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- 5.Insert sample student records
INSERT INTO students (id, name) VALUES
(1, 'Ahmad Ali'),
(2, 'Lina Sami'),
(3, 'Omar Khaled'),
(4, 'Sara Naser');

-- 6.Insert sample course records
INSERT INTO courses (id, title) VALUES
(101, 'Database Systems'),
(102, 'Software Engineering'),
(103, 'Data Structures'),
(104, 'Operating Systems');

-- 7.Add enrollments so each student is registered in at least one course
INSERT INTO enrollments (student_id, course_id) VALUES
(1, 101),
(2, 102),
(3, 101),
(3, 103),
(4, 104);

-- 8.Retrieve each student’s name with the titles of the courses they are enrolled in
SELECT s.name AS student_name, c.title AS course_title
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id;

-- 9.List the names of students who are not enrolled in any course
SELECT s.name
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
WHERE e.course_id IS NULL;

-- 10.Show the number of courses each student is enrolled in
SELECT s.name AS student_name, COUNT(e.course_id) AS course_count
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
GROUP BY s.id, s.name;

-- 11.Display the titles of courses that have no students enrolled
SELECT c.title
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
WHERE e.student_id IS NULL;

-- 12.Change the name of a specific student and show the updated data
UPDATE students
SET name = 'Mariam Turk'
WHERE id = 1;
SELECT * FROM students WHERE id = 1;

-- 13.Remove a course after deleting all its enrollments
DELETE FROM enrollments
WHERE course_id = 103;
DELETE FROM courses
WHERE id = 103;
SELECT * FROM courses;

-- 14.List students who are enrolled in both of two specific courses
SELECT s.name
FROM students s
JOIN enrollments e ON s.id = e.student_id
WHERE e.course_id IN (101, 102)
GROUP BY s.id, s.name
HAVING COUNT(DISTINCT e.course_id) = 2;

-- 15.Display the number of distinct courses per student
SELECT s.name AS student_name, COUNT(DISTINCT e.course_id) AS course_count
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
GROUP BY s.id, s.name;

-- 16.Find the course that has the highest number of enrolled students
SELECT c.title, COUNT(e.student_id) AS student_count
FROM courses c
JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.title
ORDER BY student_count DESC
LIMIT 1;

-- 17.Add a new table for teachers with ID and name
CREATE TABLE teachers (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 18.Add a teacher field to the courses and assign each course to a teacher
ALTER TABLE courses
ADD COLUMN teacher_id INT,
ADD FOREIGN KEY (teacher_id) REFERENCES teachers(id);

INSERT INTO teachers (id, name) VALUES
(1, 'Dr. Ahmad'),
(2, 'Ms. Lina'),
(3, 'Prof. Sami');

UPDATE courses SET teacher_id = 1 WHERE id = 101;
UPDATE courses SET teacher_id = 2 WHERE id = 102;
UPDATE courses SET teacher_id = 1 WHERE id = 104;

-- 19.Show the smallest and largest student ID values and the average value
SELECT 
    MIN(id) AS smallest_id,
    MAX(id) AS largest_id,
    AVG(id) AS average_id
FROM students;

-- 20.Display the alphabetically first and last course title
SELECT 
    MIN(title) AS first_course,
    MAX(title) AS last_course
FROM courses;

-- 21.Show the total number of enrollments in the system
SELECT COUNT(*) AS total_enrollments
FROM enrollments;







