-- Task 5: Partitioning Large Tables
-- File: partitioning.sql

-- STEP 1: Drop existing table if needed (use with caution!)
DROP TABLE IF EXISTS bookings CASCADE;

-- STEP 2: Create partitioned parent table (range by start_date)
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INT,
    property_id INT,
    payment_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
) PARTITION BY RANGE (start_date);

-- STEP 3: Create partitions (you can add more if needed)

CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- STEP 4: Example index for partition
CREATE INDEX IF NOT EXISTS idx_bookings_2023_user_id ON bookings_2023(user_id);