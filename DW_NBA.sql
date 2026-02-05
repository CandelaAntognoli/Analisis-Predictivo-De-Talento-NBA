CREATE DATABASE NBA_DW;
GO
USE NBA_DW;
GO
--
CREATE TABLE DIM_PLAYER (
    player_key INT IDENTITY(1,1) PRIMARY KEY,
    person_id NVARCHAR(50) NOT NULL,
    player_name NVARCHAR(150) NOT NULL,
    position NVARCHAR(10),
    country NVARCHAR(100),
    height_cm DECIMAL(5,2),
    weight_kg DECIMAL(5,2)
);
GO

CREATE UNIQUE INDEX UX_DIM_PLAYER_person_id
ON DIM_PLAYER (person_id);
GO
--
CREATE TABLE DIM_TEAM (
    team_key INT IDENTITY(1,1) PRIMARY KEY,
    team_id INT NOT NULL,
    abbreviation NVARCHAR(10),
    nickname NVARCHAR(100),
    city NVARCHAR(100),
    year_founded INT
);
GO

CREATE UNIQUE INDEX UX_DIM_TEAM_team_id
ON DIM_TEAM (team_id);
GO
--
CREATE TABLE DIM_DATE (
    date_key INT PRIMARY KEY,       -- YYYYMMDD
    full_date DATE NOT NULL,
    year INT,
    month INT,
    day INT,
    season_year INT
);
GO
--
CREATE TABLE FACT_GAME (
    game_fact_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    game_id NVARCHAR(50) NOT NULL,
    player_key INT NOT NULL,
    team_key INT NOT NULL,
    date_key INT NOT NULL,

    points INT,
    assists INT,
    rebounds INT,
    steals INT,
    blocks INT,
    turnovers INT,
    minutes_played DECIMAL(5,2),
    plus_minus INT,

    CONSTRAINT FK_FACT_GAME_PLAYER
        FOREIGN KEY (player_key) REFERENCES DIM_PLAYER(player_key),

    CONSTRAINT FK_FACT_GAME_TEAM
        FOREIGN KEY (team_key) REFERENCES DIM_TEAM(team_key),

    CONSTRAINT FK_FACT_GAME_DATE
        FOREIGN KEY (date_key) REFERENCES DIM_DATE(date_key)
);
GO
--
CREATE TABLE FACT_COMBINE (
    combine_fact_id INT IDENTITY(1,1) PRIMARY KEY,

    player_key INT NOT NULL,
    season_year INT NOT NULL,

    max_vertical_leap DECIMAL(5,2),
    lane_agility_time DECIMAL(5,2),
    three_quarter_sprint DECIMAL(5,2),
    wingspan DECIMAL(5,2),
    bench_press INT,

    CONSTRAINT FK_FACT_COMBINE_PLAYER
        FOREIGN KEY (player_key) REFERENCES DIM_PLAYER(player_key)
);
GO
--
CREATE TABLE MAP_PLAYER_TEAM (
    player_key INT NOT NULL,
    team_key INT NOT NULL,
    from_year INT NOT NULL,
    to_year INT NOT NULL,

    CONSTRAINT PK_MAP_PLAYER_TEAM
        PRIMARY KEY (player_key, team_key, from_year),

    CONSTRAINT FK_MAP_PLAYER_TEAM_PLAYER
        FOREIGN KEY (player_key) REFERENCES DIM_PLAYER(player_key),

    CONSTRAINT FK_MAP_PLAYER_TEAM_TEAM
        FOREIGN KEY (team_key) REFERENCES DIM_TEAM(team_key)
);
GO
--
SELECT COUNT(*) FROM DIM_PLAYER;
SELECT COUNT(*) FROM DIM_TEAM;
SELECT COUNT(*) FROM FACT_GAME;
SELECT COUNT(*) FROM FACT_COMBINE;
--
SELECT TOP 10
    p.player_name,
    t.nickname AS team,
    g.points,
    g.plus_minus
FROM FACT_GAME g
JOIN DIM_PLAYER p ON g.player_key = p.player_key
JOIN DIM_TEAM t ON g.team_key = t.team_key;
--
ALTER TABLE DIM_PLAYER
ALTER COLUMN position NVARCHAR(30);
GO
--
DELETE FROM DIM_PLAYER;
GO
--
ALTER TABLE DIM_PLAYER
ALTER COLUMN position NVARCHAR(30);
GO
--
DELETE FROM DIM_PLAYER;
GO
--
SELECT COUNT(*) AS cnt FROM DIM_PLAYER;
SELECT COUNT(*) AS cnt FROM DIM_TEAM;
SELECT COUNT(*) AS cnt FROM DIM_DATE;
SELECT COUNT(*) AS cnt FROM MAP_PLAYER_TEAM;
SELECT COUNT(*) AS cnt FROM FACT_COMBINE;
--
SELECT COUNT(*) FROM DIM_PLAYER;
SELECT COUNT(*) FROM DIM_TEAM;
SELECT COUNT(*) FROM DIM_DATE;
SELECT COUNT(*) FROM MAP_PLAYER_TEAM;
SELECT COUNT(*) FROM FACT_COMBINE;











