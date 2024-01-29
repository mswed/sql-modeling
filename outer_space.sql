-- id |        name        | orbital_period_in_years |  orbits_around   |  galaxy   |                                                      moons
-- ----+--------------------+-------------------------+------------------+-----------+------------------------------------------------------------------------------------------------------------------
--   1 | Earth              |                       1 | The Sun          | Milky Way | {"The Moon"}
--   2 | Mars               |                    1.88 | The Sun          | Milky Way | {Phobos,Deimos}
--   3 | Venus              |                    0.62 | The Sun          | Milky Way | {}
--   4 | Neptune            |                   164.8 | The Sun          | Milky Way | {Naiad,Thalassa,Despina,Galatea,Larissa,"S/2004 N 1",Proteus,Triton,Nereid,Halimede,Sao,Laomedeia,Psamathe,Neso}
--   5 | Proxima Centauri b |                    0.03 | Proxima Centauri | Milky Way | {}
--   6 | Gliese 876 b       |                    0.23 | Gliese 876       | Milky Way | {}

-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE stars
(
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE galaxies
(
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE planets
(
    id                      SERIAL PRIMARY KEY,
    name                    TEXT  NOT NULL,
    orbital_period_in_years FLOAT NOT NULL,
    orbits_around           INTEGER REFERENCES stars,
    galaxy                  INTEGER REFERENCES galaxies
);

CREATE TABLE moons
(
    id        SERIAL PRIMARY KEY,
    planet_id INTEGER REFERENCES planets,
    name      TEXT
);



INSERT INTO stars (name)
VALUES ('The Sun'),
       ('Proxima Centauri'),
       ('Gliese 876');

INSERT INTO galaxies (name)
VALUES ('Milky Way');

INSERT INTO planets
    (name, orbital_period_in_years, orbits_around, galaxy)
VALUES ('Earth', 1.00, 1, 1),
       ('Mars', 1.88, 1, 1),
       ('Venus', 0.62, 1, 1),
       ('Neptune', 164.8, 1, 1),
       ('Proxima Centauri b', 0.03, 2, 1),
       ('Gliese 876 b', 0.23, 3, 1);

INSERT INTO moons (name, planet_id)
VALUES ('The Moon', 1),
       ('Phobos', 2),
       ('Deimos', 2),
       ('Naiad', 4),
       ('halassa', 4),
       ('Despina', 4),
       ('Galatea', 4),
       ('Larissa', 4),
       ('S/2004 N 1', 4),
       ('Proteus', 4),
       ('Triton', 4),
       ('Nereid', 4),
       ('Halimede', 4),
       ('Sao', 4),
       ('Laomedeia', 4),
       ('Psamathe', 4),
       ('Neso', 4);

SELECT p.name, p.orbital_period_in_years, stars.name, galaxies.name, moons.name
FROM planets p
         JOIN stars ON p.orbits_around = stars.id
         JOIN galaxies ON p.galaxy = galaxies.id
         LEFT JOIN moons ON p.id = moons.planet_id;
