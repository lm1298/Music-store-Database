import sqlite3

# Connect to SQLite database (creates a new file named 'music2.db' if it doesn't exist)
conn = sqlite3.connect('music2.db')
cursor = conn.cursor()

# Function to execute SQL queries and print results
def execute_query(query, params=None):
    try:
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
        result = cursor.fetchall()
        print(result)
    except sqlite3.Error as e:
        print("Error executing query:", e)

# Function to get user input for a query
def get_user_input():
    user_input = input("Choose an option:\n"
                       "1. List all tables\n"
                       "2. Most popular songs in a playlist\n"
                       "3. Number of users and average rating\n"
                       "4. Most successful marketing campaigns\n"
                       "5. Total duration of songs in each playlist\n"
                       "6. Top-rated songs\n"
                       "7. Artists with the highest number of albums\n"
                       "8. Average number of playlists created by a user\n"
                       "9. Exit\n"
                       "Your choice: ")
    return user_input

# Function to run a specific predefined query
# Function to run a specific predefined query
def run_specific_predefined_query(query_number):
    if query_number == 1:
        # List all tables
        execute_query("SELECT name FROM sqlite_master WHERE type='table';")

    elif query_number == 2:
        # Most successful marketing campaigns
        query = "SELECT Marketing.CampaignName, COUNT(DISTINCT Playlists.UserID) AS UserEngagement " \
                "FROM Marketing INNER JOIN Playlists ON Marketing.UserID = Playlists.UserID " \
                "LEFT JOIN PlaylistSongs ON Playlists.PlaylistID = PlaylistSongs.PlaylistID " \
                "GROUP BY Marketing.CampaignName ORDER BY UserEngagement DESC;"
        execute_query(query)

    elif query_number == 3:
        # Total duration of songs in each playlist
        query = "SELECT Playlists.Title, SUM(Songs.Duration) AS TotalDuration " \
                "FROM Playlists LEFT JOIN PlaylistSongs ON Playlists.PlaylistID = PlaylistSongs.PlaylistID " \
                "JOIN Songs ON PlaylistSongs.SongID = Songs.SongID GROUP BY Playlists.PlaylistID " \
                "ORDER BY TotalDuration DESC LIMIT ?;"
        try:
            limit_value = int(input("Enter LIMIT value: "))
            execute_query(query, (limit_value,))
        except ValueError:
            print("Invalid input. Please enter a valid integer for LIMIT.")

    elif query_number == 4:
        # Top-rated songs
        query = "SELECT Songs.Title, AVG(Ratings.Rating) AS AvgRating " \
                "FROM Songs JOIN Ratings ON Songs.SongID = Ratings.SongID " \
                "GROUP BY Songs.SongID HAVING AvgRating > 3 " \
                "ORDER BY AvgRating DESC LIMIT ?;"
        try:
            limit_value = int(input("Enter LIMIT value: "))
            execute_query(query, (limit_value,))
        except ValueError:
            print("Invalid input. Please enter a valid integer for LIMIT.")

    elif query_number == 5:
        # Artists with the highest number of albums
        query = "SELECT Artists.Name, COUNT(Albums.AlbumID) AS AlbumCount " \
                "FROM Artists JOIN Albums ON Artists.ArtistID = Albums.ArtistID " \
                "GROUP BY Artists.ArtistID HAVING AlbumCount > 1 ORDER BY AlbumCount DESC;"
        execute_query(query)

    elif query_number == 6:
        # Average number of playlists created by a user
        query = "SELECT UserID, COUNT(PlaylistID) AS PlaylistCount FROM Playlists GROUP BY UserID " \
                "HAVING PlaylistCount > 1;"
        execute_query(query)

    else:
        print("Invalid option. Please choose a valid option.")

# Main program loop
while True:
    user_choice = get_user_input()

    if user_choice == '1':
        # List all tables
        execute_query("SELECT name FROM sqlite_master WHERE type='table';")

    elif user_choice.isdigit() and 1 <= int(user_choice) <= 8:
        # Run predefined queries
        run_specific_predefined_query(int(user_choice))

    elif user_choice == '9':
        # Exit the program
        print("Exiting...")
        break

    else:
        print("Invalid option. Please choose a valid option.")

# Commit changes and close the connection
conn.commit()
conn.close()
