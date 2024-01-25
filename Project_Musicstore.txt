PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    GenreName TEXT NOT NULL
);
INSERT INTO Genres VALUES(1,'Pop');
INSERT INTO Genres VALUES(2,'R&B');
INSERT INTO Genres VALUES(3,'Country');
INSERT INTO Genres VALUES(4,'Classic');
INSERT INTO Genres VALUES(5,'K-Pop');
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name TEXT NOT NULL
);
INSERT INTO Artists VALUES(1,'Taylor');
INSERT INTO Artists VALUES(2,'Ariana');
INSERT INTO Artists VALUES(3,'Charlie');
INSERT INTO Artists VALUES(4,'ThV');
INSERT INTO Artists VALUES(5,'Jungkook');
CREATE TABLE Albums (
    AlbumID INT PRIMARY KEY,
    Title TEXT NOT NULL,
    ArtistID INT,
    ReleaseYear DATE,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID) ON DELETE CASCADE
);
INSERT INTO Albums VALUES(1,'SpeakNow',1,'2020-01-01');
INSERT INTO Albums VALUES(2,'Reputation',2,'2019-01-01');
INSERT INTO Albums VALUES(3,'Golden',2,'2022-01-01');
INSERT INTO Albums VALUES(4,'lover',4,'2017-01-01');
INSERT INTO Albums VALUES(5,'Dynamite',5,'2022-01-01');
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
INSERT INTO Songs VALUES(1,'Love Story',1,1,1,'2008-01-01',240);
INSERT INTO Songs VALUES(2,'God is a Woman',2,2,2,'2018-01-01',210);
INSERT INTO Songs VALUES(3,'Attention',3,3,3,'2017-01-01',200);
INSERT INTO Songs VALUES(4,'Cherry Blossom',4,4,4,'2021-01-01',180);
INSERT INTO Songs VALUES(5,'Dynamite',5,5,5,'2020-01-01',223);
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username TEXT NOT NULL,
    Password TEXT NOT NULL,
    FullName TEXT NOT NULL,
    Email TEXT NOT NULL,
    RegistrationDate DATE
);
INSERT INTO Users VALUES(1,'musiclover92','password123','John Doe','john.doe@email.com','2023-01-15');
INSERT INTO Users VALUES(2,'lucky','securepass','Jane Smith','lucky@email.com','2023-02-20');
INSERT INTO Users VALUES(3,'prasanna','pass123','Chris Johnson','prasanna@email.com','2023-03-10');
CREATE TABLE Ratings (
    RatingID INT PRIMARY KEY,
    UserID INT,
    SongID INT,
    Rating INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
);
INSERT INTO Ratings VALUES(1,1,1,5);
INSERT INTO Ratings VALUES(2,2,2,4);
INSERT INTO Ratings VALUES(3,3,3,5);
INSERT INTO Ratings VALUES(4,1,4,3);
INSERT INTO Ratings VALUES(5,2,5,2);
CREATE TABLE Lyrics (
    LyricID INT PRIMARY KEY,
    SongID INT,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
);
INSERT INTO Lyrics VALUES(1,1);
INSERT INTO Lyrics VALUES(2,2);
INSERT INTO Lyrics VALUES(3,3);
INSERT INTO Lyrics VALUES(4,4);
INSERT INTO Lyrics VALUES(5,5);
CREATE TABLE Playlists (
    PlaylistID INT PRIMARY KEY,
    UserID INT,
    Title TEXT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
INSERT INTO Playlists VALUES(1,1,'Favorites Mix');
INSERT INTO Playlists VALUES(2,2,'Chill Vibes');
INSERT INTO Playlists VALUES(3,3,'mood');
INSERT INTO Playlists VALUES(4,3,'myplaylist');
CREATE TABLE PlaylistSongs (
    PlaylistID INT,
    SongID INT,
    PRIMARY KEY (PlaylistID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID) ON DELETE CASCADE,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID) ON DELETE CASCADE
);
INSERT INTO PlaylistSongs VALUES(1,1);
INSERT INTO PlaylistSongs VALUES(1,2);
INSERT INTO PlaylistSongs VALUES(2,3);
INSERT INTO PlaylistSongs VALUES(2,4);
INSERT INTO PlaylistSongs VALUES(3,2);
INSERT INTO PlaylistSongs VALUES(4,1);
INSERT INTO PlaylistSongs VALUES(4,2);
INSERT INTO PlaylistSongs VALUES(4,3);
INSERT INTO PlaylistSongs VALUES(4,4);
INSERT INTO PlaylistSongs VALUES(4,5);
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
INSERT INTO Marketing VALUES(1,'Summer Sale','Promotion','2023-06-01','2023-08-31','Big discounts on selected songs!',1);
INSERT INTO Marketing VALUES(2,'New Release','Launch','2023-09-01','2023-09-30','Check out the latest hits!',2);
INSERT INTO Marketing VALUES(3,'Holiday Special','Event','2023-12-01','2023-12-25','Celebrate the holidays with music!',3);
COMMIT;
