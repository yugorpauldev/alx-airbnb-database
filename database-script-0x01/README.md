# 📌 Task: Define Database Schema in SQL

## 🎯 Objective
Write SQL queries to define the database schema, including table creation, constraints, and indexing.

---

## 📋 Instructions

1. **Understand the Specification**
   - Review the provided database specification.
   - Identify all entities (e.g., `User`, `Property`, `Booking`, etc.) and their relationships.

2. **Create Tables**
   - Write `CREATE TABLE` statements for each entity.
   - Choose appropriate data types for each column (e.g., `UUID`, `VARCHAR`, `DECIMAL`, `DATE`, `TIMESTAMP`).
   - Define `PRIMARY KEY` constraints for unique identification of rows.

3. **Define Relationships and Constraints**
   - Add `FOREIGN KEY` constraints to enforce relationships between tables.
   - Use `ON DELETE CASCADE` or `SET NULL` where appropriate.
   - Include additional constraints such as:
     - `NOT NULL`
     - `UNIQUE`
     - `CHECK` (e.g., for price or date validation)

4. **Create ENUM Types (if needed)**
   - Define `ENUM` types for fields like user roles, booking status, payment methods, etc.

5. **Optimize with Indexes**
   - Create `CREATE INDEX` statements on frequently queried columns (e.g., foreign keys, unique identifiers).
   - Use clear and descriptive index names (e.g., `idx_user_email`, `idx_booking_user_id`).

---

## ✅ Deliverables

- A `.sql` script or code block containing:
  - All `CREATE TYPE` (if applicable)
  - All `CREATE TABLE` statements with constraints
  - All `CREATE INDEX` statements

- Ensure the script can be executed **without errors** (consider adding `DROP TABLE IF EXISTS` or `DROP TYPE IF EXISTS` at the top for clean execution).
