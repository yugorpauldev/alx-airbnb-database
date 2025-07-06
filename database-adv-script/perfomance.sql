-- Task 4: Optimize Complex Queries
-- File: perfomance.sql

-- STEP 1: Initial Complex Query (Before Optimization)
-- Includes WHERE clause to simulate realistic filtering

EXPLAIN ANALYZE
SELECT
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.title AS property_title,
    p.location AS property_location,
    pay.amount AS payment_amount,
    pay.payment_method
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
INNER JOIN payments pay ON b.payment_id = pay.id
WHERE b.start_date >= '2023-01-01' AND b.end_date <= '2023-12-31';

-- STEP 2: Index Creation (Optimization Strategy)
-- These indexes improve JOIN performance and WHERE clause filtering

CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_payment_id ON bookings(payment_id);
CREATE INDEX IF NOT EXISTS idx_bookings_start_end_date ON bookings(start_date, end_date);

-- STEP 3: Optimized Query (After Indexes Added)
-- Same logic as before, but should now use indexes for joins and filtering

EXPLAIN ANALYZE
SELECT
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.title AS property_title,
    p.location AS property_location,
    pay.amount AS payment_amount,
    pay.payment_method
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
INNER JOIN payments pay ON b.payment_id = pay.id
WHERE b.start_date >= '2023-01-01' AND b.end_date <= '2023-12-31';