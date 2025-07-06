# Task 4: Optimization Report
## File: optimization_report.md

## Objective:
Refactor a complex SQL query involving multiple JOINs to improve its execution time.

---

### 🔍 Initial Query Overview

The query retrieves all bookings and joins the `users`, `properties`, and `payments` tables to include related information such as:

- Who made the booking (`users`)
- Which property was booked (`properties`)
- Payment details (`payments`)

---

### 📊 Performance Analysis (Before Optimization)

**Command Used:**

```sql
EXPLAIN ANALYZE
SELECT ...
FROM bookings
JOIN users ON ...
JOIN properties ON ...
JOIN payments ON ...;