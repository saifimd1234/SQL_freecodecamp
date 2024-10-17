-- find the characters whose experience  is between min and max
-- more experience than the least experienced character, less than the most experienced character

SELECT MIN(experience), MAX(experience)  -- 2100 adnd 15000
FROM characters;

-- below query does not runs bcz aggregate functions cannot be used in WHERE clause
SELECT name, experience
FROM characters
WHERE experience > MIN(experience);

-- using subquery
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

-- find the difference between a character's experience and their mentor's experience

SELECT * FROM characters;
-- take example of id=6; name=Saruman; experience=8500;
-- mentor_id=6; id=6; name=Gandalf; experience=10000;
SELECT 10000-8500;    -- 1500

SELECT name, id AS mentee_id, mentor_id, experience AS mentee_experience,
(
    SELECT experience
    FROM characters
    WHERE id=c.mentor_id
) AS mentor_experience
FROM characters AS c
WHERE mentor_id IS NOT NULL;