CREATE DATABASE chordgram;

BEGIN;
CREATE TABLE chords(
    id SERIAL PRIMARY KEY,
    memo text DEFAULT ''
);

INSERT INTO chords (memo) VALUES
('a'),
('b'),
('c'),
('d'),
('e'),
('f'),
('g'),
('h'),
('i'),
('j'),
('k');


COMMIT;



DROP TABLE chords