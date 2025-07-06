# Task 3: Index Performance Report

## 🎯 Objective

Create indexes to improve performance on high-usage columns and compare the effect using `EXPLAIN`.

---

## 🗂️ Indexes Added

| Table     | Column           | Index Name               |
|-----------|------------------|--------------------------|
| Booking   | user_id          | idx_booking_user_id      |
| Booking   | property_id      | idx_booking_property_id  |
| Booking   | start_date       | idx_booking_start_date   |
| User      | email            | idx_user_email           |
| Review    | property_id      | idx_review_property_id   |
| Review    | user_id          | idx_review_user_id       |

---

## ⏱️ Performance Comparison Using EXPLAIN

### 🔍 Before Index (on Booking.user_id)

```sql
EXPLAIN SELECT * FROM Booking WHERE user_id = 'some-uuid';