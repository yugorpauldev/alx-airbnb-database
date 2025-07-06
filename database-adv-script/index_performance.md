# Index Performance Analysis Report

## Task 3: Implement Indexes for Optimization

### Objective
Identify and create indexes to improve query performance on high-usage columns in User, Booking, and Property tables.

### Understanding Database Indexes

**What is an Index?**
Think of a database index like the index at the back of a textbook. Instead of reading through every page to find a topic, you can quickly look it up in the index and jump directly to the right page. Similarly, database indexes help the database engine quickly locate specific data without scanning every row.

**Types of Indexes:**
1. **B-tree Index**: Most common type, good for equality and range queries
2. **Hash Index**: Fast for equality comparisons but not range queries
3. **Composite Index**: Covers multiple columns in a single index
4. **Partial Index**: Only indexes rows that meet certain conditions

### High-Usage Columns Identified

#### User Table
- **email**: Used in login operations and user lookups
- **role**: Used to filter users by their role (guest, host, admin)
- **created_at**: Used for temporal queries and reporting

#### Booking Table
- **user_id**: Used to find all bookings for a specific user
- **property_id**: Used to find all bookings for a specific property
- **start_date & end_date**: Used for date range queries (very common)
- **status**: Used to filter bookings by their current status
- **created_at**: Used for temporal analysis and reporting

#### Property Table
- **host_id**: Used to find all properties owned by a specific host
- **location**: Used for location-based searches (very common)
- **price_per_night**: Used for price filtering and sorting

#### Review Table
- **property_id**: Used to find all reviews for a specific property
- **user_id**: Used to find all reviews by a specific user
- **rating**: Used for rating-based queries and calculations

### Performance Testing Methodology

#### Before Indexing
1. Run `EXPLAIN ANALYZE` on common queries
2. Record execution times and scan methods
3. Identify sequential scans (slow operations)

#### After Indexing
1. Create appropriate indexes
2. Run the same queries with `EXPLAIN ANALYZE`
3. Compare execution times and scan methods
4. Verify index usage in query plans

### Expected Performance Improvements

#### Query Types That Will Benefit Most:

1. **User Lookup by Email**
   - Before: Sequential scan through all users
   - After: Index scan (O(log n) vs O(n))

2. **Property Search by Location**
   - Before: Sequential scan through all properties
   - After: Index scan with pattern matching

3. **Booking Date Range Queries**
   - Before: Sequential scan checking each booking's dates
   - After: Index range scan using composite date index

4. **Status-Based Filtering**
   - Before: Sequential scan through all bookings
   - After: Index scan for specific status values

### Indexes Created

#### Existing Indexes (from schema.sql)
```sql
CREATE INDEX idx_user_email ON "User"(email);
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_user_id ON Review(user_id);
```

#### New Indexes Added
```sql
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(price_per_night);
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_created_at ON Booking(created_at);
CREATE INDEX idx_property_location_price ON Property(location, price_per_night);
```

### How to Read EXPLAIN ANALYZE Output

When you run `EXPLAIN ANALYZE`, you'll see output like this:

```
Seq Scan on booking  (cost=0.00..15.00 rows=1000 width=32) (actual time=0.123..1.234 rows=1000 loops=1)
  Filter: (user_id = '550e8400-e29b-41d4-a716-446655440000')
  Rows Removed by Filter: 9000
Planning Time: 0.456 ms
Execution Time: 1.789 ms
```

**Key Terms:**
- **Seq Scan**: Sequential scan (reads every row) - SLOW
- **Index Scan**: Uses an index to find rows - FAST
- **cost**: Estimated cost (lower is better)
- **actual time**: Real execution time
- **rows**: Number of rows processed
- **Planning Time**: Time to create execution plan
- **Execution Time**: Time to actually run the query

### Performance Monitoring Commands

```sql
-- Check index usage statistics
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes
WHERE schemaname = 'public'
ORDER BY idx_tup_read DESC;

-- Check table statistics
SELECT 
    schemaname,
    tablename,
    n_tup_ins,
    n_tup_upd,
    n_tup_del,
    n_live_tup,
    n_dead_tup
FROM pg_stat_user_tables
WHERE schemaname = 'public';
```

### Best Practices for Indexing

1. **Index Frequently Queried Columns**: Focus on columns used in WHERE, JOIN, and ORDER BY clauses
2. **Composite Indexes**: Create multi-column indexes for queries that filter on multiple columns
3. **Monitor Index Usage**: Remove unused indexes as they slow down INSERT/UPDATE operations
4. **Consider Selectivity**: Highly selective columns (many unique values) benefit most from indexes
5. **Maintain Statistics**: Run ANALYZE regularly to keep query planner statistics up-to-date

### Trade-offs of Indexing

**Benefits:**
- Faster SELECT queries
- Improved JOIN performance
- Better ORDER BY performance

**Costs:**
- Slower INSERT/UPDATE/DELETE operations
- Additional storage space required
- Maintenance overhead

### Conclusion

Proper indexing can dramatically improve database performance, often reducing query execution times from seconds to milliseconds. The key is to identify the most frequently used query patterns and create indexes that support those patterns while being mindful of the trade-offs involved.

### Next Steps
1. Run the performance tests in `database_index.sql`
2. Compare execution times before and after indexing
3. Monitor index usage over time
4. Adjust indexes based on actual usage patterns