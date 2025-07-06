This project demonstrates the advanced use of Python generators to efficiently process large datasets stored in a MySQL database. Generators are used to stream, batch process, and lazily paginate user data, as well as calculate memory-efficient aggregates.

## Learning Objectives
- Create and use Python generators
- Handle large datasets in memory-efficient ways
- Simulate real-world data streaming and updates
- Perform aggregation without loading the entire dataset
- Integrate Python with SQL (MySQL)

## Requirements
- Python 3.x
- MySQL server
- `mysql-connector-python` package

## Setup Instructions
1. Install MySQL and set root password.
2. Install dependencies:
   ```bash
   pip install mysql-connector-python
   ```
3. Replace `your_password` in `seed.py` with your actual MySQL root password.
4. Ensure `user_data.csv` is in the same directory.
5. Run:
   ```bash
   python3 0-main.py
   python3 1-main.py
   python3 2-main.py
   python3 3-main.py
   python3 4-main.py
   ```

## File Descriptions
- `seed.py`: Handles database setup, table creation, and data seeding.
- `0-stream_users.py`: Streams user records one at a time.
- `1-batch_processing.py`: Fetches and filters users in batches.
- `2-lazy_paginate.py`: Lazily loads paginated user data.
- `4-stream_ages.py`: Streams user ages to calculate average.