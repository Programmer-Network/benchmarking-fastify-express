CREATE TABLE
    IF NOT EXISTS dummy_table (
        id serial PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        value INTEGER NOT NULL
    );

INSERT INTO
    dummy_table (name, value)
VALUES ('Item 1', 10), ('Item 2', 20), ('Item 3', 30), ('Item 4', 40);