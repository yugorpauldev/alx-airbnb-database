-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ========================
-- USERS (3 roles)
-- ========================
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
-- Guests
(gen_random_uuid(), 'Alice', 'Johnson', 'alice@example.com', 'hash1', '+1234567890', 'guest'),
(gen_random_uuid(), 'David', 'Brown', 'david@example.com', 'hash2', '+1234567891', 'guest'),
(gen_random_uuid(), 'Emma', 'Davis', 'emma@example.com', 'hash3', '+1234567892', 'guest'),
(gen_random_uuid(), 'Liam', 'Wilson', 'liam@example.com', 'hash4', '+1234567893', 'guest'),
-- Hosts
(gen_random_uuid(), 'Bob', 'Smith', 'bob@example.com', 'hash5', '+1234567894', 'host'),
(gen_random_uuid(), 'Sophia', 'Moore', 'sophia@example.com', 'hash6', '+1234567895', 'host'),
(gen_random_uuid(), 'Noah', 'Taylor', 'noah@example.com', 'hash7', '+1234567896', 'host'),
-- Admins
(gen_random_uuid(), 'Charlie', 'Lee', 'charlie@example.com', 'hash8', '+1234567897', 'admin'),
(gen_random_uuid(), 'Mia', 'Martinez', 'mia@example.com', 'hash9', '+1234567898', 'admin'),
(gen_random_uuid(), 'James', 'Clark', 'james@example.com', 'hash10', '+1234567899', 'admin');

-- ========================
-- PROPERTIES (owned by hosts)
-- ========================
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
SELECT
    gen_random_uuid(),
    u.user_id,
    p.name,
    p.description,
    p.location,
    p.price
FROM (
    VALUES
    ('Seaside Escape', 'Beachfront with ocean views.', 'Miami, FL', 150.00),
    ('Urban Loft', 'Modern loft in the heart of downtown.', 'New York, NY', 220.00),
    ('Mountain Cabin', 'Rustic cabin perfect for hiking getaways.', 'Denver, CO', 100.00),
    ('Desert Retreat', 'Peaceful desert experience.', 'Phoenix, AZ', 90.00),
    ('Lake House', 'Lakeside home with kayak access.', 'Lake Tahoe, CA', 200.00),
    ('Forest Cottage', 'Cozy cottage surrounded by nature.', 'Portland, OR', 110.00)
) AS p(name, description, location, price),
     (SELECT user_id FROM "User" WHERE role = 'host' LIMIT 6) u;

-- ========================
-- BOOKINGS (by guests on properties)
-- ========================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT
    gen_random_uuid(),
    p.property_id,
    g.user_id,
    '2025-08-01'::DATE + (i * INTERVAL '1 day'),
    '2025-08-05'::DATE + (i * INTERVAL '1 day'),
    p.price_per_night * 4,
    CASE WHEN i % 3 = 0 THEN 'confirmed'
         WHEN i % 3 = 1 THEN 'pending'
         ELSE 'canceled'
    END
FROM generate_series(0, 9) AS i,
     LATERAL (SELECT property_id, price_per_night FROM Property ORDER BY random() LIMIT 1) p,
     LATERAL (SELECT user_id FROM "User" WHERE role = 'guest' ORDER BY random() LIMIT 1) g;

-- ========================
-- PAYMENTS (for confirmed bookings only)
-- ========================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
SELECT
    gen_random_uuid(),
    b.booking_id,
    b.total_price,
    CASE WHEN random() < 0.33 THEN 'credit_card'
         WHEN random() < 0.66 THEN 'paypal'
         ELSE 'stripe'
    END
FROM Booking b
WHERE b.status = 'confirmed';

-- ========================
-- REVIEWS (from guests)
-- ========================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
SELECT
    gen_random_uuid(),
    b.property_id,
    b.user_id,
    4 + (random() * 1)::INT,
    'Great stay! Would book again.'
FROM Booking b
WHERE b.status = 'confirmed'
LIMIT 10;

-- ========================
-- MESSAGES (between guests and hosts)
-- ========================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
SELECT
    gen_random_uuid(),
    g.user_id,
    h.user_id,
    'Hi, is this property available in August?'
FROM
    (SELECT user_id FROM "User" WHERE role = 'guest' ORDER BY random() LIMIT 5) g,
    (SELECT user_id FROM "User" WHERE role = 'host' ORDER BY random() LIMIT 5) h
LIMIT 10;
