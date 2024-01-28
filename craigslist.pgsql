DROP DATABASE craigslist;
CREATE DATABASE craigslist;
\c craigslist


CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(20) NOT NULL UNIQUE,
    first_name TEXT,
    last_name TEXT,
    preferred_region_id INTEGER REFERENCES regions
);

CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    region_id INTEGER REFERENCES regions
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(30),
    post_text TEXT,
    user_id INTEGER REFERENCES users,
    post_region_id INTEGER REFERENCES regions,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE post_categories (
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories,
    post_id INTEGER REFERENCES posts
);

INSERT INTO
regions (name)
VALUES
('New York City'),
('San Francisco'),
('Boston'),
('Albany');

INSERT INTO
users (username, first_name, last_name, preferred_region_id)
VALUES
('killerCrock', 'John', 'Reese', 1),
('purpleCrayon', 'Harold', 'Finch', 1),
('craycray', 'Root', 'something', 3),
('shakingItOff', 'Taylor', 'Swift', 2);

INSERT INTO
locations (name, region_id)
VALUES
('Upper East Side', 1),
('Fisherman''s Wharf', 2),
('Lombard Street', 2),
('Aquaruim', 3),
('Freedom Trail', 3),
('The Egg', 4);

INSERT INTO
categories (name)
VALUES
('Babysitting'),
('Dog Walking'),
('Food'),
('Friendship'), 
('Events');

INSERT INTO
posts (title, post_text, user_id, post_region_id, location_id)
VALUES
('concert tickets', 'I came by a bunch of concert tickets, any one wants to buy them?', 4, 2, 3),
('Looking for a job', 'Willing to work as a babysitter or a dog walker', 1, 1, 1),
('Need food!', 'Can anyone recommend a good Chinese restaurant in the area?', 3, 4, 4),
('Bored out of my mind', 'Want to be my friend?', 2, 3, 5);

INSERT INTO
post_categories (post_id, category_id)
VALUES
(1, 5),
(2, 2), 
(2, 1),
(3, 3), 
(4, 4);

-- SELECT title, post_text, first_name, last_name, r.name, l.name, c.name 
-- FROM posts p JOIN users u ON p.user_id = u.id 
--      JOIN regions r ON p.post_region_id = r.id
--      JOIN locations l ON p.location_id = l.id
--      JOIN post_categories pc ON pc.post_id = p.id 
--      JOIN categories c ON c.id = pc.category_id 
-- WHERE
--     p.id = 2;


