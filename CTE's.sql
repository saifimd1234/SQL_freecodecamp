-- Common Table Expression
-- starts with 'WITH' then name of the table then AS
-- and then the subquery

/*
The error you're seeing, Table 'fantasy.power_lvl_table' doesn't exist, occurs because the CTE (Common Table Expression) defined by WITH is temporary and does not create an actual table in the database. It exists only for the duration of the query that immediately follows the WITH clause. You can't run two SELECT queries on the same CTE independently.
*/

WITH power_lvl_table AS (
SELECT name, level,
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