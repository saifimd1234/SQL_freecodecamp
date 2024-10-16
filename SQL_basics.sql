-- order of operations?
-- functions, multiplication/division, addition/subtraction
-- brackets go first
SELECT (3+2*2+1)-4/2*(pow(2, 2) -2)/2;

-- 8-4/2*2/2
-- 8-2*1
-- 6


SELECT *
FROM characters
WHERE is_alive="true";

-- this will not run because the WHERE clause gets executed first
-- and it will not find any column with health_score as the aliasing
-- is done is SELECT statement which gets executed after WHERE clause.
SELECT health AS health_score
FROM characters
WHERE health_score > 50;

SELECT *
FROM characters
WHERE health>50;

-- 'normal' algebra
-- elements: 0, 25, 100
-- operators: + - * /
-- operation: 100+20=120

-- boolean algebra
-- elements: true, false
-- operators: NOT, OR, AND
-- operation: true AND false = false

-- order of operations: NOT, AND, OR
-- first solve the brackets
