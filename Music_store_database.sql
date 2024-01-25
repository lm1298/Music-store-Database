-- Create Genres Table
CREATE DATABASE Music;
USE Music;
CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    GenreName TEXT NOT NULL
);
INSERT INTO Genres (GenreID, GenreName) VALUES
    (1, 'Pop'),
    (2, 'R&B'),
    (3, 'Country'),
    (4, 'Classic'),
    (5, 'K-Pop');

-- Create Artists Table
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name TEXT NOT NULL
);
SELECT * FROM Artists;
INSERT INTO Artists (ArtistID, Name) VALUES
    (1, 'Taylor'),
    (2, 'Ariana'),
    (3, 'Charlie'),
    (4, 'ThV'),
    (5, 'Jungkook');

-- Create Albums Table
CREATE TABLE Albums (
    AlbumID INT PRIMARY KEY,
    Title TEXT NOT NULL,
    ArtistID INT,
    ReleaseYear DATE,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID) ON DELETE CASCADE
);
SELECT * FROM Albums;
INSERT INTO Albums (AlbumID, Title, ArtistID, ReleaseYear) VALUES
     (1, 'SpeakNow', 1, '2020-01-01'),
     (2, 'Reputation', 2, '2019-01-01'),
     (3, 'Golden', 2, '2022-01-01'),
     (4, 'lover', 4, '2017-01-01'),
     (5, 'Dynamite', 5, '2022-01-01');
     
    
-- Create Songs Table
CREATE TABLE Songs (
    SongID INT PRIMARY KEY,
    Title TEXT NOT NULL,
    ArtistID INT,
    AlbumID INT,
    GenreID INT,
    ReleaseYear DATE,
    Duration INT ,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID) ON DELETE CASCADE,
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID) ON DELETE CASCADE
);
SELECT * FROM Songs;
INSERT INTO Songs (SongID, Title, ArtistID, AlbumID, GenreID, ReleaseYear, Duration) VALUES
    (1, 'Love Story', 1, 1, 1, '2008-01-01', 240),
    (2, 'God is a Woman', 2, 2, 2, '2018-01-01', 210),
    (3, 'Attention', 3, 3, 3, '2017-01-01', 200),
    (4, 'Cherry Blossom', 4, 4, 4, '2021-01-01', 180),
    (5, 'Dynamite', 5, 5, 5, '2020-01-01', 223);
SELECT ArtistID FROM artists;
INSERT INTO artists (ArtistID, Name) VALUES (6, 'Taylor');


-- Create Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username TEXT NOT NULL,
    Password TEXT NOT NULL,
    FullName TEXT NOT NULL,
    Email TEXT NOT NULL,
    RegistrationDate DATE
);
SELECT * FROM music.users;
INSERT INTO Users (UserID, Username, Password, FullName, Email, RegistrationDate) VALUES
    (1, 'musiclover92', 'password123', 'John Doe', 'john.doe@email.com', '2023-01-15'),
    (2, 'lucky', 'securepass', 'Jane Smith', 'lucky@email.com', '2023-02-20'),
    (3, 'prasanna', 'pass123', 'Chris Johnson', 'prasanna@email.com', '2023-03-10');
    
-- Create Ratings Table
CREATE TABLE Ratings (
    RatingID INT PRIMARY KEY,
    UserID INT,
    SongID INT,
    Rating INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
);

SELECT * FROM music.ratings;
INSERT INTO Ratings (RatingID, UserID, SongID, Rating) VALUES
    (1, 1, 1, 5),
    (2, 2, 2, 4),
    (3, 3, 3, 5),
    (4, 1, 4, 3),
    (5, 2, 5, 2);

-- Create Lyrics Table
CREATE TABLE Lyrics (
    LyricID INT PRIMARY KEY,
    SongID INT,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
);
SELECT * FROM Lyrics;
INSERT INTO Lyrics (LyricID, SongID) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);
    
-- Create Playlists Table
CREATE TABLE Playlists (
    PlaylistID INT PRIMARY KEY,
    UserID INT,
    Title TEXT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
SELECT * FROM music.playlists;
INSERT INTO Playlists (PlaylistID, UserID, Title) VALUES
    (1, 1, 'Favorites Mix'),
    (2, 2, 'Chill Vibes'),
    (3, 3, 'mood'),
    (4, 3, 'myplaylist');
    
-- Create PlaylistSongs Table
CREATE TABLE PlaylistSongs (
    PlaylistID INT,
    SongID INT,
    PRIMARY KEY (PlaylistID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID) ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
);
SELECT * FROM PlaylistSongs;
INSERT INTO PlaylistSongs (PlaylistID, SongID) VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 4),
    (3, 2),
    (4, 1),
    (4, 2),
    (4, 3),
    (4, 4),
    (4, 5);
 
 UPDATE PlaylistSongs SET SongID = 2 WHERE PlaylistID = 3;
 
-- Create Marketing Table
CREATE TABLE Marketing (
    MarketingID INT PRIMARY KEY,
    CampaignName TEXT NOT NULL,
    CampaignType TEXT,
    StartDate DATE,
    EndDate DATE,
    Description TEXT,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
SELECT * FROM Marketing;
INSERT INTO Marketing (MarketingID, CampaignName, CampaignType, StartDate, EndDate, Description, UserID) VALUES
    (1, 'Summer Sale', 'Promotion', '2023-06-01', '2023-08-31', 'Big discounts on selected songs!', 1),
    (2, 'New Release', 'Launch', '2023-09-01', '2023-09-30', 'Check out the latest hits!', 2),
    (3, 'Holiday Special', 'Event', '2023-12-01', '2023-12-25', 'Celebrate the holidays with music!', 3);

-- DROP TABLE Commands

-- Drop Marketing Table
DROP TABLE IF EXISTS Marketing;

-- Drop PlaylistSongs Table
DROP TABLE IF EXISTS PlaylistSongs;

-- Drop Playlists Table
DROP TABLE IF EXISTS Playlists;

-- Drop Lyrics Table
DROP TABLE IF EXISTS Lyrics;

-- Drop Ratings Table
DROP TABLE IF EXISTS Ratings;

-- Drop Users Table
DROP TABLE IF EXISTS Users;

-- Drop Songs Table
DROP TABLE IF EXISTS Songs;

-- Drop Albums Table
DROP TABLE IF EXISTS Albums;

-- Drop Artists Table
DROP TABLE IF EXISTS Artists;

-- Drop Genres Table
DROP TABLE IF EXISTS Genres;

-- What are the most popular songs in the "Mood" playlist?

SELECT Songs.Title, COUNT(PlaylistSongs.SongID) AS PlayCount
FROM Songs
LEFT JOIN PlaylistSongs ON Songs.SongID = PlaylistSongs.SongID
JOIN Playlists ON PlaylistSongs.PlaylistID = Playlists.PlaylistID
WHERE Playlists.Title = 'mood'
GROUP BY Songs.SongID
ORDER BY PlayCount DESC;

-- How many users have provided ratings, and what is the average rating given?
SELECT COUNT(DISTINCT UserID) AS NumberOfUsers, AVG(Rating) AS AvgRating
FROM Ratings;

-- Which marketing campaigns have been the most successful in terms of user engagement?
SELECT Marketing.CampaignName, COUNT(DISTINCT Playlists.UserID) AS UserEngagement
FROM Marketing
INNER JOIN Playlists ON Marketing.UserID = Playlists.UserID
LEFT JOIN PlaylistSongs ON Playlists.PlaylistID = PlaylistSongs.PlaylistID
GROUP BY Marketing.CampaignName
ORDER BY UserEngagement DESC;

-- What is the total duration of songs in each playlist, and which playlist has the longest total duration?
SELECT Playlists.Title, SUM(Songs.Duration) AS TotalDuration
FROM Playlists
LEFT JOIN PlaylistSongs ON Playlists.PlaylistID = PlaylistSongs.PlaylistID
JOIN Songs ON PlaylistSongs.SongID = Songs.SongID
GROUP BY Playlists.PlaylistID
ORDER BY TotalDuration DESC
LIMIT 1;

-- What are the top-rated songs in the database?
SELECT Songs.Title, AVG(Ratings.Rating) AS AvgRating
FROM Songs
INNER JOIN Ratings ON Songs.SongID = Ratings.SongID
GROUP BY Songs.SongID
HAVING AvgRating > 3
ORDER BY AvgRating DESC
LIMIT 5;



-- Which artists have the highest number of albums in the database?
SELECT Artists.Name, COUNT(Albums.AlbumID) AS AlbumCount 
FROM Artists JOIN Albums ON Artists.ArtistID = Albums.ArtistID
GROUP BY Artists.ArtistID 
HAVING AlbumCount > 1 
ORDER BY AlbumCount DESC;

-- What is the average number of PlaylistS created by a user?
SELECT UserID, COUNT(PlaylistID) AS PlaylistCount FROM Playlists GROUP BY UserID;



