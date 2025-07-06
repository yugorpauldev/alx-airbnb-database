-- INNER JOIN: Bookings with their users
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name
FROM Booking b
INNER JOIN "User" u ON b.user_id = u.user_id;

-- LEFT JOIN: Properties with their reviews (including properties without reviews)
SELECT 
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.rating,
    r.comment
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
ORDER BY p.property_id;

-- FULL OUTER JOIN: All users and bookings
SELECT 
    u.user_id,
    u.first_name,
    b.booking_id,
    b.start_date,
    b.end_date
FROM "User" u
FULL OUTER JOIN Booking b ON u.user_id = b.user_id;