# Water Polo Stats Analysis

## 📌 Project Overview

This project provides a comprehensive analysis of water polo match and player statistics using SQL queries. The dataset includes match results, player details, and team performance metrics. The queries are designed to extract key insights, such as the number of matches played, goals scored, player demographics, and team performance.

## 📂 Database Schema

The analysis is based on two main tables:

- **partidos\_staging2**: Stores match-related data, including teams, scores, and dates.
- **jugadores\_staging2**: Contains player details, such as age, position, and team affiliation.

## 📊 SQL Queries Included

This project contains a set of structured SQL queries that answer key statistical questions:

1. **Total Number of Matches** - Counts the total matches played.
2. **Total Number of Players** - Counts the number of players in the dataset.
3. **Average Goals per Match** - Calculates the mean number of goals scored per match.
4. **Average Age of Players** - Computes the average age of players.
5. **Average Goals per Team** - Determines the average number of goals scored per team.
6. **Number of Wins per Team** - Counts the number of victories each team has achieved.
7. **Top 10 Oldest Players** - Lists the ten oldest players.
8. **Number of Players per Position** - Aggregates player count by position.
9. **Total Goals by Month** - Summarizes goals scored each month.
10. **Total Goals by Month (excluding NULL dates)** - Similar to the previous query but excludes matches with missing dates.
11. **Number of Wins per Team by Year** - Tracks the number of wins for each team annually.
12. **Maximum Goals per Team** - Identifies the highest number of goals scored by a team in a match.
13. **Monthly Goals with Rolling Total** - Computes monthly goals and a cumulative total over time.

## 🚀 How to Use

To run the queries:

1. Ensure you have a MySQL-compatible database.
2. Load the `partidos_staging2` and `jugadores_staging2` tables with relevant data.
3. Execute the provided SQL queries to extract insights.

## 📌 Future Enhancements

- Adding more advanced analytics, such as player efficiency ratings.
- Visualizing data using Power BI or Tableau.
- Incorporating machine learning models to predict match outcomes.

## 🏆 Contributions

Feel free to contribute by optimizing queries, adding new insights, or suggesting improvements!



