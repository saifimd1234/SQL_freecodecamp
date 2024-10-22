/* Easy Questions (1-5) */
-- A1: List all employees along with their manager's name
SELECT 
    e1.employee_id,
    e1.first_name,
    e1.last_name,
    CONCAT(e2.first_name, ' ', e2.last_name) as manager_name
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;

-- A2: Find all employees who work in the same department as employee ID 4
-- this excludes the employee_id 4 and only includes the other wokring ppl
SELECT e2.* 
FROM employees e1
JOIN employees e2 ON e1.department_id = e2.department_id
WHERE e1.employee_id = 4 AND e2.employee_id != 4;

-- below query will return the employee_id 4 as well
SELECT *
FROM employees
WHERE department_id =
(SELECT department_id
FROM employees
WHERE employee_id=4);

SELECT * FROM employees WHERE department_id=1;

-- A3: Display all employees who were hired in the same year
SELECT 
    e1.first_name, 
    e1.last_name,
    e2.first_name as colleague_first_name,
    e2.last_name as colleague_last_name,
    YEAR(e1.hire_date) as hire_year
FROM employees e1
JOIN employees e2 ON YEAR(e1.hire_date) = YEAR(e2.hire_date)
WHERE e1.employee_id < e2.employee_id;

-- using windows function
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    YEAR(hire_date) AS hire_year,
    COUNT(*) OVER (PARTITION BY YEAR(hire_date)) AS employees_hired_same_year,
    ROW_NUMBER() OVER(PARTITION BY YEAR(hire_date) ORDER BY department_id) AS numbers
FROM employees
ORDER BY hire_year;

-- A4: Show all employees who have the same manager as employee ID 8
-- list of employees excluding employee_id 8
SELECT e2.* 
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.manager_id
WHERE e1.employee_id = 8 AND e2.employee_id != 8;

-- list of employees including employee_id 8
SELECT
employee_id,
CONCAT(first_name, " ", last_name) AS full_name,
department_id
FROM employees
WHERE department_id =
(SELECT department_id
FROM employees WHERE employee_id=8)

-- A5: List all employees who work in the same office location as employee ID 2
-- list of employees without employee_id 2
SELECT e2.* 
FROM employees e1
JOIN employees e2 ON e1.office_location = e2.office_location
WHERE e1.employee_id = 2 AND e2.employee_id != 2;

-- list of employees with employee_id 2
SELECT
employee_id,
CONCAT(first_name, " ", last_name) AS full_name,
office_location
FROM employees
WHERE office_location =
(
    SELECT office_location
    FROM employees WHERE employee_id=2
)

/* Moderate Questions (6-15) */
-- A6: Find all pairs of employees who have the same salary
SELECT 
    e1.first_name,
    e1.last_name,
    e2.first_name as colleague_first_name,
    e2.last_name as colleague_last_name,
    e1.salary
FROM employees e1
JOIN employees e2 ON e1.salary = e2.salary
WHERE e1.employee_id < e2.employee_id;

-- USING CTE:
WITH same_sal AS (
    SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    salary,
    COUNT(*) OVER (PARTITION BY salary) AS same_salary_count
FROM employees)
SELECT * FROM same_sal WHERE same_salary_count > 1;

-- A7: Display employees who have a higher salary than their managers
SELECT 
    e1.first_name,
    e1.last_name,
    e1.salary as employee_salary,
    e2.salary as manager_salary
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id
WHERE e1.salary > e2.salary;

-- A8: List all employees who were hired later than their managers
SELECT 
    e1.first_name,
    e1.last_name,
    e1.hire_date as employee_hire_date,
    e2.hire_date as manager_hire_date
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id
WHERE e1.hire_date > e2.hire_date;

-- A9: Find all employees who have the same manager and level
SELECT 
    e1.first_name,
    e1.last_name,
    e2.first_name as colleague_first_name,
    e2.last_name as colleague_last_name,
    e1.level,
    e1.manager_id
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.manager_id 
    AND e1.level = e2.level
WHERE e1.employee_id < e2.employee_id;

-- A10: Show pairs of employees who are each other's mentors
SELECT 
    e1.first_name,
    e1.last_name,
    e2.first_name as mentor_first_name,
    e2.last_name as mentor_last_name
FROM employees e1
JOIN employees e2 ON e1.mentor_id = e2.employee_id
WHERE e2.mentor_id = e1.employee_id;

-- A11: List employees who have a higher salary than their mentors
SELECT 
    e1.first_name,
    e1.last_name,
    e1.salary as employee_salary,
    e2.salary as mentor_salary
FROM employees e1
JOIN employees e2 ON e1.mentor_id = e2.employee_id
WHERE e1.salary > e2.salary;

-- A12: Find employees who were hired within 90 days of each other in the same department
SELECT 
    e1.first_name,
    e1.last_name,
    e1.hire_date,
    e2.first_name as colleague_first_name,
    e2.last_name as colleague_last_name,
    e2.hire_date as colleague_hire_date,
    ABS(DATEDIFF(e1.hire_date, e2.hire_date)) as days_difference
FROM employees e1
JOIN employees e2 ON e1.department_id = e2.department_id
WHERE e1.employee_id < e2.employee_id
    AND ABS(DATEDIFF(e1.hire_date, e2.hire_date)) <= 90;

-- A13: Display employees who have the same manager but different levels
SELECT 
    e1.first_name,
    e1.last_name,
    e1.level as level1,
    e2.first_name as colleague_first_name,
    e2.last_name as colleague_last_name,
    e2.level as level2
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.manager_id
WHERE e1.employee_id < e2.employee_id 
    AND e1.level != e2.level;

-- A14: Show employees who have a lower salary than the average salary of their manager's other direct reports
WITH avg_subordinate_salary AS (
    SELECT 
        manager_id,
        employee_id,
        AVG(salary) OVER (PARTITION BY manager_id) as avg_salary
    FROM employees
)
SELECT 
    e1.first_name,
    e1.last_name,
    e1.salary,
    avg_sub.avg_salary as avg_team_salary
FROM employees e1
JOIN avg_subordinate_salary avg_sub 
    ON e1.manager_id = avg_sub.manager_id
WHERE e1.salary < avg_sub.avg_salary;

-- A15: Find all employees who have the same level but a salary difference of more than 5000
SELECT 
    e1.first_name,
    e1.last_name,
    e1.salary as salary1,
    e2.first_name as colleague_first_name,
    e2.last_name as colleague_last_name,
    e2.salary as salary2,
    ABS(e1.salary - e2.salary) as salary_difference
FROM employees e1
JOIN employees e2 ON e1.level = e2.level
WHERE e1.employee_id < e2.employee_id
    AND ABS(e1.salary - e2.salary) > 5000;

/* Hard Questions (16-20) */
-- A16: Find all employees who are managed by someone in a lower pay grade than themselves
SELECT 
    e1.first_name,
    e1.last_name,
    oc1.pay_grade as employee_grade,
    e2.first_name as manager_first_name,
    e2.last_name as manager_last_name,
    oc2.pay_grade as manager_grade
FROM employees e1
JOIN organization_chart oc1 ON e1.level = oc1.position_title
JOIN employees e2 ON e1.manager_id = e2.employee_id
JOIN organization_chart oc2 ON e2.level = oc2.position_title
WHERE oc1.pay_grade > oc2.pay_grade;

-- A17: Display the hierarchy of employees (level 1, 2, 3 deep) who all have salaries within 10000 of each other
WITH RECURSIVE emp_hierarchy AS (
    -- Base case: start with employees who have no manager
    SELECT 
        employee_id,
        first_name,
        last_name,
        manager_id,
        salary,
        1 as hierarchy_level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: add employees who are managed by someone in our hierarchy
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.manager_id,
        e.salary,
        h.hierarchy_level + 1
    FROM employees e
    JOIN emp_hierarchy h ON e.manager_id = h.employee_id
    WHERE ABS(e.salary - h.salary) <= 10000
        AND h.hierarchy_level < 3
)
SELECT * FROM emp_hierarchy
ORDER BY hierarchy_level, salary DESC;

-- A18: Find employees who have a higher salary than all employees who joined before them in their department
SELECT e1.*
FROM employees e1
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department_id = e1.department_id
        AND e2.hire_date < e1.hire_date