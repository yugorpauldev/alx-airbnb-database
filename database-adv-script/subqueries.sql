SELECT 
    p.property_id,
    p.name
FROM Property p
WHERE (
    SELECT AVG(r.rating)
    FROM Review r
    WHERE r.property_id = p.property_id
) > 4.0
ORDER BY p.property_id;

-- Task 1.2: Users who have made more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name
FROM "User" u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY u.user_id;