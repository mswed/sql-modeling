-- id | first_name | last_name  | seat |      departure      |       arrival       |      airline      |   from_city   | from_country  |   to_city   |   to_country
-- ----+------------+------------+------+---------------------+---------------------+-------------------+---------------+---------------+-------------+----------------
--   1 | Jennifer   | Finch      | 33B  | 2018-04-08 09:00:00 | 2018-04-08 12:00:00 | United            | Washington DC | United States | Seattle     | United States
--   2 | Thadeus    | Gathercoal | 8A   | 2018-12-19 12:45:00 | 2018-12-19 16:15:00 | British Airways   | Tokyo         | Japan         | London      | United Kingdom
--   3 | Sonja      | Pauley     | 12F  | 2018-01-02 07:00:00 | 2018-01-02 08:03:00 | Delta             | Los Angeles   | United States | Las Vegas   | United States
--   4 | Jennifer   | Finch      | 20A  | 2018-04-15 16:50:00 | 2018-04-15 21:00:00 | Delta             | Seattle       | United States | Mexico City | Mexico
--   5 | Waneta     | Skeleton   | 23D  | 2018-08-01 18:30:00 | 2018-08-01 21:50:00 | TUI Fly Belgium   | Paris         | France        | Casablanca  | Morocco
--   6 | Thadeus    | Gathercoal | 18C  | 2018-10-31 01:15:00 | 2018-10-31 12:55:00 | Air China         | Dubai         | UAE           | Beijing     | China
--   7 | Berkie     | Wycliff    | 9E   | 2019-02-06 06:00:00 | 2019-02-06 07:47:00 | United            | New York      | United States | Charlotte   | United States
--   8 | Alvin      | Leathes    | 1A   | 2018-12-22 14:42:00 | 2018-12-22 15:56:00 | American Airlines | Cedar Rapids  | United States | Chicago     | United States
--   9 | Berkie     | Wycliff    | 32B  | 2019-02-06 16:28:00 | 2019-02-06 19:18:00 | American Airlines | Charlotte     | United States | New Orleans | United States
--  10 | Cory       | Squibbes   | 10D  | 2019-01-20 19:30:00 | 2019-01-20 22:45:00 | Avianca Brasil    | Sao Paolo     | Brazil        | Santiago    | Chile
-- (10 rows)

-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE airlines
(
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE cities
(
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE countries
(
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE

);

CREATE TABLE tickets
(
    id           SERIAL PRIMARY KEY,
    first_name   TEXT                         NOT NULL,
    last_name    TEXT                         NOT NULL,
    seat         TEXT                         NOT NULL,
    departure    TIMESTAMP                    NOT NULL,
    arrival      TIMESTAMP                    NOT NULL,
    airline      INTEGER REFERENCES airlines  NOT NULL,
    from_city    INTEGER REFERENCES cities    NOT NULL,
    from_country INTEGER REFERENCES countries NOT NULL,
    to_city      INTEGER REFERENCES cities    NOT NULL,
    to_country   INTEGER REFERENCES cities    NOT NULL
);

INSERT INTO airlines (name)
VALUES ('United'),
       ('British Airways'),
       ('Delta'),
       ('TUI Fly Belgium'),
       ('Air China'),
       ('American Airlines'),
       ('Avianca Brasil');

INSERT INTO cities (name)
VALUES ('Washington DC'),
       ('Tokyo'),
       ('Los Angeles'),
       ('Seattle'),
       ('Paris'),
       ('Dubai'),
       ('New York'),
       ('Cedar Rapids'),
       ('Charlotte'),
       ('San Paolo'),
       ('London'),
       ('Las Vegas'),
       ('Mexico City'),
       ('Casablanca'),
       ('Beijing'),
       ('Charlotte'),
       ('Chicago'),
       ('New Orleans'),
       ('Saniago');

INSERT INTO countries (name)
VALUES ('United States'),
       ('Japan'),
       ('France'),
       ('UAE'),
       ('Brazil'),
       ('United Kingdom'),
       ('Mexico'),
       ('Morocco'),
       ('China'),
       ('Chile');

INSERT INTO tickets
(first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
VALUES ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 1,
        1, 4, 1),
       ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 2, 2,
        2, 11, 6),
       ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 3, 3, 1,
        12, 1),
       ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 3, 4, 1,
        13, 7),
       ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 4, 5, 3,
        14, 8),
       ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 5, 6, 4,
        15, 9),
       ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 1, 7, 1,
        16, 1),
       ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 6, 8,
        1, 17, 1),
       ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 6, 9,
        1, 18, 1),
       ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 7, 10,
        5, 19, 10);


SELECT tickets.id,
       first_name,
       last_name,
       seat,
       departure,
       arrival,
       a.name,
       fc.name,
       fcu.name,
       tc.name,
       tcu.name
FROM tickets
         JOIN airlines a ON tickets.airline = a.id
         JOIN cities fc ON tickets.from_city = fc.id
         JOIN cities tc ON tickets.to_city = tc.id
        JOIN countries fcu on tickets.from_country = fcu.id
        JOIN countries tcu on tickets.to_country = tcu.id;
