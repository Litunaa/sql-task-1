
BEGIN;

-- 1. PERSON
INSERT INTO person (personal_number, first_name, last_name, phone_number, address)
VALUES
('19900101-1234', 'Anna', 'Andersson', '0701111111', 'Stockholm'),
('19850505-2345', 'Erik', 'Johansson', '0702222222', 'Uppsala'),
('19920303-3456', 'Sara', 'Nilsson', '0703333333', 'Stockholm'),
('19880707-4567', 'Johan', 'Karlsson', '0704444444', 'Solna'),
('19950505-5678', 'Emma', 'Lindberg', '0705555555', 'Stockholm'),
('19791212-6789', 'Peter', 'Berg', '0706666666', 'Uppsala'),
('19940404-7890', 'Lisa', 'Eriksson', '0707777777', 'Solna'),
('19860606-8901', 'David', 'Svensson', '0708888888', 'Stockholm');

-- 2. JOB TITLES
INSERT INTO job_title (job_title)
VALUES
('Professor'),
('Lecturer'),
('Teaching Assistant');

-- 3. DEPARTMENTS
-- Managers 1 and 4 will be inserted as employees later.
INSERT INTO department (department_name, manager_id)
VALUES
('Computer Science', 1),
('Information Technology', 4);

-- 4. EMPLOYEES
INSERT INTO employee
(personal_number, job_title_id, department_id, supervisor_id, salary)
VALUES
('19900101-1234', 1, 1, NULL, 65000.00),
('19850505-2345', 2, 1, 1, 48000.00),
('19920303-3456', 2, 1, 1, 46000.00),
('19880707-4567', 1, 2, NULL, 67000.00),
('19950505-5678', 2, 2, 4, 45000.00),
('19791212-6789', 2, 2, 4, 52000.00),
('19940404-7890', 3, 1, 1, 32000.00),
('19860606-8901', 3, 2, 4, 33000.00);

-- 5. COURSE LAYOUTS
INSERT INTO course_layout
(course_code, course_name, min_students, max_students, hp)
VALUES
('DD1337', 'Programming Basics', 20, 100, 7.50),
('DD1338', 'Database Technology', 15, 80, 7.50),
('DD1339', 'Computer Architecture', 10, 60, 6.00),
('DD1340', 'Operating Systems', 15, 70, 7.50),
('DD1341', 'Software Engineering', 20, 100, 7.50);

-- 6. COURSE INSTANCES
INSERT INTO course_instance
(num_students, study_period, study_year, course_code)
VALUES
(75, 1, 2026, 'DD1337'),
(60, 2, 2026, 'DD1338'),
(40, 3, 2026, 'DD1339'),
(55, 4, 2026, 'DD1340'),
(90, 1, 2027, 'DD1341'),
(65, 2, 2027, 'DD1337'),
(35, 3, 2027, 'DD1338'),
(50, 4, 2027, 'DD1339');

-- 7. TEACHING ACTIVITIES
INSERT INTO teaching_activity (activity_name, factor)
VALUES
('Lecture', 3.60),
('Lab', 2.40),
('Tutorial', 2.40),
('Seminar', 1.80),
('Examination', 1.00),
('Administration', 1.00),
('Others', 1.00);

-- 8. PLANNED ACTIVITIES
INSERT INTO planned_activity (planned_hours, instance_id, activity_name)
VALUES
(20, 1, 'Lecture'),
(15, 1, 'Lab'),
(10, 1, 'Tutorial'),
(12, 1, 'Examination'),
(8, 1, 'Administration'),
(18, 2, 'Lecture'),
(20, 2, 'Lab'),
(10, 2, 'Seminar'),
(10, 2, 'Examination'),
(25, 3, 'Lecture'),
(15, 3, 'Lab'),
(8, 3, 'Examination'),
(20, 4, 'Lecture'),
(15, 4, 'Tutorial'),
(12, 4, 'Examination'),
(22, 5, 'Lecture'),
(20, 5, 'Lab'),
(10, 5, 'Seminar'),
(15, 5, 'Examination'),
(18, 6, 'Lecture'),
(15, 6, 'Lab'),
(10, 7, 'Lecture'),
(12, 7, 'Tutorial'),
(20, 8, 'Lecture'),
(10, 8, 'Examination');

-- 9. EMPLOYEE SKILLS
INSERT INTO employee_skill (employment_id, skill)
VALUES
(1, 'Programming'),
(1, 'Database Design'),
(2, 'Java'),
(2, 'Software Engineering'),
(3, 'SQL'),
(3, 'Database Design'),
(4, 'Computer Architecture'),
(4, 'Operating Systems'),
(5, 'Programming'),
(6, 'Linux'),
(7, 'Teaching'),
(8, 'Networking');

-- 10. EMPLOYEE ALLOCATIONS
INSERT INTO employee_allocation (employment_id, planned_activity_id)
VALUES
(1, 1), (1, 6), (2, 2), (2, 7), (2, 16),
(3, 3), (3, 8), (3, 11), (4, 10), (4, 13),
(5, 12), (5, 17), (5, 21), (6, 14), (6, 18),
(6, 23), (7, 4), (7, 9), (7, 15), (8, 5),
(8, 19), (8, 20), (1, 22), (2, 24), (4, 25);

COMMIT;
