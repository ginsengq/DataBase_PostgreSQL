create database lab9;

CREATE TABLE Reviewer (
    reviewerID INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Review (
    reviewerID INT,
    movieID INT,
    rating INT,
    reviewDate DATE,
    FOREIGN KEY (reviewerID) REFERENCES Reviewer(reviewerID),
    FOREIGN KEY (movieID) REFERENCES Movie(movieID)
);

CREATE TABLE Movie (
    movieID INT PRIMARY KEY,
    title VARCHAR(100),
    releaseYear INT,
    director VARCHAR(50)
);

INSERT INTO Reviewer (reviewerID, name) VALUES
(301, 'Alex Johnson'),
(302, 'Maria Gomez'),
(303, 'John Doe'),
(304, 'Linda Brown'),
(305, 'Michael Thompson'),
(306, 'Emily Davis'),
(307, 'Daniel White'),
(308, 'Sophia Lee');

INSERT INTO Review (reviewerID, movieID, rating, reviewDate) VALUES
(301, 401, 5, '2024-02-15'),
(301, 402, 4, '2024-02-20'),
(302, 403, 5, '2024-01-11'),
(303, 404, 3, '2024-01-23'),
(304, 405, 4, '2024-01-15'),
(305, 406, 2, '2024-03-01'),
(306, 407, 5, '2024-02-05'),
(307, 408, 4, '2024-03-12');

INSERT INTO Movie (movieID, title, releaseYear, director) VALUES
(401, 'Future World', 2024, 'Alice Smith'),
(402, 'The Last Adventure', 2024, 'John Black'),
(403, 'New Horizons', 2024, 'Maria Johnson'),
(404, 'Time Capsule', 2024, 'Chris Martin'),
(405, 'Beyond the Stars', 2024, NULL),
(406, 'The Silent Valley', 2024, 'Laura Green'),
(407, 'Lost in the Echo', 2024, 'Daniel White'),
(408, 'Shadow of Destiny', 2024, 'James Clarke');

CREATE VIEW HighRatedMoviesReleaseYear AS
SELECT DISTINCT releaseYear
FROM Movie
JOIN Review ON Movie.movieID = Review.movieID
WHERE Review.rating >= 4
ORDER BY releaseYear ASC;

CREATE INDEX idx_movie_releaseYear ON Movie(releaseYear);
CREATE INDEX idx_review_rating ON Review(rating);

CREATE ROLE new_user_role LOGIN CREATEDB CREATEROLE;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO new_user_role;

\ALTER TABLE Reviewer OWNER TO new_user_role;
ALTER TABLE Review OWNER TO new_user_role;
ALTER TABLE Movie OWNER TO new_user_role;

CREATE VIEW TopRatedMovies2024 AS
SELECT Movie.title, Reviewer.name
FROM Movie
JOIN Review ON Movie.movieID = Review.movieID
JOIN Reviewer ON Review.reviewerID = Reviewer.reviewerID
WHERE Review.rating = 5 AND EXTRACT(YEAR FROM Review.reviewDate) = 2024
ORDER BY Movie.title ASC;
