# Chinook SQL Analytics

### Master SQL: From Basics to Advanced

## Overview

This project is a hands-on SQL analytics project built using the **Chinook music store database**. It moves from SQL fundamentals to advanced analytical SQL, with a focus on answering practical business questions around customers, sales, tracks, albums, genres, employees, and revenue.

The project contains **45 SQL queries** organized across four weeks. The analysis was developed using **PostgreSQL**, with **Python and Jupyter Notebook** used to connect to the database, execute queries, and inspect the results.

---

## Project Objectives

The project focuses on:

- Writing SQL queries with multiple joins
- Using aggregate functions and `GROUP BY`
- Filtering and sorting relational data
- Working with `NULL` values and logical conditions
- Using subqueries and CTEs
- Performing date and time-based analysis
- Applying window functions for advanced analytics
- Understanding query execution and optimization
- Creating reusable reporting views
- Building a Business Intelligence dashboard query
- Translating query results into business insights

---

## Database Overview

The **Chinook database** represents a digital music store and contains information about customers, employees, invoices, tracks, albums, artists, genres, playlists, and media types.

### Main Tables

- `artist` - Stores artist information
- `album` - Stores album information and artist relationships
- `track` - Stores individual track information
- `genre` - Stores music genre information
- `media_type` - Stores track media type information
- `customer` - Stores customer information
- `employee` - Stores employee and reporting information
- `invoice` - Stores customer invoice information
- `invoice_line` - Stores individual purchased tracks on an invoice
- `playlist` - Stores playlist information
- `playlist_track` - Links playlists with tracks

### Key Relationships

```text
Artist
  │
  └── Album
        │
        └── Track
              │
              └── Invoice Line
                    │
                    └── Invoice
                          │
                          └── Customer
                                │
                                └── Employee
```

Additional relationships used in the analysis include `track → genre`, `track → media_type`, the playlist-to-track relationship through `playlist_track`, and the employee reporting hierarchy through `employee.reports_to`.

---

## Tools & Technologies

- **PostgreSQL** - relational database
- **pgAdmin** - database management
- **Python** - database interaction and analysis
- **Jupyter Notebook** - project development and execution
- **Pandas** - handling SQL query results
- **SQLAlchemy** - database connection
- **psycopg2** - PostgreSQL connectivity

---

## Project Structure

```text
Chinook_SQL_Project/
│
├── Chinook_SQL_Analytics.ipynb
├── queries.sql
└── README.md
```

### File Description

**`Chinook_SQL_Analytics.ipynb`**  
Contains the database connection, SQL queries, query execution, result outputs, and analysis.

**`queries.sql`**  
Contains the documented SQL queries from Q1 to Q45, including the business question and purpose for each query.

**`README.md`**  
Provides project-level documentation, implementation summary, SQL concepts, and business insights.

---

# Weekly Implementation

## Week 1 - SQL Fundamentals & Basic Queries

Week 1 focuses on learning and applying core SQL querying techniques.

### Topics Covered

- `SELECT`
- `WHERE`
- `ORDER BY`
- `LIMIT`
- Comparison operators
- Logical operators
- `IN`
- `NULL`
- `IS NULL`
- `IS NOT NULL`
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `GROUP BY`
- `HAVING`

### Analysis Performed

The first 20 queries cover:

- Exploring the available database tables
- Reviewing customer records
- Filtering customers by country
- Filtering records using logical conditions
- Handling missing company and phone information
- Finding higher-priced tracks
- Finding the most expensive tracks
- Finding tracks longer than ten minutes
- Counting customers
- Finding minimum and maximum invoice values
- Calculating total revenue
- Calculating average invoice value
- Counting customers by country
- Calculating sales by billing country
- Finding customers with repeat purchases
- Finding top-selling tracks
- Finding top-selling albums
- Finding highest-spending customers
- Finding top-selling genres

### Queries

**Q1-Q20**

---

## Week 2 - Joins & Relationships

Week 2 focuses on combining related tables and understanding relational database structure.

### Topics Covered

- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- `FULL OUTER JOIN`
- Self joins
- Multiple-table joins
- Foreign key relationships
- Relationship-based reporting

### Analysis Performed

Queries Q21-Q35 cover:

- Matching customers to invoices
- Matching customers to purchased tracks
- Connecting tracks with albums and artists
- Measuring sales by genre
- Building detailed customer purchase history
- Finding artists without albums
- Finding albums without tracks
- Assigning customers to employees
- Finding employees without customers
- Measuring revenue by employee
- Showing the employee reporting hierarchy
- Demonstrating a `RIGHT JOIN`
- Comparing artists and albums with a `FULL OUTER JOIN`
- Creating a complete customer sales report
- Analyzing track-level sales by artist and album

### Queries

**Q21-Q35**

---

## Week 3 - Advanced SQL & Aggregations

Week 3 focuses on analytical SQL using aggregation, subqueries, and date-based reporting.

### Topics Covered

- `GROUP BY`
- `HAVING`
- Scalar subqueries
- Nested subqueries
- CTE-based analysis
- Date and time functions
- Revenue analysis
- Customer spending analysis

### Analysis Performed

Queries Q36-Q40 cover:

- Monthly sales reporting
- Yearly sales reporting
- Country revenue threshold analysis
- Identifying invoices above the overall average invoice value
- Identifying customers whose spending exceeds the average customer spending

### Queries

**Q36-Q40**

---

## Week 4 - Window Functions & Advanced Analytics

Week 4 applies window functions to ranking and time-series analysis.

### Topics Covered

- `RANK()`
- `ROW_NUMBER()`
- `OVER()`
- `PARTITION BY`
- Running totals
- Moving averages
- Top-N analysis
- CTE-based analytical queries

### Analysis Performed

Queries Q41-Q45 cover:

- Ranking tracks by sales within each genre
- Calculating cumulative revenue month by month
- Calculating a three-month moving average
- Finding the top three tracks in each genre
- Building a comprehensive Business Intelligence dashboard query

### Queries

**Q41-Q45**

---

# Query Summary

The project contains **45 documented SQL queries**.

- **Week 1:** Q1-Q20 - SQL Fundamentals & Basic Queries
- **Week 2:** Q21-Q35 - Joins & Relationships
- **Week 3:** Q36-Q40 - Advanced SQL & Aggregations
- **Week 4:** Q41-Q45 - Window Functions & Advanced Analytics

---

# Business Function Coverage

## Sales

The sales analysis focuses on:

- Total revenue
- Revenue by billing country
- Track sales
- Album sales
- Genre sales
- Monthly revenue
- Yearly revenue
- Employee-associated revenue
- Customer spending
- Running revenue totals
- Moving-average revenue trends
- Top-performing tracks

## Marketing & Customer Analysis

The customer-focused analysis includes:

- Customer distribution by country
- Repeat purchase behavior
- Highest-spending customers
- Customers spending above the average
- Customer invoice history
- Detailed customer purchase history
- Customer-level sales reporting

## Operations & Relationship Analysis

The operational and relational analysis includes:

- Artist and album relationships
- Album and track relationships
- Employee and customer assignments
- Employee reporting hierarchy
- Missing catalog relationships
- Multi-table sales reporting
- SQL query structure and analytical reporting

---

# SQL Concepts Demonstrated

## Fundamentals

- `SELECT`
- `WHERE`
- `ORDER BY`
- `LIMIT`
- Comparison operators
- Logical operators
- `IN`
- `NULL` handling

## Aggregations

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `GROUP BY`
- `HAVING`

## Joins

- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- `FULL OUTER JOIN`
- Self joins
- Multi-table joins

## Advanced SQL

- Scalar subqueries
- Nested subqueries
- Common Table Expressions
- Date and time functions
- Conditional analytical logic

## Window Functions

- `RANK()`
- `ROW_NUMBER()`
- `OVER()`
- `PARTITION BY`
- Running totals
- Moving averages
- Top-N analysis

---

# Business Intelligence Dashboard

The final query, **Q45**, combines multiple metrics into a single SQL dashboard result.

The dashboard reports:

- Total invoices
- Active customers
- Total revenue
- Average invoice value
- Total units sold
- Number of different tracks sold
- Top-selling track
- Units sold by the top track
- Top-selling genre
- Units sold by the top genre

The final result is built using separate CTEs for sales, track, top-track, and top-genre summaries and then combines them into one reporting result.

---

# Key Business Insights

The completed SQL analysis produced several business-level findings.

### Overall Store Performance

The final dashboard output shows:

### Customer Insights

The database contains **59 customers**. The USA has the largest customer base with **13 customers**, followed by Canada with **8** and Brazil with **5**.

The highest-spending customer in the Q19 result is **Helena Holý**, with total spending of **$49.62**.

### Sales by Country

The USA generated the highest billing-country revenue at **$523.06**, followed by:

- Canada - **$303.96**
- France - **$195.10**
- Brazil - **$190.10**
- Germany - **$156.48**

### Genre Performance

`Rock` is the strongest genre in the sales analysis, with:

- **835 units sold**
- **$826.65 revenue**

It is followed by:

- Latin - **386 units / $382.14**
- Metal - **264 units / $261.36**
- Alternative & Punk - **244 units / $241.56**

### Album Performance

The highest-selling album in Q18 is **Minha Historia**, with **27 units sold** and **$26.73 revenue**.

The next highest-selling albums include:

- `Greatest Hits` - 26 units
- `Unplugged` - 25 units
- `Acústico` - 22 units

### Time-Based Sales Trends

The running-revenue analysis shows cumulative revenue increasing from **$35.64 in January 2021** to **$2,328.60 by December 2025**.

The three-month moving average is used to smooth monthly fluctuations and provide a clearer view of short-term sales trends.

---

# Query Optimization & EXPLAIN

Query optimization is part of the overall project brief. The project design includes analysis of complex joins and aggregation queries using PostgreSQL execution plans.

`EXPLAIN` can be used to inspect how PostgreSQL intends to execute a query, while `EXPLAIN ANALYZE` executes the query and provides actual execution information.

The optimization work should focus on:

- Join strategy
- Scan strategy
- Query cost
- Row estimates versus actual rows
- Index usage
- Execution time
- Opportunities to improve frequently executed queries

No specific before-and-after execution measurements are claimed here because the current submitted `Chinook_SQL_Analytics.ipynb` and `queries.sql` contain the 45 analytical queries but do not contain a documented `EXPLAIN ANALYZE` result or measured optimization comparison.

---

# SQL Views

The project brief requires at least three reusable SQL views for commonly used reports.

Recommended reporting views for this project are:

### `customer_spending_report`

Customer-level reporting containing customer information, invoice count, total spending, and average invoice value.

### `monthly_sales_report`

Monthly reporting containing invoice count, monthly revenue, and average invoice value.

### `track_sales_report`

Track-level reporting connecting tracks with album, artist, genre, units sold, and revenue.

The current submitted notebook and `queries.sql` do not contain the `CREATE VIEW` statements, so these views should be created in PostgreSQL before claiming them as completed project deliverables.

---

# Project Deliverables

The completed analytical portion of the project includes:

- 45 SQL queries
- Business questions documented for each query
- SQL fundamentals and filtering
- Aggregations and grouping
- Multiple join types
- Multi-table relational analysis
- Subqueries
- CTE-based analysis
- Date and time analysis
- Window-function analysis
- Running totals
- Moving averages
- Top-N analysis
- Business Intelligence dashboard query
- Business insights based on notebook outputs

The overall project brief also calls for:

- EXPLAIN / EXPLAIN ANALYZE analysis
- Documented query optimization observations
- At least three SQL views
- A presentation documenting the learning journey and key insights

These items are not present in the current submitted notebook/SQL files and should be added before describing the entire assignment as fully completed.

---

# Learning Outcomes

By completing the project, the following practical SQL skills are demonstrated:

- Exploring a relational database
- Translating business questions into SQL
- Filtering and sorting data
- Performing aggregations
- Joining multiple related tables
- Working with foreign-key relationships
- Using subqueries and CTEs
- Performing time-based analysis
- Ranking records using window functions
- Calculating running totals and moving averages
- Building consolidated reporting queries
- Interpreting SQL results as business insights

---

# Conclusion

The Chinook SQL Analytics project demonstrates a progression from basic SQL querying to advanced analytical SQL.

Across **45 queries**, the project covers SQL fundamentals, joins, aggregations, subqueries, CTEs, time-based analysis, window functions, business reporting, and data-driven insights.

The final Business Intelligence query brings together key customer, sales, track, and genre metrics into a single reporting result, providing a practical example of how SQL can be used for business analysis.

---

## Project Files

- [`Chinook_SQL_Analytics.ipynb`](Chinook_SQL_Analytics.ipynb) - Complete notebook containing the SQL analysis, execution, and results
- [`queries.sql`](queries.sql) - Documented SQL queries with business questions and purposes
- [`README.md`](README.md) - Project documentation
