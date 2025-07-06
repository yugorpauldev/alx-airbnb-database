-- Index on Booking.user_id (used in joins and filters)
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on Booking.property_id (used in joins)
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on Booking.start_date (used for date-range partitioning later)
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- Index on User.email (commonly filtered and must be unique)
CREATE INDEX idx_user_email ON "User"(email);

-- Index on Review.property_id (used in joins for property ratings)
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Index on Review.user_id (used when filtering user reviews)
CREATE INDEX idx_review_user_id ON Review(user_id);