-- Task 3: Implement Indexes for Optimization
-- File: database_index.sql

-- --------------------------------------------------------
-- STEP 1: Create Indexes on High-Usage Columns
-- These columns are used in WHERE clauses and JOIN conditions
-- Indexes speed up lookup, filtering, and join operations

CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_payment_id ON bookings(payment_id);

-- Optional: If queries filter by start_date (useful for partitioning later)
CREATE INDEX IF NOT EXISTS idx_bookings_start_date ON bookings(start_date);

-- --------------------------------------------------------
-- STEP 2: Analyze Performance Using EXPLAIN ANALYZE
-- EXPLAIN ANALYZE shows how the query is executed and how long it takes

-- Check performance of query joining bookings and users

EXPLAIN ANALYZE
SELECT
    b.id,
    b.start_date,
    b.end_date,
    u.name
FROM bookings b
JOIN users u ON b.user_id = u.id;

-- Check performance of property lookups
EXPLAIN ANALYZE
SELECT
    b.id,
    p.title,
    p.location
FROM bookings b
JOIN properties p ON b.property_id = p.id;

-- Check performance of payments lookup
EXPLAIN ANALYZE
SELECT
    b.id,
    pay.amount,
    pay.payment_method
FROM bookings b
JOIN payments pay ON b.payment_id = pay.id;

-- Optional: Check performance of filtering by date (for partitioning)
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';