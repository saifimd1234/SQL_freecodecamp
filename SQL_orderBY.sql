-- You can ORDER BY a column in ascending or descending order
-- The default order is ascending
-- You can ORDER BY multiple columns
-- You can ORDER BY the column which is not even in the SELECT clause
-- You can ORDER BY mathematical expressions\calculations as well
SELECT name, class, level
FROM characters
ORDER BY class, level DESC;

-- Use 'level/experience*2' in the SELECT clause as well to view that the results are in ascending order
SELECT name, class, level
FROM characters
ORDER BY level/experience*2;

-- LIMIT CLAUSE
-- 5 lowest level characters
-- LIMIT is used with ORDER BY
-- LIMIT only changes the way output is displayed and it does not change the logical operation or time complexity of the query
SELECT name, class, level
FROM characters
ORDER BY level
LIMIT 5;

-- BUCKETING
-- Bucketing by the benchmark 20
-- characters with level>=20 is 1(true) and others 0(false)
SELECT name, level, level>=20 AS level_at_least_20
FROM characters
WHERE is_alive="true";

-- upto lvl 15: low
-- between 15 and 25: mid
-- above 25: high
SELECT name, level, 
CASE
    WHEN level<=15 THEN 'low'
    WHEN level>15 AND level<=25 THEN 'mid'
    WHEN level>25 THEN 'high'
END AS level_bucket
FROM characters
WHERE is_alive="true"
ORDER BY level;

-- from the obtained result of above query, take the name: Gandalf; lvl=30; For example below,
-- level=30
    -- WHEN 30<=15 THEN 'low'; false
    -- WHEN 30>15 AND 30<=25 THEN 'mid'; true and false=false
    -- WHEN 30>25 THEN 'high'; true

-- REDUCING REDUNDANCY

-- 1. Redundancy- remove the 'WHEN level>15 AND' from the 2nd condition bcz the 1st condition already confirms that the value till 15 will be 'low' so the 2nd condition need not check for level>15 again.

--2. Redundancy- remove the 'WHEN level>25 THEN' from the 3rd condition bcz the 2nd condition already confirms that the value above 25 will be 'high' so the 3rd condition need not check for level>25 again.
-- Use, ELSE clause to add more conditions if needed.

SELECT name, level, 
CASE
    WHEN level<=15 THEN 'low'
    WHEN level<=25 THEN 'mid'
    ELSE 'high'
END AS level_bucket
FROM characters
WHERE is_alive="true"
ORDER BY level;

-- What happens if we don't specify ELSE clause?
-- it returns 'null' for those output, below, we have not defined bucketing for level>25. So for them level_bucket will be 'null'.
SELECT name, level, 
CASE
    WHEN level<=15 THEN 'low'
    WHEN level<=25 THEN 'mid'
END AS level_bucket
FROM characters
WHERE is_alive="true"
ORDER BY level;

-- NOTE:
-- in bucketing you can use numbers as well
SELECT name, level, 
CASE
    WHEN level<=15 THEN 1
    WHEN level<=25 THEN 2
    ELSE 3
END AS level_bucket
FROM characters
WHERE is_alive="true"
ORDER BY level;

-- NOTE:
-- in bucketing you cannot combine the datatype of columns
SELECT name, level, 
CASE
    WHEN level<=15 THEN 1
    WHEN level<=25 THEN 'mid'
    ELSE 3
END AS level_bucket
FROM characters
WHERE is_alive="true"
ORDER BY level;

-- you can use all mathematical expressions as well
SELECT name, level, class, experience, level*experience/2 AS lvl_exp,
CASE
    WHEN level*experience/2<20 OR class IN('Mage', 'Archer') THEN 1
    WHEN level<25 THEN 2 
    ELSE 3
END AS bucket_level
FROM characters
WHERE is_alive="true"
ORDER BY level;


