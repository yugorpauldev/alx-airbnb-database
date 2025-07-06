# Task 5: Partitioning Performance Report
## File: partition_performance.md

### 🎯 Objective
Optimize performance of the `bookings` table by partitioning it based on the `start_date` column.

---

### 🏗️ What Was Done

1. Dropped and recreated the `bookings` table using **RANGE partitioning** on the `start_date` column.
2. Created separate partitions for:
   - 2023 (`bookings_2023`)
   - 2024 (`bookings_2024`)
   - 2025 (`bookings_2025`)
3. Added an index on `user_id` for the `2023` partition to support fast lookups.

---

### ⏱️ Performance Observations

**Before Partitioning:**
- Running a query to fetch bookings within a date range (e.g. 2023) scanned the entire `bookings` table.
- Query execution time was slower on large datasets.

**After Partitioning:**
- The same query only scans the relevant partition (e.g., `bookings_2023`).
- Query plan uses **"Partition Pruning"**, leading to significant performance gains (especially when number of rows is large).

---

### ✅ Conclusion

Partitioning by `start_date` reduced unnecessary full-table scans, making date-range queries significantly faster. This technique is ideal for time-series or log-like data.

