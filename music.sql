-- id |         title          | duration_in_seconds | release_date |              artists              |           album           |             producers
-- ----+------------------------+---------------------+--------------+-----------------------------------+---------------------------+------------------------------------
--   1 | MMMBop                 |                 238 | 1997-04-15   | {Hanson}                          | Middle of Nowhere         | {"Dust Brothers","Stephen Lironi"}
--   2 | Bohemian Rhapsody      |                 355 | 1975-10-31   | {Queen}                           | A Night at the Opera      | {"Roy Thomas Baker"}
--   3 | One Sweet Day          |                 282 | 1995-11-14   | {"Mariah Cary","Boyz II Men"}     | Daydream                  | {"Walter Afanasieff"}
--   4 | Shallow                |                 216 | 2018-09-27   | {"Lady Gaga","Bradley Cooper"}    | A Star Is Born            | {"Benjamin Rice"}
--   5 | How You Remind Me      |                 223 | 2001-08-21   | {Nickelback}                      | Silver Side Up            | {"Rick Parashar"}
--   6 | New York State of Mind |                 276 | 2009-10-20   | {"Jay Z","Alicia Keys"}           | The Blueprint 3           | {"Al Shux"}
--   7 | Dark Horse             |                 215 | 2013-12-17   | {"Katy Perry","Juicy J"}          | Prism                     | {"Max Martin",Cirkut}
--   8 | Moves Like Jagger      |                 201 | 2011-06-21   | {"Maroon 5","Christina Aguilera"} | Hands All Over            | {Shellback,"Benny Blanco"}
--   9 | Complicated            |                 244 | 2002-05-14   | {"Avril Lavigne"}                 | Let Go                    | {"The Matrix"}
--  10 | Say My Name            |                 240 | 1999-11-07   | {"Destiny's Child"}               | The Writing's on the Wall | {Darkchild}
-- (10 rows)

-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE albums
(
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE artists
(
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE producers
(
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE songs
(
    id                  SERIAL PRIMARY KEY,
    title               TEXT                      NOT NULL,
    duration_in_seconds INTEGER                   NOT NULL,
    release_date        DATE                      NOT NULL,
    album               INTEGER REFERENCES albums NOT NULL
);


CREATE TABLE artists_songs
(
    id        SERIAL PRIMARY KEY,
    artist_id INTEGER REFERENCES artists NOT NULL,
    song_id   INTEGER REFERENCES songs   NOT NULL
);

CREATE TABLE producers_songs
(
    id          SERIAL PRIMARY KEY,
    producer_id INTEGER REFERENCES producers NOT NULL,
    song_id     INTEGER REFERENCES songs     NOT NULL
);

INSERT INTO artists (name)
VALUES ('Hanson'),
       ('Queen'),
       ('Mariah Cary'),
       ('Boyz II Men'),
       ('Lady Gaga'),
       ('Bradley Cooper'),
       ('Nickelback'),
       ('Jay Z'),
       ('Alicia Keys'),
       ('Katy Perry'),
       ('Juicy J'),
       ('Maroon 5'),
       ('Christina Aguilera'),
       ('Arvil Lavigne'),
       ('Destiny''s Child');

INSERT INTO producers (name)
VALUES ('Dust Brothers'),
       ('Stephen Lironi'),
       ('Roy Thomas Baker'),
       ('Walter Afanasieff'),
       ('Benjamin Rice'),
       ('Rick Parashar'),
       ('Al Shux'),
       ('Max Martin'),
       ('Cirkut'),
       ('Shllback'),
       ('Benny Blanco'),
       ('The Matrix'),
       ('BDarkchild');

INSERT INTO albums (name)
VALUES ('Middle of Nowhere'),
       ('A Night at the Opera'),
       ('Daydream'),
       ('A Star Is Born'),
       ('Silver Side UP'),
       ('The Blueprint 3'),
       ('Prism'),
       ('Hands All Over'),
       ('Let Go'),
       ('The Writing''s on the Wall');

INSERT INTO songs
    (title, duration_in_seconds, release_date, album)
VALUES ('MMMBop', 238, '04-15-1997', 1),
       ('Bohemian Rhapsody', 355, '10-31-1975', 2),
       ('One Sweet Day', 282, '11-14-1995', 3),
       ('Shallow', 216, '09-27-2018', 4),
       ('How You Remind Me', 223, '08-21-2001', 5),
       ('New York State of Mind', 276, '10-20-2009', 6),
       ('Dark Horse', 215, '12-17-2013', 7),
       ('Moves Like Jagger', 201, '06-21-2011', 8),
       ('Complicated', 244, '05-14-2002', 9),
       ('Say My Name', 240, '11-07-1999', 10);

INSERT INTO artists_songs
    (song_id, artist_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (3, 4),
       (4, 5),
       (4, 6),
       (5, 7),
       (6, 8),
       (6, 9),
       (7, 10),
       (7, 11),
       (8, 12),
       (8, 13),
       (9, 14),
       (10, 15);

INSERT INTO producers_songs
    (song_id, producer_id)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (3, 4),
       (4, 5),
       (5, 6),
       (6, 7),
       (7, 8),
       (7, 9),
       (8, 10),
       (8, 11),
       (9, 12),
       (10, 13);


SELECT s.id, s.title, s.duration_in_seconds, s.release_date, a.name, a2.name, p.name
FROM songs s
         JOIN artists_songs ars ON s.id = ars.song_id
         JOIN artists a ON ars.artist_id = a.id
         JOIN albums a2 on s.album = a2.id
         JOIN producers_songs ps on s.id = ps.song_id
         JOIN producers p on ps.producer_id = p.id;
