


SELECT title, score
FROM hacker_news
ORDER BY score DESC
LIMIT 5;


SELECT SUM(score)
FROM hacker_news;

SELECT user, score
FROM hacker_news
GROUP BY user
HAVING SUM(score) > 200
ORDER BY 2 DESC;

SELECT (517 + 309 + 304 + 282) / 6366.0;

SELECT user, 
    COUNT(*)
FROM hacker_news
WHERE url LIKE '%watch?v=dQw4w9WgXcQ%'
GROUP BY 1
ORDER BY 2 DESC;


SELECT COUNT(url), CASE
   WHEN url LIKE '%github.com%' THEN 'GitHub'
   WHEN url LIKE '%medium.com/%' THEN 'Medium'
   WHEN url LIKE '%nytimes.com/%' THEN 'NY TIMES'
    ELSE NULL
  END AS 'Source'
FROM hacker_news
GROUP BY 2
ORDER BY 1 ASC;


SELECT timestamp
FROM hacker_news
LIMIT 10;

SELECT
   strftime('%H', timestamp) AS 'time',
   ROUND(AVG(score),2) AS 'avg',
   COUNT(*) AS 'count'
FROM hacker_news
WHERE timestamp IS NOT NULL
GROUP BY 1
ORDER BY 1;




