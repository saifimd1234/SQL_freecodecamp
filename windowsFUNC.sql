-- WINDOWS FUNCTIONS: uses OVER() after aggregation function
SELECT name, item_type, power, SUM(`power`) OVER() AS sum_power,
SUM(power) OVER(PARTITION BY item_type) AS sum_item_type,
CONCAT(ROUND(`power`*100/SUM(power) OVER(), 2), '%') AS perc_total_power
FROM items;

/* In perc_total_power, one need to use the complete function bcz it does
not recognise the aliasing 'sum_power', i.e.,
CONCAT(ROUND(`power`*100/sum_power, 2), '%') AS perc_total_power
*/

-- CUMULATIVE SUM OF POWER
SELECT name, item_type, power,
SUM(`power`) OVER(ORDER BY power) AS cum_power
FROM items;

-- CUMULATIVE SUM OF POWER AND ITEM_TYPE
SELECT name, item_type, power,
SUM(`power`) OVER(PARTITION BY item_type ORDER BY power) AS cum_power
FROM items;

-- The data below is not going to be divided by guild or is_alive only
-- it is going to be divided by all the possible combination available
SELECT name, is_alive, guild, level,
SUM(level) OVER(PARTITION BY guild, is_alive)
FROM characters;

-- ROW_NUMBER() does not handles duplicates, just labels 1-n
-- DENSE_RANK() handles duplicates, continues ranking, n, n+1 or 1,1,2
-- RANK() handles duplicates, skips ranking, 1,1,3 
SELECT item_id, value,
ROW_NUMBER() OVER(ORDER BY value) AS `row_number`,
DENSE_RANK() OVER(ORDER BY value) AS `dense_rank`,
RANK() OVER(ORDER BY value) AS `rank`
FROM inventory
ORDER BY value;

SELECT * FROM characters;

-- RANK() characters based on their level in descending order
SELECT id, name, level, 
RANK() OVER(ORDER BY level DESC) AS `rank`
FROM characters;

-- RANK() each class characters based on their level in descending order
SELECT id, name, level, class,
RANK() OVER(PARTITION BY class ORDER BY level DESC) AS `rank`
FROM characters;