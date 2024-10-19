-- Create Tables
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    hire_date DATE,
    department_id INT,
    salary DECIMAL(10,2),
    manager_id INT,
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50),
    budget DECIMAL(15,2)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    department_id INT,
    project_budget DECIMAL(15,2),
    status VARCHAR(20)
);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50),
    hours_allocated INT,
    PRIMARY KEY (employee_id, project_id)
);

-- Insert Sample Data
INSERT INTO departments VALUES
(1, 'Engineering', 'New York', 2000000.00),
(2, 'Marketing', 'Los Angeles', 1500000.00),
(3, 'HR', 'Chicago', 800000.00),
(4, 'Sales', 'Boston', 1800000.00),
(5, 'Research', 'San Francisco', 2500000.00);

INSERT INTO employees VALUES
(1, 'John', 'Smith', 'john.smith@email.com', '555-0101', '2020-01-15', 1, 85000.00, NULL, 'New York', 'USA'),
(2, 'Sarah', 'Johnson', 'sarah.j@email.com', '555-0102', '2020-03-20', 1, 75000.00, 1, 'New York', 'USA'),
(3, 'Michael', 'Brown', 'michael.b@email.com', '555-0103', '2020-06-10', 2, 65000.00, NULL, 'Los Angeles', 'USA'),
(4, 'Emily', 'Davis', 'emily.d@email.com', '555-0104', '2021-01-05', 2, 62000.00, 3, 'Los Angeles', 'USA'),
(5, 'James', 'Wilson', 'james.w@email.com', '555-0105', '2021-02-15', 3, 55000.00, NULL, 'Chicago', 'USA'),
(6, 'Lisa', 'Anderson', 'lisa.a@email.com', '555-0106', '2021-04-20', 3, 52000.00, 5, 'Chicago', 'USA'),
(7, 'Robert', 'Taylor', 'robert.t@email.com', '555-0107', '2021-07-12', 4, 71000.00, NULL, 'Boston', 'USA'),
(8, 'Jennifer', 'Martinez', 'jennifer.m@email.com', '555-0108', '2021-09-30', 4, 68000.00, 7, 'Boston', 'USA'),
(9, 'William', 'Thomas', 'william.t@email.com', '555-0109', '2022-01-10', 5, 90000.00, NULL, 'San Francisco', 'USA'),
(10, 'Elizabeth', 'Garcia', 'elizabeth.g@email.com', '555-0110', '2022-03-15', 5, 82000.00, 9, 'San Francisco', 'USA');

INSERT INTO projects VALUES
(1, 'Mobile App Development', '2023-01-01', '2023-06-30', 1, 500000.00, 'Completed'),
(2, 'Website Redesign', '2023-03-15', '2023-08-31', 2, 300000.00, 'In Progress'),
(3, 'Employee Training Program', '2023-02-01', '2023-12-31', 3, 150000.00, 'In Progress'),
(4, 'Sales Analytics Platform', '2023-04-01', '2023-09-30', 4, 400000.00, 'In Progress'),
(5, 'AI Research Initiative', '2023-01-15', '2023-12-31', 5, 800000.00, 'In Progress'),
(6, 'Cloud Migration', '2023-05-01', '2023-10-31', 1, 600000.00, 'In Progress'),
(7, 'Social Media Campaign', '2023-06-01', '2023-08-31', 2, 200000.00, 'Not Started'),
(8, 'Recruitment System', '2023-07-01', '2023-12-31', 3, 250000.00, 'Not Started');

INSERT INTO employee_projects VALUES
(1, 1, 'Project Manager', 40),
(2, 1, 'Developer', 40),
(3, 2, 'Project Manager', 30),
(4, 2, 'Designer', 40),
(5, 3, 'Trainer', 20),
(6, 3, 'Coordinator', 30),
(7, 4, 'Project Manager', 40),
(8, 4, 'Analyst', 40),
(9, 5, 'Research Lead', 40),
(10, 5, 'Researcher', 40),
(1, 6, 'Technical Lead', 20),
(2, 6, 'Developer', 30);

-- Practice Questions

/* Basic SELECT Queries */
-- Q1: List all employees with their first name, last name, and department ID
-- Q2: Find all employees who work in the Engineering department
-- Q3: List all projects that are currently 'In Progress'
-- Q4: Find all employees with a salary greater than 70000
-- Q5: List all departments and their budgets, ordered by budget in descending order

/* DISTINCT and ORDER BY */
-- Q6: Show all unique cities where employees are located
-- Q7: List all project statuses without duplicates
-- Q8: List employees ordered by hire date (most recent first)
-- Q9: Show all salaries (without duplicates) in descending order
-- Q10: List all employees ordered by department ID ascending and salary descending

/* Aggregation Functions */
-- Q11: Calculate the average salary for all employees
-- Q12: Find the total budget of all projects
-- Q13: Count the number of employees in each department
-- Q14: Find the highest and lowest salary in each department
-- Q15: Calculate the total hours allocated for each project

/* JOIN Operations */
-- Q16: List all employees with their department names
-- Q17: Show all projects with their respective department names
-- Q18: List all employees with their project names and roles
-- Q19: Find all departments with their total number of projects
-- Q20: Show all employees with their manager's name

/* WHERE Clause and Conditions */
-- Q21: Find all employees hired in 2021
-- Q22: List all projects with a budget greater than 400000
-- Q23: Find all employees working on more than one project
-- Q24: Show all departments with budget greater than average department budget
-- Q25: List all employees who are also managers

/* GROUP BY and HAVING */
-- Q26: Show departments with more than 2 employees
-- Q27: List projects with total allocated hours greater than 60
-- Q28: Find departments where the average salary is above 70000
-- Q29: Show cities with more than one employee
-- Q30: List managers who manage more than one employee

/* Subqueries */
-- Q31: Find employees who earn more than the average salary
-- Q32: List departments that have projects with status 'Completed'
-- Q33: Show employees who work on projects with budgets higher than 500000
-- Q34: Find all employees who earn more than their managers
-- Q35: List departments with no active projects

/* String Operations */
-- Q36: List employees whose last name starts with 'S'
-- Q37: Find projects whose names contain the word 'System'
-- Q38: List employees with gmail email addresses
-- Q39: Show employee full names (concatenated first and last name)
-- Q40: List departments whose names end with 'ing'

/* Date Functions */
-- Q41: Calculate the tenure (in years) for each employee
-- Q42: List projects with duration longer than 6 months
-- Q43: Find employees hired in the first quarter of any year
-- Q44: Show projects that will end in the next 3 months
-- Q45: List employees hired on or after 2021

/* Advanced Queries */
-- Q46: Rank employees by salary within each department
-- Q47: Calculate the percentage of total budget each project represents
-- Q48: Find employees who work on all projects in their department
-- Q49: Calculate the running total of project budgets ordered by start date
-- Q50: Create a summary of department statistics (total employees, average salary, total project budget)

-- Answers will follow in the next artifact