-- NETFLIX PROJECT
-- DROP TABLE IF EXISTS NETFLIX;
CREATE TABLE NETFLIX(
show_id VARCHAR(6),
typees  VARCHAR(10),
title VARCHAR(150),
director VARCHAR (208),
casts VARCHAR(1000),
country	VARCHAR (150),
date_added VARCHAR(50),
release_year INT ,
rating VARCHAR(10),
duration VARCHAR(15),
listed_in VARCHAR(100),
description VARCHAR(250)
);
-- SELECT ALL ROW AND COLUMNE
SELECT * FROM NETFLIX
SELECT COUNT (*) AS TOTAL COUNT 
FROM NETFLIX

SELECT DISTINCT TYPEES 
FROM NETFLIX

-- 15 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Show 
SELECT DISTINCT TYPEES ,COUNT(show_id) AS NO
FROM NETFLIX
GROUP BY TYPEES;

-- 2. Find the most common rating for movies and TV shows
select 
TYPEES ,
rating ,
count(*) AS CO
from NETFLIX
group by 1,2;
-- 3. List all movies released in a specific year (e.g., 2020)
SELECT TYPEES ,title, release_year FROM NETFLIX
WHERE release_year = 2020 AND TYPEES = 'Movie'

4. Find the top 5 countries with the most content on Netflix
select
	UNNEST (STRING_TO_ARRAY(country, ',')) AS NEW_COUNTRY,
	count (show_id) as total_conent
from netflix 
group by 1  
order by 2  desc 
limit 5

5. Identify the longest movie
SELECT * FROM NETFLIX
WHERE TYPEES = 'Movie'
AND
DURATION = (SELECT MAX(DURATION) FROM NETFLIX)
	

6. Find content added in the last 5 years
select typees ,title,date_added
	from netflix
where
	TO_DATE (date_added,'MONTH,DD,YYYY')>= CURRENT_DATE - INTERVAL  '5 year'



7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT director FROM NETFLIX                                                  

-- 8. List all TV shows with more than 5 seasons
SELECT * FROM NETFLIX
	WHERE
	typees  = 'TV shows'
	AND
	SPLIT_PART(duration,' ',1)::NUMERIC > 5
	
9. Count the number of content items in each genre

SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in,',')) AS GENRE,COUNT(*)
	FROM NETFLIX
	GROUP BY (GENRE)

10.Find each year and the average numbers of content release in India on netflix.
SELECT  
EXTRACT(YEAR FROM TO_DATE(date_added,'MONTH,DD,YYYY'))AS DATE,
COUNT(*) AS NUMBER_OF_CONTENT,
ROUND(
	COUNT(*)::numeric /(SELECT COUNT(*) FROM NETFLIX WHERE country ILIKE '%INDIA%')::numeric*100,2)
	AS AVG_CONTENT
FROM NETFLIX
WHERE country ILIKE '%INDIA%'
GROUP BY 1

11. List all movies that are documentaries
SELECT typees FROM NETFLIX
WHERE listed_in ILIKE '%Documentaries%'

12. Find all content without a director
SELECT * FROM NETFLIX
WHERE DIRECTOR IS NULL

13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT* FROM NETFLIX
WHERE CASTS ILIKE '%Salman Khan%'

14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select
	UNNEST(STRING_TO_ARRAY(casts,',')) as actor,
	count(*) as content
from netflix
where country ilike '%india%'
group by 1
order by 2 desc