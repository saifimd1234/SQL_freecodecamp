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

SELECT NOT(true AND NOT false OR false AND (true OR true) AND true) OR (true AND (false AND true));
-- output- 
-- NOT(true AND NOT false OR false AND (true OR true) AND true) OR (true AND false)
-- NOT(true AND NOT false OR false AND true AND true) OR false
-- NOT(true AND true OR false AND true AND true) OR false
-- NOT(true AND true OR false AND true) OR false
-- NOT(true OR false) OR false
-- NOT true OR false
-- false OR false
-- false

SELECT name, level, is_alive, mentor_id, class
FROM characters
WHERE (level>20 AND is_alive=true OR mentor_id IS NOT NULL) AND NOT(class IN('Mage', 'Archer'))

-- output -
-- name=Aragon; level=25; is_alive=true; mentor_id=null; class=Warrior
-- WHERE (level>20 AND is_alive=true OR mentor_id IS NOT NULL) AND NOT(class IN('Mage', 'Archer'))
-- (true AND true OR false) AND NOT(false)
-- (true OR false) AND true
-- true AND true
-- true


