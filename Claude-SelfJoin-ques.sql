-- It is present in the database 'claude-sf' (claude self-join)
-- Create Tables
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    manager_id INT,
    department_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    level VARCHAR(20),
    office_location VARCHAR(50),
    mentor_id INT
);

CREATE TABLE organization_chart (
    position_id INT PRIMARY KEY,
    position_title VARCHAR(100),
    reports_to_position INT,
    pay_grade VARCHAR(10),
    department_id INT,
    min_salary DECIMAL(10,2),
    max_salary DECIMAL(10,2)
);

-- Insert Sample Data for Employees
INSERT INTO employees VALUES
(1, 'John', 'Smith', NULL, 1, 120000.00, '2015-01-15', 'Executive', 'New York', NULL),
(2, 'Sarah', 'Johnson', 1, 1, 95000.00, '2016-03-20', 'Senior', 'New York', 1),
(3, 'Michael', 'Brown', 1, 2, 90000.00, '2016-06-10', 'Senior', 'Boston', 1),
(4, 'Emily', 'Davis', 2, 1, 75000.00, '2017-01-05', 'Mid-Level', 'New York', 2),
(5, 'James', 'Wilson', 2, 1, 72000.00, '2017-02-15', 'Mid-Level', 'New York', 2),
(6, 'Lisa', 'Anderson', 3, 2, 71000.00, '2018-04-20', 'Mid-Level', 'Boston', 3),
(7, 'Robert', 'Taylor', 3, 2, 70000.00, '2018-07-12', 'Mid-Level', 'Boston', 3),
(8, 'Jennifer', 'Martinez', 4, 1, 60000.00, '2019-09-30', 'Junior', 'New York', 4),
(9, 'William', 'Thomas', 5, 1, 59000.00, '2019-01-10', 'Junior', 'New York', 5),
(10, 'Elizabeth', 'Garcia', 6, 2, 58000.00, '2019-03-15', 'Junior', 'Boston', 6),
(11, 'David', 'Miller', 6, 2, 57000.00, '2020-05-20', 'Junior', 'Boston', 6),
(12, 'Mary', 'White', 7, 2, 56000.00, '2020-08-11', 'Junior', 'Boston', 7),
(13, 'Joseph', 'Clark', 4, 1, 55000.00, '2021-02-15', 'Junior', 'New York', 4),
(14, 'Patricia', 'Lee', 5, 1, 54000.00, '2021-06-22', 'Junior', 'New York', 5),
(15, 'Christopher', 'Walker', 7, 2, 53000.00, '2021-09-30', 'Junior', 'Boston', 7);

-- Insert Sample Data for Organization Chart
INSERT INTO organization_chart VALUES
(1, 'Chief Executive Officer', NULL, 'E5', 1, 110000.00, 180000.00),
(2, 'Senior Manager - Engineering', 1, 'E3', 1, 90000.00, 140000.00),
(3, 'Senior Manager - Operations', 1, 'E3', 2, 85000.00, 135000.00),
(4, 'Engineering Team Lead', 2, 'E2', 1, 70000.00, 110000.00),
(5, 'QA Team Lead', 2, 'E2', 1, 65000.00, 100000.00),
(6, 'Operations Team Lead', 3, 'E2', 2, 65000.00, 100000.00),
(7, 'Logistics Team Lead', 3, 'E2', 2, 65000.00, 100000.00),
(8, 'Software Engineer', 4, 'E1', 1, 50000.00, 85000.00),
(9, 'QA Engineer', 5, 'E1', 1, 45000.00, 80000.00),
(10, 'Operations Analyst', 6, 'E1', 2, 45000.00, 80000.00),
(11, 'Logistics Coordinator', 7, 'E1', 2, 45000.00, 80000.00);

-- Practice Questions

/* Easy Questions (1-5) */
-- Q1: List all employees along with their manager's name
-- Q2: Find all employees who work in the same department as employee ID 4
-- Q3: Display all employees who were hired in the same year
-- Q4: Show all employees who have the same manager as employee ID 8
-- Q5: List all employees who work in the same office location as employee ID 2

/* Moderate Questions (6-15) */
-- Q6: Find all pairs of employees who have the same salary
-- Q7: Display employees who have a higher salary than their managers
-- Q8: List all employees who were hired later than their managers
-- Q9: Find all employees who have the same manager and level
-- Q10: Show pairs of employees who are each other's mentors
-- Q11: List employees who have a higher salary than their mentors
-- Q12: Find employees who were hired within 90 days of each other in the same department
-- Q13: Display employees who have the same manager but different levels
-- Q14: Show employees who have a lower salary than the average salary of their manager's other direct reports
-- Q15: Find all employees who have the same level but a salary difference of more than 5000

/* Hard Questions (16-20) */
-- Q16: Find all employees who are managed by someone in a lower pay grade than themselves (using organization_chart)
-- Q17: Display the hierarchy of employees (level 1, 2, 3 deep) who all have salaries within 10000 of each other
-- Q18: Find employees who have a higher salary than all employees who joined before them in their department
-- Q19: List employees who are managed by someone who is also managed by their mentor
-- Q20: Find all groups of three or more employees who share the same manager, were hired within 180 days of each other, and have salaries within 5000 of each other