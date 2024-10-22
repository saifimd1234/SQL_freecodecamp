-- Answers to Practice Questions

/* Basic SELECT Queries */
-- A1
SELECT first_name, last_name, department_id FROM employees;

-- A2
SELECT e.* FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering';

-- A3
SELECT * FROM projects WHERE status = 'In Progress';

-- A4
SELECT * FROM employees WHERE salary > 70000;

-- A5
SELECT * FROM departments ORDER BY budget DESC;

/* DISTINCT and ORDER BY */
-- A6
SELECT DISTINCT city FROM employees;

-- A7
SELECT DISTINCT status FROM projects;

-- A8
SELECT * FROM employees ORDER BY hire_date DESC;

-- A9
SELECT DISTINCT salary FROM employees ORDER BY salary DESC;

-- A10
SELECT * FROM employees ORDER BY department_id ASC, salary DESC;

/* Aggregation Functions */
-- A11
SELECT AVG(salary) as avg_salary FROM employees;

-- A12
SELECT SUM(project_budget) as total_budget FROM projects;

-- A13
SELECT department_id, COUNT(*) as emp_count 
FROM employees 
GROUP BY department_id;

-- A14
SELECT department_id, 
       MAX(salary) as highest_salary,
       MIN(salary) as lowest_salary 
FROM employees 
GROUP BY department_id;

-- A15
SELECT project_id, SUM(hours_allocated) as total_hours 
FROM employee_projects 
GROUP BY project_id;

/* JOIN Operations */
-- A16
SELECT e.*, d.department_name 
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- A17
SELECT p.*, d.department_name 
FROM projects p
JOIN departments d ON p.department_id = d.department_id;

-- A18
SELECT e.first_name, e.last_name, p.project_name, ep.role 
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id;

-- A19
SELECT d.department_name, COUNT(p.project_id) as project_count 
FROM departments d
LEFT JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_name;

-- A20
SELECT e.first_name as employee_name, 
       m.first_name as manager_name 
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

/* WHERE Clause and Conditions */
-- A21
SELECT * FROM employees 
WHERE YEAR(hire_date) = 2021;

-- A22
SELECT * FROM projects 
WHERE project_budget > 400000;

-- A23
SELECT e.first_name, e.last_name, COUNT(ep.project_id) as project_count 
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
GROUP BY e.employee_id
HAVING COUNT(ep.project_id) > 1;

-- A24
SELECT * FROM departments 
WHERE budget > (SELECT AVG(budget) FROM departments);

-- A25
SELECT * FROM employees 
WHERE employee_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL);

/* GROUP BY and HAVING */
-- A26
SELECT d.department_name, COUNT(e.employee_id) as emp_count 
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 2;

-- A27
SELECT p.project_name, SUM(ep.hours_allocated) as total_hours 
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_name
HAVING SUM(ep.hours_allocated) > 60;

-- A28
SELECT d.department_name, AVG(e.salary) as avg_salary 
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 70000;

-- A29
SELECT city, COUNT(*) as emp_count 
FROM employees 
GROUP BY city
HAVING COUNT(*) > 1;

-- A30
SELECT m.first_name, m.last_name, COUNT(*) as subordinates 
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
GROUP BY m.employee_id
HAVING COUNT(*) > 1;

/* Subqueries */
-- A31: Find employees who earn more than the average salary
SELECT * FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- A32: List departments that have projects with status 'Completed'
SELECT DISTINCT d.* FROM departments d
JOIN projects p ON d.department_id = p.department_id
WHERE p.status = 'Completed';

-- A33: Show employees who work on projects with budgets higher than 500000
SELECT DISTINCT e.* FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE p.project_budget > 500000;

-- A34: Find all employees who earn more than their managers
SELECT e1.* FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id
WHERE e1.salary > e2.salary;

-- A35: List departments with no active projects
SELECT d.* FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM projects p 
    WHERE p.department_id = d.department_id 
    AND p.status = 'In Progress'
);

/* String Operations */
-- A36: List employees whose last name starts with 'S'
SELECT * FROM employees 
WHERE last_name LIKE 'S%';

-- A37: Find projects whose names contain the word 'System'
SELECT * FROM projects 
WHERE project_name LIKE '%System%';

-- A38: List employees with gmail email addresses
SELECT * FROM employees 
WHERE email LIKE '%@gmail.com';

-- A39: Show employee full names (concatenated first and last name)
SELECT CONCAT(first_name, ' ', last_name) as full_name 
FROM employees;

-- A40: List departments whose names end with 'ing'
SELECT * FROM departments 
WHERE department_name LIKE '%ing';

/* Date Functions */
-- A41: Calculate the tenure (in years) for each employee
SELECT 
    first_name,
    last_name,
    DATEDIFF(CURRENT_DATE, hire_date)/365.0 as years_of_service 
FROM employees;

-- A42: List projects with duration longer than 6 months
SELECT *,
    DATEDIFF(end_date, start_date)/30.0 as duration_months
FROM projects 
WHERE DATEDIFF(end_date, start_date) > 180;

-- A43: Find employees hired in the first quarter of any year
SELECT * FROM employees 
WHERE MONTH(hire_date) <= 3;

-- A44: Show projects that will end in the next 3 months
SELECT * FROM projects 
WHERE end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 3 MONTH);

-- A45: List employees hired on or after 2021
SELECT * FROM employees 
WHERE YEAR(hire_date) >= 2021;

/* Advanced Queries */
-- A46: Rank employees by salary within each department
SELECT 
    department_id,
    first_name,
    last_name,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as salary_rank
FROM employees;

-- A47: Calculate the percentage of total budget each project represents
WITH total_budget AS (
    SELECT SUM(project_budget) as total FROM projects
)
SELECT 
    project_name,
    project_budget,
    (project_budget / total * 100) as budget_percentage
FROM projects, total_budget;

-- A48: Find employees who work on all projects in their department
SELECT e.* FROM employees e
WHERE NOT EXISTS (
    SELECT p.project_id 
    FROM projects p
    WHERE p.department_id = e.department_id
    AND NOT EXISTS (
        SELECT 1 FROM employee_projects ep
        WHERE ep.employee_id = e.employee_id
        AND ep.project_id = p.project_id
    )
);

-- A49: Calculate the running total of project budgets ordered by start date
SELECT 
    project_name,
    start_date,
    project_budget,
    SUM(project_budget) OVER (ORDER BY start_date) as running_total
FROM projects;

-- A50: Create a summary of department statistics
SELECT 
    d.department_name,
    COUNT(DISTINCT e.employee_id) as total_employees,
    AVG(e.salary) as avg_salary,
    SUM(p.project_budget) as total_project_budget,
    COUNT(DISTINCT p.project_id) as total_projects
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN projects p ON d.department_id = p.department_id
GROUP BY d.department_name;