# SQL_Analysis_Water_Polo
This project sets up a structured database to store and manage water polo statistics, including player details and match results. The system ensures data integrity by validating and cleaning imported data from CSV files.

## Database Structure

### 1. Creating the Database
- The database `water_polo_stats` is created if it does not already exist.
- The database is then selected for further operations.

### 2. Player Table (`jugadores`)
- Stores player details such as team, player ID, name, age, and position.
- Uses `AUTO_INCREMENT` for unique identification of each player.

### 3. Matches Table (`partidos`)
- Stores match details including team names, match ID, scores, and date.
- A temporary table (`partidos_temp`) is used to import raw data, allowing validation of date formats before insertion into the final table.
- Dates are converted from text format using `STR_TO_DATE`, with invalid dates set to NULL.

## Data Import Process

### 4. Importing Player Data
- Uses `LOAD DATA INFILE` to import player information from a CSV file.
- The import ensures that fields are properly enclosed and separated.
- A validation step ensures that the `edad` field contains only numeric values; non-numeric values are set to NULL.

### 5. Importing Match Data
- Match data is first imported into the `partidos_temp` table.
- The validated data is then inserted into the `partidos` table, with incorrect dates cleaned.
- A check is performed to identify matches with null dates for debugging purposes.
- The temporary table is deleted after successful data migration.

### 6. Additional Validation and Updates
- The project includes additional tables (`tu_tabla2` and `tu_tabla3`) to validate and correct player age data before updating the main player table (`jugadores_staging2`).
- Player ages are verified using a regular expression to allow only valid numerical values.

This database setup ensures data integrity and facilitates efficient data retrieval and analysis for water polo statistics.

