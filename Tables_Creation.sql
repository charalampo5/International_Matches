--Creation Of Tables--
CREATE TABLE goalscorers (
	match_date DATE NOT NULL,
	home_team VARCHAR(50) NOT NULL,
	away_team VARCHAR(50) NOT NULL,
	team VARCHAR(50) NOT NULL,
	scorer VARCHAR(200),
	goal_minute SMALLINT,
	own_goal BOOLEAN NOT NULL,
	penalty BOOLEAN NOT NULL
);

CREATE TABLE results(
	match_date DATE NOT NULL,
	home_team VARCHAR(50) NOT NULL,
	away_team VARCHAR(50) NOT NULL,
	home_score SMALLINT NOT NULL,
	away_score SMALLINT NOT NULL,
	tournament VARCHAR(100) NOT NULL,
	city VARCHAR(100) NOT NULL,
	country VARCHAR(100) NOT NULL,
	neutral BOOLEAN NOT NULL
);

CREATE TABLE shootouts(
	match_date DATE NOT NULL,
	home_team VARCHAR(50) NOT NULL,
	away_team VARCHAR(50) NOT NULL,
	winner VARCHAR(50) NOT NULL
);