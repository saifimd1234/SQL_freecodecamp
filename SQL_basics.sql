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

-- Distinct combination of class and guild
SELECT DISTINCT class, guild
FROM characters;

-- Distinct combination of class, guild and is_alive
SELECT DISTINCT class, guild, is_alive
FROM characters;

-- we will generally get complete table as there should be complete match of columns of 2 or more rows for the data to be classified as same
SELECT DISTINCT *
FROM characters
ORDER BY id;

-- new table with only alive characters
CREATE TABLE characters_alive
AS(
SELECT *
FROM characters
WHERE is_alive="TRUE"
);

-- new table with only dead characters
CREATE TABLE characters_dead
AS(
SELECT *
FROM characters
WHERE is_alive="FALSE"
);

SHOW tables;

-- this will create or replace/rewrite the table
CREATE OR REPLACE TABLE characters_dead
AS(
SELECT *
FROM characters
WHERE is_alive="FALSE"
);

SELECT * FROM characters;

-- creates table only if it does not exists
CREATE TABLE IF NOT EXISTS characters_dead
AS(
SELECT *
FROM characters
WHERE is_alive="FALSE"
);

-- to create a new table that consists of both alive/dead characters
CREATE TABLE characters_alive_and_dead
AS (
SELECT * FROM characters_alive
UNION
SELECT * FROM characters_dead
);

-- in Google BigQuery, we have to use 'UNION DISTINCT'/'UNION ALL'

SELECT * FROM characters_alive_and_dead
ORDER BY id;

-- col1 |   col2  | col3
----------------------
-- 1    | true    | Yes
-- 0    | false   | No

-- col1 |   col2  | col3
----------------------
-- 1    | true    | Yes
-- 3    | true    | Maybe

-- Create table for the above data.
CREATE TABLE table1 (
    col1 INT,
    col2 BOOLEAN,
    col3 varchar(10)
);

CREATE TABLE table2 (
    col1 INT,
    col2 BOOLEAN,
    col3 varchar(10)
);

INSERT INTO table1 (col1, col2, col3)
VALUES
(1, TRUE, 'Yes'),
(0, FALSE, 'No');

INSERT INTO table2 (col1, col2, col3)
VALUES
(1, TRUE, 'Yes'),
(3, TRUE, 'Maybe');

SELECT * FROM table1
UNION DISTINCT
SELECT * FROM table2;

-- UNION = UNION DISTINCT (1, TRUE, 'Yes') will only be displaced once
-- UNION = UNION DISTINCT (1, TRUE, 'Yes') will only be displaced twice

-- to represent the common row
SELECT * FROM table1
INTERSECT
SELECT * FROM table2;

-- A-B in sets operation, DISTINCT row from table1
SELECT * FROM table1
EXCEPT
SELECT * FROM table2;

-- B-A in sets operation, DISTINCT row from table2
SELECT * FROM table2
EXCEPT
SELECT * FROM table1;

-- RULES OF UNION:
-- 1. same number of columns in both tables
-- 2. datatype of the columns should be same

-- Both the tables contained different number of columns and datatype, combine them by following the above rule.
-- NOTE: The output column heading will be of the first table
SELECT id, name, item_type, power, date_added
FROM items
UNION
SELECT id, name, class, level, last_active
FROM characters;

-- to combine to different datatypes
-- rarity is STRING and experience is INT
SELECT id, name, item_type, power, date_added, CAST(rarity AS CHAR) AS rarity
FROM items
UNION
SELECT id, name, class, level, last_active, CAST(experience AS CHAR)
FROM characters;