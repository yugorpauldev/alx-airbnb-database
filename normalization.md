# Database Normalization Analysis to 3NF

## Overview
We'll examine each table for violations and provide solutions.

## Understanding Normal Forms


## Current Schema Analysis

### 1. User Table ✅
```sql
User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
```

**Analysis:**
- **1NF**: ✅ All attributes are atomic
- **2NF**: ✅ Single primary key, no partial dependencies
- **3NF**: ✅ No transitive dependencies

**Verdict:** Already in 3NF - No changes needed

### 2. Property Table ✅
```sql
Property (property_id, host_id, name, description, location, price_per_night, created_at, updated_at)
```

**Analysis:**
- **1NF**: ✅ All attributes are atomic
- **2NF**: ✅ Single primary key, no partial dependencies
- **3NF**: ✅ No transitive dependencies

**Verdict:** Already in 3NF - No changes needed

### 3. Booking Table ✅
```sql
Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
```

**Analysis:**
- **1NF**: ✅ All attributes are atomic
- **2NF**: ✅ Single primary key, no partial dependencies
- **3NF**: ⚠️ **Potential Issue**: `total_price` could be calculated from `price_per_night` and date range

**Normalization Decision:**
We'll keep `total_price` as a stored field for the following business reasons:
- **Price History**: Property prices may change over time
- **Discounts**: Special pricing, bulk discounts, seasonal rates
- **Performance**: Avoid complex calculations for reporting
- **Audit Trail**: Clear record of agreed-upon price at booking time

**Verdict:** Acceptable denormalization for business requirements

### 4. Payment Table ✅
```sql
Payment (payment_id, booking_id, amount, payment_date, payment_method)
```

**Analysis:**
- **1NF**: ✅ All attributes are atomic
- **2NF**: ✅ Single primary key, no partial dependencies
- **3NF**: ⚠️ **Potential Issue**: `amount` duplicates `total_price` from Booking

**Normalization Decision:**
We'll keep `amount` separate from `booking.total_price` for:
- **Partial Payments**: Support for installment payments
- **Refunds**: Negative amounts for cancellations
- **Currency Conversions**: Different payment amounts due to exchange rates
- **Fees**: Additional processing fees

**Verdict:** Acceptable denormalization for business requirements

### 5. Review Table ✅
```sql
Review (review_id, property_id, user_id, rating, comment, created_at)
```

**Analysis:**
- **1NF**: ✅ All attributes are atomic
- **2NF**: ✅ Single primary key, no partial dependencies
- **3NF**: ✅ No transitive dependencies

**Verdict:** Already in 3NF - No changes needed

### 6. Message Table ✅
```sql
Message (message_id, sender_id, recipient_id, message_body, sent_at)
```

**Analysis:**
- **1NF**: ✅ All attributes are atomic
- **2NF**: ✅ Single primary key, no partial dependencies
- **3NF**: ✅ No transitive dependencies

**Verdict:** Already in 3NF - No changes needed

## Identified Normalization Opportunities

### 1. Location Normalization (Optional Enhancement)

**Current Issue:**
The `location` field in the Property table stores free-text addresses, which could lead to:
- Data inconsistency (different formats for same location)
- Difficulty in location-based queries
- Redundant storage of city/state/country information

**Proposed Solution:**
Create a separate Location table for better normalization:

```sql
-- New Location Table
Location (
    location_id UUID PRIMARY KEY,
    street_address VARCHAR,
    city VARCHAR NOT NULL,
    state_province VARCHAR,
    country VARCHAR NOT NULL,
    postal_code VARCHAR,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    created_at TIMESTAMP
)

-- Modified Property Table
Property (
    property_id UUID PRIMARY KEY,
    host_id UUID REFERENCES User(user_id),
    location_id UUID REFERENCES Location(location_id),
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    price_per_night DECIMAL NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
)
```

## Final Normalized Schema (Enhanced)

### Core Tables (Already 3NF Compliant)
1. **User** - Stores user information
2. **Property** - Stores property details
3. **Booking** - Stores booking information
4. **Payment** - Stores payment transactions
5. **Review** - Stores property reviews
6. **Message** - Stores user messages

### Enhanced Tables (Optional for Better Normalization)
7. **Location** - Normalized location data