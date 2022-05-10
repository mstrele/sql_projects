
/*have a look at the tables*/
SELECT * 
FROM stream
LIMIT 20;

SELECT * 
FROM chat 
LIMIT 20;

/*check the unique games and channels*/
SELECT DISTINCT game
FROM stream;

SELECT DISTINCT channel
FROM stream;

/*find the most popular games in stream table*/
SELECT game, COUNT(*) AS 'count'
FROM stream
GROUP BY 1
ORDER BY COUNT(*) DESC;

/*find the location of LoL viewers*/
SELECT country, COUNT(*) AS 'count'
FROM stream
WHERE game = 'League of Legends' 
      AND country IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;

/*find the source the user is using to view the stream and count their number*/
SELECT player, COUNT(*) AS 'count'
FROM stream
GROUP BY 1
ORDER BY 2 DESC;

/*create a table with games genres*/
SELECT game, 
  CASE
    WHEN game = 'League of Legends' THEN 'MOBA'
    WHEN game = 'Dota 2' THEN 'MOBA'
    WHEN game = 'Heroes of the Storm' THEN 'MOBA'
    WHEN game = 'Counter-Strike: Global Offensive' THEN 'FPS'
    WHEN game = 'DayZ ' THEN 'Survival'
    WHEN game = 'ARK: Survival Evolved' THEN 'Survival'
    ELSE 'Other'
  END AS 'genre',
  COUNT(*) AS 'count'
FROM stream
GROUP BY 1
ORDER BY 3 DESC;
/*check when veiwers watched on your country*/
SELECT time,
   strftime('%H', time) AS 'hours',
   COUNT(*)
FROM stream
WHERE country = 'UA'
GROUP BY 1;

/*join the two tables*/
SELECT *
FROM stream
JOIN chat
  ON stream.device_id = chat.device_id;

