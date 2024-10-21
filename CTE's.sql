-- Common Table Expression
-- starts with 'WITH' then name of the table then AS
-- and then the subquery

/*
The CTE (Common Table Expression) defined by WITH is temporary and does not create an actual table in the database. It exists only for the duration of the query that immediately follows the WITH clause. You can't run two SELECT queries on the same CTE independently.
*/

WITH power_lvl_table AS (
SELECT name, level, is_alive,
CASE 
    WHEN class='Mage' THEN level*0.5
    WHEN class IN ('Archer', 'Warrior') THEN level*0.75
    ELSE level*1.5
    END AS power_lvl
FROM fantasy.characters
)
SELECT *
FROM power_lvl_table 
WHERE power_lvl >= 15;

-- Mixing CTE with subquery
-- it adds complexity to the code
-- not practical but example given below

WITH power_lvl_table AS (
SELECT name, level, is_alive,
CASE 
    WHEN class='Mage' THEN level*0.5
    WHEN class IN ('Archer', 'Warrior') THEN level*0.75
    ELSE level*1.5
    END AS power_lvl
FROM (SELECT * FROM characters WHERE is_alive="true")t  -- 't' is aliasing
)
SELECT *
FROM power_lvl_table 
WHERE power_lvl >= 15;

-- USING 2 CTE's below (char_alive and power_lvl_table)
-- the order is important and it matters
-- CTE can only reference the CTE above it

WITH char_alive AS (
SELECT * FROM characters WHERE is_alive="true"
),
power_lvl_table AS (
SELECT name, level, is_alive,
CASE 
    WHEN class='Mage' THEN level*0.5
    WHEN class IN ('Archer', 'Warrior') THEN level*0.75
    ELSE level*1.5
    END AS power_lvl
FROM char_alive
)
SELECT *
FROM power_lvl_table 
WHERE power_lvl >= 15;

-- USE CASE:
-- In industry it is considered better practice to use CTE's
-- in complex situation use CTE
-- in simple situation use subqueries
-- CTE can be used to create data pipelines


-- JOINS
SELECT * FROM characters;
SELECT * FROM inventory;
SELECT * FROM items;

-- Join characters tables and inventory table across the character_id
-- to know the item_id and the quantity of that item they are carrying
-- the output contains 20 rows
SELECT *
FROM characters AS c
JOIN inventory AS i
ON c.id = i.character_id;

SELECT
c.id, c.name, i.item_id, i.quantity
FROM characters AS c
JOIN inventory AS i
ON c.id = i.character_id;

-- Display the characters that carries 2 or more items
SELECT
c.id, c.name, i.item_id, i.quantity, it.name, it.power1
FROM characters AS c
JOIN inventory AS i
ON c.id = i.character_id
JOIN items AS it
ON i.item_id=it.id
WHERE i.quantity >= 2;

-- using CTE to obtain the total number of rows in the 3 joined tables
-- the total no. of rows is 17 but earlier it was 20, reason below.
WITH char_inv_item AS (
SELECT
c.id, c.name, i.item_id, i.quantity, it.name AS item_name, it.power
FROM characters AS c
JOIN inventory AS i
ON c.id = i.character_id
JOIN items AS it
ON i.item_id=it.id)
SELECT COUNT(*) FROM char_inv_item;


SELECT
c.id, c.name, i.item_id, i.quantity, it.name AS item_name, it.power
FROM characters AS c
JOIN inventory AS i
ON c.id = i.character_id
LEFT JOIN items AS it      -- to display all rows for the JOIN till now
ON i.item_id=it.id;
-- the output is 17 rows only and not 20
-- bcz the items table does not contains the item_id 99, 101, 121

-- Join characters table on itself to obtain the mentors_id
-- the below query does the job but it is messy as each row is printed twice
-- NOTE: NULL does not matches NULL, it is just the absence of data
SELECT *
FROM characters chars
JOIN characters mentors
ON chars.mentor_id=mentors.id;

SELECT chars.id, chars.name, mentors.id, mentors.name
FROM characters chars
LEFT JOIN characters mentors
ON chars.mentor_id=mentors.id
ORDER BY chars.id;

-- a character can use any items for which the power level is equal
-- or greater than the character's exp. divided by 100
-- a list of all characters and the items that they can use

SELECT c.id, c.name, c.experience/100 AS condition1, i.name, i.power
FROM characters c
JOIN items i
ON c.experience/100 >= i.power
ORDER BY c.id;

SELECT c.id, c.name, c.class, c.experience/100 AS condition1, i.power, i.name
FROM characters c
JOIN items i
ON c.experience/100 >= i.power OR c.class='Mage'
ORDER BY c.id;

-- LEFT JOIN
-- it returns all rows from the left table and only matching rows from the right table
-- table A LEFT JOIN table B = table B RIGHT JOIN table A

-- display all characters with (if they have) or without mentor details
SELECT c.id AS mentee_id, c.name AS mentee_name, c.mentor_id AS mentor_id,  ch.name AS mentor_name
FROM characters AS c
LEFT JOIN characters AS ch
ON c.mentor_id = ch.id
ORDER BY c.id;


SELECT *
FROM characters
WHERE mentor_id IS NULL;


-- replace the single spaces in mentor_id with NULL
UPDATE characters
SET mentor_id =  NULL
WHERE TRIM(mentor_id)='';


-- SELECT all the characters that do not have any mentors
-- Using LEFT JOIN
SELECT c.id AS mentee_id, c.name AS mentee_name, c.mentor_id AS mentor_id,  ch.name AS mentor_name
FROM characters AS c
LEFT JOIN characters AS ch
ON c.mentor_id = ch.id
WHERE ch.id IS NOT NULL
ORDER BY c.id;

-- SELECT all the characters that do not have any mentors
-- Using INNER JOIN
SELECT c.id AS mentee_id, c.name AS mentee_name, c.mentor_id AS mentor_id,  ch.name AS mentor_name
FROM characters AS c
JOIN characters AS ch
ON c.mentor_id = ch.id
-- WHERE ch.id IS NOT NULL
ORDER BY c.id;

SELECT *
FROM characters
WHERE mentor_id IS NOT NULL;

SELECT c.id AS mentee_id, c.name AS mentee_name, c.mentor_id AS mentor_id,  ch.name AS mentor_name
FROM characters AS c
LEFT JOIN characters AS ch
ON c.mentor_id = ch.id
WHERE ch.id IS NOT NULL
ORDER BY c.id;