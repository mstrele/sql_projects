/* take a look at the tables */
SELECT * 
FROM employees;

SELECT * 
FROM projects;

/*check the employees who have not chosen any projects*/
SELECT first_name, last_name
FROM employees
WHERE current_project IS NULL;

/*checks the names of projects that were not chosen by any employees*/
SELECT project_name 
FROM projects
WHERE project_id NOT IN (
   SELECT current_project
   FROM employees
   WHERE current_project IS NOT NULL);

/*finds the name of the project chosen by the most employees*/
SELECT projects.project_name, COUNT(employees.current_project) AS 'times_chosen'
FROM projects
LEFT JOIN employees
ON employees.current_project = projects.project_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/*finds projects that were chosen by multiple employees*/
SELECT project_name
FROM projects
INNER JOIN employees 
  ON projects.project_id = employees.current_project
WHERE current_project IS NOT NULL
GROUP BY current_project
HAVING COUNT(current_project) > 1;

/*finds how many available project positions there are for developers*/
SELECT (COUNT(*) * 2) - (
  SELECT COUNT(*)
  FROM employees
  WHERE current_project IS NOT NULL
    AND position = 'Developer') AS 'Count'
FROM projects;

/* personality that is the most common across our employees*/
SELECT personality, COUNT(personality) AS 'personality_count'
FROM employees
GROUP BY personality
ORDER BY 2 DESC
LIMIT 1;

/*names of projects chosen by employees with the most common personality type*/
SELECT projects.project_name, COUNT(employees.current_project) AS 'times_chosen'
FROM projects
INNER JOIN employees
ON employees.current_project = projects.project_id
WHERE employees.personality = 'ENFJ'
GROUP BY 1
ORDER BY 2 DESC;

/* personality type most represented by employees with a selected project*/
SELECT last_name, first_name, personality, project_name
FROM employees
INNER JOIN projects 
  ON employees.current_project = projects.project_id
WHERE personality = (
   SELECT personality 
   FROM employees
   WHERE current_project IS NOT NULL
   GROUP BY personality
   ORDER BY COUNT(personality) DESC
   LIMIT 1);

/*For each employee, provide their name, personality, the names 
of any projects they’ve chosen, and the number of incompatible co-workers*/
SELECT last_name, first_name, personality, project_name,
CASE 
   WHEN personality = 'INFP' 
   THEN (SELECT COUNT(*)
      FROM employees 
      WHERE personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))
   WHEN personality = 'ISFP' 
   THEN (SELECT COUNT(*)
      FROM employees 
      WHERE personality IN ('INFP', 'ENTP', 'INFJ'))
   WHEN personality = 'ENFP' 
   THEN (SELECT COUNT(*)
      FROM employees 
      WHERE personality IN ('ISFP, ESFP, ISTP, ESTP, ISFJ, ESFJ, ISTJ, ESTJ'))
   WHEN personality = 'INFJ' 
   THEN (SELECT COUNT(*)
      FROM employees 
      WHERE personality IN ('ISFP, ESFP, ISTP, ESTP, ISFJ, ESFJ, ISTJ, ESTJ'))
   -- ... and so on
   ELSE 0
END AS 'IMCOMPATS'
FROM employees
LEFT JOIN projects on employees.current_project = projects.project_id;