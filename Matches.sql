--Match Results Analysis--
SELECT CONCAT(home_team, '-', away_team) AS match,CONCAT(home_score, '-', away_score) AS score,
(CASE
	WHEN home_score > away_score THEN '1'
	WHEN home_score < away_score THEN '2'
	ELSE 'X' 
	END) AS result
FROM results

--Count Of The Different Results--
SELECT 
(CASE
	WHEN home_score > away_score THEN '1'
	WHEN home_score < away_score THEN '2'
	ELSE 'X' 
	END) AS result, COUNT(*) AS total_matches
FROM results
GROUP BY result
ORDER BY result


---Goal Scoring Analysis---

--Average Goals Per Match--
SELECT ROUND(AVG(home_score + away_score),2) AS average_goals_scored
FROM results

--Distribution Of Goals By Minute--
SELECT goal_minute, COUNT(*) AS goals_scored
FROM goalscorers
GROUP BY goal_minute
ORDER BY goals_scored DESC;

--Total Of Own Goals And Penalties Scored--
SELECT SUM(CASE WHEN own_goal = TRUE THEN 1 ELSE 0 END) AS total_own_goals,
SUM(CASE WHEN penalty = TRUE THEN 1 ELSE 0 END) AS total_penalties
FROM goalscorers

--Top 10 Scorers--
SELECT scorer, COUNT(*) AS goals
FROM goalscorers
GROUP BY scorer
ORDER BY goals DESC
LIMIT 10;

--Average Goals Per Tournament--
SELECT tournament, ROUND(AVG(home_score + away_score),2) AS average_goals_scored
FROM results
GROUP BY tournament
ORDER BY average_goals_scored DESC;


---Shootouts Analysis---

--Total Games That Have Gone To Penalties--
SELECT COUNT(*) FROM shootouts

--Countries That Have Lost In Penalties Most Times-- 
SELECT 
(CASE WHEN home_team = winner THEN away_team
ELSE home_team
END) AS loser, COUNT(*) AS number_of_games
FROM shootouts
GROUP BY loser
ORDER BY COUNT(*) DESC;

--Countries That Have Won In Penalties Most Times-- 
SELECT winner, COUNT(*) FROM shootouts
GROUP BY winner
ORDER BY COUNT(*) DESC


---Date Analysis---

--Games Played Each Year--
SELECT EXTRACT(YEAR FROM match_date) AS year,COUNT(*) AS games_played
FROM results
GROUP BY year
ORDER BY games_played DESC;

--Average Games Per Month--
SELECT TO_CHAR(TO_DATE(EXTRACT(MONTH FROM match_date)::text, 'MM'), 'Month') AS month, COUNT(*) AS games_played
FROM results
GROUP BY month
ORDER BY COUNT(*) DESC;


---Location Analysis---

--Cities That Have Hosted The Most Matches--
SELECT city, COUNT(*) AS total_games_hosted
FROM results
GROUP BY city
ORDER BY COUNT(*) DESC;

--Countries That Have Hosted The Most World Cup Games--
SELECT country, COUNT(*) AS world_cup_games_hosted
FROM results
WHERE tournament LIKE 'FIFA World Cup'
GROUP BY country
ORDER BY COUNT(*) DESC;

---Analysis Using JOIN---

--FIFA World Cup Scorers With More Than 10 Goals--
SELECT scorer,COUNT(*) AS goals, goalscorers.team 
FROM goalscorers
INNER JOIN results
ON results.match_date = goalscorers.match_date
AND results.home_team = goalscorers.home_team
WHERE tournament LIKE 'FIFA World Cup'
GROUP BY tournament,scorer,goalscorers.team 
HAVING COUNT(*) >= 10
ORDER BY COUNT(*) DESC;
