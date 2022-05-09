 SELECT *
 FROM survey
 LIMIT 10;

 SELECT question,
   COUNT(DISTINCT user_id) AS 'answer_count'
FROM survey
GROUP BY 1;


SELECT * 
FROM quiz
LIMIT 5;

 
SELECT * 
FROM purchase
LIMIT 5;

SELECT * 
FROM home_try_on
LIMIT 5;

WITH new_table AS(
  SELECT DISTINCT q.user_id,
    h.user_id IS NOT NULL AS 'is_home_try_on',
    h.number_of_pairs AS 'ab_variant',
    p.user_id IS NOT NULL AS 'is_purchase'
  FROM quiz q
  LEFT JOIN home_try_on h
    ON q.user_id = h.user_id
  LEFT JOIN purchase p
    ON p.user_id = q.user_id
)
SELECT ab_variant, 
  SUM(CASE 
      WHEN is_home_try_on = 1 
      THEN 1
      ELSE 0
      END) 'home_try',
  SUM(CASE 
      WHEN is_purchase = 1
      THEN 1
      ELSE 0
      END) 'purchase'
FROM new_table
GROUP BY ab_variant
HAVING home_try >0;



