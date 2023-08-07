/*Problem:
The customer is looking to create a new app and wants to know the best type of app to create
*/

CREATE TABLE appleStore_description_combined AS

SELECT * FROM appleStore_description1
UNION ALL 
SELECT * FROM appleStore_description2
UNION ALL
SELECT * FROM appleStore_description3
UNION ALL
SELECT * FROM appleStore_description4

-- Exploratory Data Analysis -- 
-- check the number of unique apps

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM AppleStore 

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM appleStore_description_combined 


-- check for missing values
SELECT COUNT(*) AS MissingValues 
FROM AppleStore
WHERE track_name IS NULL OR user_rating IS NULL OR prime_genre IS NULL

SELECT count(*) AS MissingValues 
FROM appleStore_description_combined
WHERE app_desc IS NULL

-- Find the number of apps per genre
SELECT prime_genre, COUNT(*) AS NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC

-- Get an overview of the apps' ratingAppleStore
SELECT min(user_rating) AS MinRating, 
	   max(user_rating) AS MaxRating,
       avg(user_rating) AS AvgRating
FROM AppleStore

-- Data Analysis-- 

-- Determine whether paid apps have higher ratings than free apps
SELECT CASE
	WHEN price > 0 THEN 'Paid'
    ELSE 'Free'
  END AS App_Type,
  avg(user_rating) as Avg_Rating
FROM AppleStore
GROUP BY App_Type

-- Check if apps with more languages have higher ratings
SELECT CASE
	WHEN lang_num < 10 THEN '<10 languages'
    WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 languages'
    ELSE '> 30 languages'
  END AS language_bracket,
  avg(user_rating) AS Avg_Rating
 FROM AppleStore
 GROUP BY language_bracket
 ORDER BY Avg_Rating
 
 -- Check genres with low_ratings
 SELECT prime_genre,
 	avg(user_rating) AS Avg_Rating
   FROM AppleStore
   GROUP BY prime_genre
   ORDER BY Avg_Rating ASC
   LIMIT 10
   
 -- Check if there is correlation between the length of the app description and user ratingAppleStore
 SELECT CASE
      WHEN LENGTH(b.app_desc) <500 THEN 'Short'
      WHEN LENGTH(b.app_desc) BETWEEN 500 AND 1000 THEN 'Medium'
      Else 'Long'
   END AS description_length_bracket,
   avg(a.user_rating) AS average_rating
 
 FROM 
 	AppleStore AS A
 JOIN
 	appleStore_description_combined AS b
  ON 
  	a.id = b.id
    
 GROUP BY description_length_bracket
 ORDER BY average_rating DESC
 
 -- Check the top-rated apps for each genre
 SELECT 
	prime_genre, track_name, user_rating
 FROM (
   SELECT
   		prime_genre, track_name, user_rating,
   		RANK()  OVER(PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS rank
   		FROM 
   		AppleStore
   	) AS a 
  WHERE
  a.rank = 1
   	
    
 /*Conclusions*
 --1. Paid apps have higher ratings
 --2. Apps Supporting betweeen 10 and 30 languages have higher ratings
 --3. Finance and Books Apps have low ratings --> market opportunity
 --4. Apps with a longer description have better ratings
 --5. A new app should aim for an average rating above 3.5
 --6. Games and Entertainment have high competition but high demand
  */
   