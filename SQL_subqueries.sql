-- find the characters whose experience  is between min and max
-- more experience than the least experienced character, less than the most experienced character
-- NOTE:
-- the subquery returns a single column as defined inside the brackets

SELECT MIN(experience), MAX(experience)  -- 2100 adnd 15000
FROM characters;

-- below query does not runs bcz aggregate functions cannot be used in WHERE clause
SELECT name, experience
FROM characters
WHERE experience > MIN(experience);

-- using subquery
-- this uses UNCORRELATED SUBQUERY
-- this subquery works on an indivdually
SELECT name, experience
FROM characters
WHERE experience > 
(SELECT MIN(experience)    -- 2100
FROM characters);

SELECT name, experience
FROM characters
WHERE experience > 
(SELECT MIN(experience)    -- 2100
FROM characters)
AND experience < 
(SELECT MAX(experience)    -- 15000
FROM characters);

-- QUESTION 1: (CORRELATED SUBQUERY)
-- find the difference between a character's experience and their mentor's experience
-- for each row it must run individually or dynamically

SELECT * FROM characters;
-- take example of id=6; name=Saruman; experience=8500;
-- mentor_id=6; id=6; name=Gandalf; experience=10000;
SELECT 10000-8500;    -- 1500

SELECT name, id AS mentee_id, mentor_id, experience AS mentee_experience,
(
    SELECT experience
    FROM characters AS mentor_table
    WHERE id=mentee_table.mentor_id
) AS mentor_experience
FROM characters AS mentee_table
WHERE mentor_id IS NOT NULL;

SELECT * FROM characters;

-- QUESTION 2:
-- to print the name and experience of the mentor using concat in single
SELECT id AS mentee_id, name, mentor_id, experience AS mentee_experience,
(
    SELECT concat(name, ', ',experience)
    FROM characters AS mentor_table
    WHERE id=mentee_table.mentor_id
) mentor_info
FROM characters AS mentee_table
WHERE mentor_id IS NOT NULL;

-- ANSWER:
SELECT id AS mentee_id, name, mentor_id, experience AS mentee_experience,
(
    SELECT experience
    FROM characters AS mentor_table
    WHERE id=mentee_table.mentor_id
) - experience AS mentor_difference
FROM characters AS mentee_table
WHERE mentor_id IS NOT NULL;


-- below query does not runs bcz of the WHERE clause, as WHERE clause is executed first in the order and it does not finds any power_lvl col. in the table
SELECT name, level,
CASE 
    WHEN class='Mage' THEN level*0.5
    WHEN class IN ('Archer', 'Warrior') THEN level*0.75
    ELSE level*1.5
    END AS power_lvl
FROM characters
WHERE power_lvl > 15;

-- corrected query
-- table aliasing in WHERE clause has been removed, use till END
-- no brackets are used
SELECT name, level,
CASE 
    WHEN class='Mage' THEN level*0.5
    WHEN class IN ('Archer', 'Warrior') THEN level*0.75
    ELSE level*1.5
    END AS power_lvl
FROM characters
WHERE 
CASE 
    WHEN class='Mage' THEN level*0.5
    WHEN class IN ('Archer', 'Warrior') THEN level*0.75
    ELSE level*1.5
    END >= 15;

-- NOTE: above query can give results but it is impractical and
-- one should not copy codes as such

-- REVISED CODE:
-- the inner query is run first and a 'new_table' is formed with power_lvl
-- now the new col can be used in the WHERE clause

SELECT *
FROM
(SELECT name, level, is_alive,
CASE 
    WHEN class='Mage' THEN level*0.5
    WHEN class IN ('Archer', 'Warrior') THEN level*0.75
    ELSE level*1.5
    END AS power_lvl
FROM characters) new_table
WHERE power_lvl >= 15;

--(NESTED SUBQUERY) Subquery inside another subquery. Example:
-- return all characters who is alive and power_lvl>=15
-- Approach #1
SELECT *
FROM
(SELECT name, level, is_alive,    -- 1st subquery
CASE 
    WHEN class='Mage' THEN level*0.5
    WHEN class IN ('Archer', 'Warrior') THEN level*0.75
    ELSE level*1.5
    END AS power_lvl
FROM 
(SELECT *                  -- 2nd subquery
FROM characters
WHERE is_alive="true")t
) new_table
WHERE power_lvl >= 15;

-- (NESTED SUBQUERY) Subquery inside another subquery. Example:
-- return all characters who is alive and power_lvl>=15
-- Approach #2
SELECT *
FROM
(SELECT name, level, is_alive,
CASE 
    WHEN class='Mage' THEN level*0.5
    WHEN class IN ('Archer', 'Warrior') THEN level*0.75
    ELSE level*1.5
    END AS power_lvl
FROM characters
WHERE is_alive="true"     -- WHERE clause used in 1st subquery
) new_table
WHERE power_lvl >= 15;