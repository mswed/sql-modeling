DROP DATABASE IF EXISTS soccer;
CREATE DATABASE soccer;
\c soccer

CREATE TABLE seasons
(
    id         SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date   DATE NOT NULL,
    name       TEXT
);

CREATE TABLE teams
(
    id   SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE players
(
    id      SERIAL PRIMARY KEY,
    team_id INTEGER REFERENCES teams,
    name    TEXT
);

CREATE TABLE games
(
    id        SERIAL PRIMARY KEY,
    team1_id  INTEGER REFERENCES teams,
    team2_id  INTEGER REFERENCES teams,
    season_id INTEGER REFERENCES seasons,
    game_date DATE
);

CREATE TABLE goals
(
    id        SERIAL PRIMARY KEY,
    game_id   INTEGER REFERENCES games,
    player_id INTEGER REFERENCES players,
    team_id   INTEGER REFERENCES teams
);

CREATE TABLE referees
(
    id   SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE game_referees
(
    id         SERIAL PRIMARY KEY,
    game_id    INTEGER REFERENCES games,
    referee_id INTEGER REFERENCES referees
);

INSERT INTO seasons (start_date, end_date, name)
VALUES ('2023-02-25', '2023-10-21', 'regular season'),
       ('2023-10-25', '2023-12-09', 'playoffs');

INSERT INTO teams (name)
VALUES ('Arsenal'),
       ('Liverpool'),
       ('Chelsea'),
       ('Manchester United'),
       ('Newcastle United');

INSERT INTO players (team_id, name)
VALUES (1, 'Bob'),
       (1, 'Zoolander'),
       (1, 'Jimbo'),
       (2, 'Ed'),
       (2, 'Michael'),
       (2, 'Norman'),
       (2, 'Harold'),
       (3, 'John'),
       (5, 'Dingo');

INSERT INTO games (team1_id, team2_id, season_id, game_date)
VALUES (1, 5, 1, '2023-02-26'),
       (2, 4, 1, '2023-03-05'),
       (3, 1, 1, '2023-04-09'),
       (4, 5, 2, '2023-05-17');

INSERT INTO goals (game_id, player_id, team_id)
VALUES (1, 1, 1),
       (1, 1, 1),
       (1, 3, 1),
       (1, 5, 5),
       (2, 9, 2),
       (2, 4, 2),
       (2, 5, 4);

INSERT INTO referees (name)
VALUES ('Albert'),
       ('Monica'),
       ('James');
INSERT INTO game_referees (game_id, referee_id)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (4, 2);

SELECT game_date, ta.name AS team_a, tb.name AS team_b, s.name AS season, r.name
FROM games g
         JOIN teams ta ON ta.id = g.team1_id
         JOIN teams tb ON tb.id = g.team2_id
         JOIN seasons s ON g.season_id = s.id
         JOIN game_referees gr ON g.id = gr.game_id
         JOIN referees r ON r.id = gr.referee_id;

SELECT game_date,
       ta.name,
       SUM(CASE WHEN ga.team_id = g.team1_id THEN 1 ELSE 0 END) AS team_a_score,
       tb.name,
       SUM(CASE WHEN ga.team_id = g.team2_id THEN 1 ELSE 0 END) AS team_b_score
FROM games g
         JOIN goals ga ON ga.game_id = g.id
         JOIN teams ta ON g.team1_id = ta.id
         JOIN teams tb ON g.team2_id = tb.id
WHERE g.id = 1
GROUP BY g.id, ta.name, tb.name;

SELECT game_date,

       CASE
           WHEN SUM(CASE WHEN g.team_id = games.team1_id THEN 1 ELSE 0 END) >
                SUM(CASE WHEN g.team_id = games.team2_id THEN 1 ELSE 0 END) THEN games.team1_id
           WHEN SUM(CASE WHEN g.team_id = games.team1_id THEN 1 ELSE 0 END) <
                SUM(CASE WHEN g.team_id = games.team2_id THEN 1 ELSE 0 END) THEN games.team2_id
           END
FROM games
         LEFT JOIN goals g on games.id = g.game_id
GROUP BY games.id

