-- ============================================================
-- VIEWS — Commonly Used Reports
-- Organized by business function: Sales, Marketing, Operations
-- ============================================================


-- ============================================================
-- VIEW 1 (Sales) - v_monthly_sales_summary
--
-- Business Question:
-- How much revenue, invoice volume, and average order value did
-- the store generate each month?
--
-- Purpose:
-- Reusable monthly sales report for recurring business reviews.
-- Replaces re-running Q36 manually every time.
-- ============================================================
CREATE OR REPLACE VIEW v_monthly_sales_summary AS
SELECT DATE_TRUNC('month', invoice_date) AS sales_month,
       COUNT(invoice_id)                 AS total_invoices,
       ROUND(SUM(total), 2)              AS total_revenue,
       ROUND(AVG(total), 2)              AS average_invoice_value
FROM invoice
GROUP BY DATE_TRUNC('month', invoice_date)
ORDER BY sales_month;

-- Usage:
-- SELECT * FROM v_monthly_sales_summary WHERE sales_month >= '2013-01-01';


-- ============================================================
-- VIEW 2 (Marketing) - v_customer_segments
--
-- Business Question:
-- Which customers are High, Medium, or Low value based on total
-- lifetime spend, and how much has each one spent?
--
-- Purpose:
-- Reusable customer segmentation report for targeted marketing
-- and retention campaigns. Fills the W3 "customer segmentation"
-- deliverable with an explicit, queryable tier instead of a
-- one-off "above average" query.
-- ============================================================
CREATE OR REPLACE VIEW v_customer_segments AS
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       c.country,
       ROUND(SUM(i.total), 2) AS total_spent,
       COUNT(i.invoice_id)    AS total_orders,
       CASE
           WHEN SUM(i.total) >= 100 THEN 'High Value'
           WHEN SUM(i.total) >= 40  THEN 'Medium Value'
           ELSE 'Low Value'
       END AS customer_segment
FROM customer AS c
INNER JOIN invoice AS i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.country
ORDER BY total_spent DESC;

-- Usage:
-- SELECT customer_segment, COUNT(*) AS customers, ROUND(AVG(total_spent),2) AS avg_spend
-- FROM v_customer_segments
-- GROUP BY customer_segment;


-- ============================================================
-- VIEW 3 (Operations) - v_employee_performance
--
-- Business Question:
-- How many customers and invoices is each support employee
-- handling, and how much revenue do their accounts generate?
--
-- Purpose:
-- Reusable operations report for reviewing support rep workload
-- and portfolio value. Replaces re-running Q30 manually.
-- ============================================================
CREATE OR REPLACE VIEW v_employee_performance AS
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.title,
       COUNT(DISTINCT c.customer_id)          AS customers_supported,
       COUNT(DISTINCT i.invoice_id)           AS invoices_handled,
       ROUND(COALESCE(SUM(i.total), 0), 2)    AS total_revenue
FROM employee AS e
LEFT JOIN customer AS c ON e.employee_id = c.support_rep_id
LEFT JOIN invoice AS i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.title
ORDER BY total_revenue DESC;

-- Usage:
-- SELECT * FROM v_employee_performance WHERE customers_supported = 0;


-- ============================================================
-- EXPLAIN ANALYSIS — Complex Query Review
--
-- Purpose:
-- Query optimization report for the W4 / final deliverable.
-- These 4 queries were chosen because they're the heaviest in
-- the project: multi-table joins, CTEs, window functions, and
-- (for Q35) a GROUP BY + ORDER BY + LIMIT on a joined result,
-- which is exactly where PostgreSQL's planner choices matter.
--
-- For each one below: run it, then paste the output into your
-- optimization report along with 2-3 sentences noting whether
-- it used a Seq Scan or Index Scan, and whether an index on the
-- join/filter columns would help.
-- ============================================================

-- Candidate 1: Q34 - Complete Customer Sales Report
-- Why: 3-table join (customer -> invoice -> invoice_line -> track)
-- with no filtering, so it touches every row in invoice_line.
EXPLAIN ANALYZE
SELECT c.customer_id, c.first_name, c.last_name, c.country,
       i.invoice_id, i.invoice_date, t.track_id, t.name AS track_name,
       il.quantity, il.unit_price,
       ROUND(il.quantity * il.unit_price, 2) AS line_revenue
FROM customer AS c
INNER JOIN invoice AS i ON c.customer_id = i.customer_id
INNER JOIN invoice_line AS il ON i.invoice_id = il.invoice_id
INNER JOIN track AS t ON il.track_id = t.track_id
ORDER BY c.customer_id, i.invoice_date, t.name;

-- Candidate 2: Q35 - Track Sales by Artist and Album
-- Why: 4-table join + GROUP BY + ORDER BY + LIMIT. Good example
-- of checking whether the planner sorts before or after limiting.
EXPLAIN ANALYZE
SELECT ar.artist_id, ar.name AS artist_name, a.album_id,
       a.title AS album_title, t.track_id, t.name AS track_name,
       SUM(il.quantity) AS units_sold,
       ROUND(SUM(il.quantity * il.unit_price), 2) AS revenue
FROM artist AS ar
INNER JOIN album AS a ON ar.artist_id = a.artist_id
INNER JOIN track AS t ON a.album_id = t.album_id
INNER JOIN invoice_line AS il ON t.track_id = il.track_id
GROUP BY ar.artist_id, ar.name, a.album_id, a.title, t.track_id, t.name
ORDER BY revenue DESC, units_sold DESC
LIMIT 100;

-- Candidate 3: Q41 - Rank Tracks by Sales Within Each Genre
-- Why: CTE feeding a window function (RANK() OVER PARTITION BY).
-- Good example for showing how the planner materializes the CTE.
EXPLAIN ANALYZE
WITH track_sales AS (
    SELECT g.genre_id, g.name AS genre_name, t.track_id,
           t.name AS track_name, SUM(il.quantity) AS units_sold,
           ROUND(SUM(il.quantity * il.unit_price), 2) AS revenue
    FROM genre g
    JOIN track t ON g.genre_id = t.genre_id
    JOIN invoice_line il ON t.track_id = il.track_id
    GROUP BY g.genre_id, g.name, t.track_id, t.name
)
SELECT genre_name, track_id, track_name, units_sold, revenue,
       RANK() OVER (PARTITION BY genre_id ORDER BY units_sold DESC) AS sales_rank
FROM track_sales
ORDER BY genre_name, sales_rank;

-- Candidate 4: Q45 - Comprehensive BI Dashboard
-- Why: 4 separate CTEs, each with its own join, combined via
-- CROSS JOIN. Good example for showing total query cost when
-- several independent aggregations run in a single statement.
EXPLAIN ANALYZE
WITH sales_summary AS (
    SELECT COUNT(DISTINCT i.invoice_id) AS total_invoices,
           COUNT(DISTINCT i.customer_id) AS active_customers,
           ROUND(SUM(i.total), 2) AS total_revenue,
           ROUND(AVG(i.total), 2) AS average_invoice_value
    FROM invoice i
), track_summary AS (
    SELECT SUM(il.quantity) AS total_units_sold,
           COUNT(DISTINCT il.track_id) AS different_tracks_sold
    FROM invoice_line il
), top_track AS (
    SELECT t.name AS top_track_name, SUM(il.quantity) AS units_sold
    FROM track t
    JOIN invoice_line il ON t.track_id = il.track_id
    GROUP BY t.track_id, t.name
    ORDER BY units_sold DESC
    LIMIT 1
), top_genre AS (
    SELECT g.name AS top_genre_name, SUM(il.quantity) AS units_sold
    FROM genre g
    JOIN track t ON g.genre_id = t.genre_id
    JOIN invoice_line il ON t.track_id = il.track_id
    GROUP BY g.genre_id, g.name
    ORDER BY units_sold DESC
    LIMIT 1
)
SELECT s.total_invoices, s.active_customers, s.total_revenue,
       s.average_invoice_value, ts.total_units_sold,
       ts.different_tracks_sold, tt.top_track_name,
       tt.units_sold AS top_track_units_sold, tg.top_genre_name,
       tg.units_sold AS top_genre_units_sold
FROM sales_summary s
CROSS JOIN track_summary ts
CROSS JOIN top_track tt
CROSS JOIN top_genre tg;


-- ============================================================
-- SUGGESTED INDEXES
--
-- Purpose:
-- Based on the EXPLAIN output you'll typically see (Seq Scans
-- on invoice_line.track_id and invoice.customer_id, since these
-- are foreign keys PostgreSQL doesn't index automatically),
-- these are the indexes worth testing before/after in your
-- optimization report.
-- ============================================================
-- CREATE INDEX idx_invoice_line_track_id ON invoice_line(track_id);
-- CREATE INDEX idx_invoice_line_invoice_id ON invoice_line(invoice_id);
-- CREATE INDEX idx_invoice_customer_id ON invoice(customer_id);
-- CREATE INDEX idx_track_album_id ON track(album_id);
-- CREATE INDEX idx_track_genre_id ON track(genre_id);
-- CREATE INDEX idx_album_artist_id ON album(artist_id);