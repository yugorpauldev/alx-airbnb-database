# Task Summary – Airbnb Advanced SQL

## Task 0: Write Complex Queries with Joins
- Practice INNER JOIN, LEFT JOIN, and FULL OUTER JOIN
- Use JOINs to combine data from `User`, `Booking`, `Property`, and `Review` tables
- Learn how to include unmatched records (LEFT/FULL OUTER JOIN)

## Task 1: Practice Subqueries
- Use correlated subqueries to:
  - Find properties with average rating > 4.0
  - Find users with more than 3 bookings

## Task 2: Apply Aggregations and Window Functions
- Use `COUNT` and `GROUP BY` to get total bookings per user
- Use `RANK()` and `ROW_NUMBER()` to rank properties by number of bookings

## Task 3: Implement Indexes for Optimization
- Identify frequently queried columns
- Use `CREATE INDEX` to improve performance
- Use `EXPLAIN` or `ANALYZE` to compare before and after

## Task 4: Optimize Complex Queries
- Write and refactor multi-table queries
- Eliminate unnecessary joins and check performance with `EXPLAIN`

## Task 5: Partitioning Large Tables
- Use `PARTITION BY RANGE` on the `Booking` table (based on `start_date`)
- Test performance improvements for date-range queries

## Task 6: Monitor and Refine Performance
- Use `EXPLAIN ANALYZE` or `SHOW PROFILE` to detect bottlenecks
- Suggest indexes or schema improvements and report observed gains

---