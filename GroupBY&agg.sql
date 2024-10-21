-- grouping field = dimensions
-- aggregate field = measures

-- GROUP BY
-- pick the max lvl character from each class
SELECT class,
    MAX(level),
    MIN(level),
    COUNT(*),
    AVG(level)
FROM characters
GROUP BY class;

-- from the items table group by item_type and rarity and check their AVG(power)
SELECT item_type, rarity, AVG(`power`)
FROM items
GROUP BY item_type, rarity
ORDER BY item_type, AVG(`power`);

-- name, item_type, avg_power_by_name
-- chainmail armor, armor, 69.5
-- elven bow, weapon,  95.58

SELECT item_type, AVG(power)
FROM items
GROUP BY item_type;

-- IMPORTANT NOTE:
/* LAW OF GROUPING:
1. Grouping fields (columns that I listed in GROUP BY)
2. Aggregations of other field
*/
-- the below query does not runs bcz name field cannot be aggregated
SELECT name, item_type, AVG(`power`) AS avg_power
FROM items
GROUP BY item_type;

-- ALTERNATIVE #1:
-- the below query runs bcz the name column is now aggregated
-- it returns the first name in alphabetical order
SELECT MIN(name), item_type, AVG(`power`) AS avg_power
FROM items
GROUP BY item_type;

-- ALTERNATIVE #2:
-- the below query runs bcz the name column is now in grouping field
-- it returns the unique combination of item_name + item_type
SELECT name, item_type, AVG(`power`) AS avg_power
FROM items
GROUP BY item_type, name;

-- ALTERNATIVE #3:
-- the below query runs bcz of WINDOWS functions
SELECT name, item_type, AVG(`power`) OVER(PARTITION BY item_type) AS avg_power
FROM items;

-- WHERE clause cannot be used to filter output bcz it runs before GROUP BY
-- WRONG METHOD OF FILTERING:
SELECT class, AVG(experience) AS avg_exp
FROM characters
GROUP BY class
WHERE AVG(experience) > 1000;

-- CORRECT METHOD OF FILTERING:
SELECT class, AVG(experience) AS avg_exp
FROM characters
GROUP BY class
HAVING avg_exp > 7000;  -- avoid using alias here, use function: "AVG(experience)"