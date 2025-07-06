# Task 6: Monitoring and Refining Database Performance
## File: performance_monitoring.md

---

## 🎯 Objective
Analyze and improve SQL query performance using `EXPLAIN ANALYZE`. Identify bottlenecks and apply schema/indexing improvements.

---

## 🔍 Query Analyzed

```sql
SELECT
    b.id,
    b.start_date,
    b.end_date,
    u.name,
    p.title,
    pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id
WHERE b.start_date >= '2023-01-01' AND b.end_date <= '2023-12-31';