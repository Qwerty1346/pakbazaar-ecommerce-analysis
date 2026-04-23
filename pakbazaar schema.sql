-- ============================================
-- PakBazaar: Pakistani E-Commerce Database
-- ============================================

CREATE TABLE customers (
    customer_id     INTEGER PRIMARY KEY,
    customer_name   TEXT NOT NULL,
    city            TEXT NOT NULL,
    signup_date     DATE NOT NULL,
    gender          TEXT
);

CREATE TABLE products (
    product_id      INTEGER PRIMARY KEY,
    product_name    TEXT NOT NULL,
    category        TEXT NOT NULL,
    cost_price      DECIMAL(10,2),
    selling_price   DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id        INTEGER PRIMARY KEY,
    customer_id     INTEGER REFERENCES customers(customer_id),
    order_date      DATE NOT NULL,
    delivery_city   TEXT NOT NULL,
    status          TEXT NOT NULL  -- 'Delivered','Returned','Cancelled','Pending'
);

CREATE TABLE order_items (
    item_id         INTEGER PRIMARY KEY,
    order_id        INTEGER REFERENCES orders(order_id),
    product_id      INTEGER REFERENCES products(product_id),
    quantity        INTEGER NOT NULL,
    unit_price      DECIMAL(10,2) NOT NULL
);
-- CUSTOMERS
INSERT INTO customers VALUES
(1,  'Ahmed Raza',       'Karachi',     '2023-01-15', 'Male'),
(2,  'Fatima Malik',     'Lahore',      '2023-02-01', 'Female'),
(3,  'Bilal Khan',       'Islamabad',   '2023-02-14', 'Male'),
(4,  'Sana Hussain',     'Faisalabad',  '2023-03-05', 'Female'),
(5,  'Usman Tariq',      'Rawalpindi',  '2023-03-20', 'Male'),
(6,  'Ayesha Noor',      'Multan',      '2023-04-10', 'Female'),
(7,  'Zain Sheikh',      'Karachi',     '2023-04-22', 'Male'),
(8,  'Hira Baig',        'Lahore',      '2023-05-03', 'Female'),
(9,  'Omar Farooq',      'Peshawar',    '2023-05-18', 'Male'),
(10, 'Mariam Qureshi',   'Karachi',     '2023-06-01', 'Female'),
(11, 'Danish Ali',       'Lahore',      '2023-06-15', 'Male'),
(12, 'Nadia Iqbal',      'Islamabad',   '2023-07-04', 'Female'),
(13, 'Hamza Saeed',      'Quetta',      '2023-07-19', 'Male'),
(14, 'Zara Chaudhry',    'Karachi',     '2023-08-08', 'Female'),
(15, 'Faisal Mirza',     'Multan',      '2023-08-25', 'Male');

-- PRODUCTS (prices in PKR)
INSERT INTO products VALUES
(1,  'Samsung Galaxy A54',    'Electronics',     45000, 62000),
(2,  'Wireless Earbuds',      'Electronics',      3500,  5500),
(3,  'Leather Kurta',         'Clothing',          800,  1800),
(4,  'Lawn Suit (Branded)',   'Clothing',         1200,  2800),
(5,  'Pressure Cooker 5L',    'Home & Kitchen',   2200,  3800),
(6,  'Non-stick Cookware Set','Home & Kitchen',   3500,  6200),
(7,  'Whitening Facewash',    'Beauty',            400,   950),
(8,  'Hair Serum Premium',    'Beauty',            900,  1900),
(9,  'Atomic Habits (Urdu)',  'Books',             350,   750),
(10, 'Cricket Bat Kashmir',   'Sports',           2800,  5500),
(11, 'USB-C Fast Charger',    'Electronics',       800,  1600),
(12, 'Shalwar Kameez Set',    'Clothing',          600,  1400),
(13, 'Electric Kettle',       'Home & Kitchen',   1800,  3200),
(14, 'Sunblock SPF50',        'Beauty',            600,  1400),
(15, 'Badminton Racket Set',  'Sports',           1500,  3200);

-- ORDERS
INSERT INTO orders VALUES
(101, 1,  '2023-09-01', 'Karachi',    'Delivered'),
(102, 2,  '2023-09-03', 'Lahore',     'Delivered'),
(103, 3,  '2023-09-05', 'Islamabad',  'Returned'),
(104, 4,  '2023-09-08', 'Faisalabad', 'Delivered'),
(105, 5,  '2023-09-10', 'Rawalpindi', 'Cancelled'),
(106, 6,  '2023-09-12', 'Multan',     'Delivered'),
(107, 7,  '2023-09-15', 'Karachi',    'Delivered'),
(108, 8,  '2023-09-18', 'Lahore',     'Delivered'),
(109, 9,  '2023-09-20', 'Peshawar',   'Returned'),
(110, 10, '2023-09-22', 'Karachi',    'Delivered'),
(111, 1,  '2023-10-01', 'Karachi',    'Delivered'),
(112, 2,  '2023-10-05', 'Lahore',     'Delivered'),
(113, 11, '2023-10-08', 'Lahore',     'Cancelled'),
(114, 12, '2023-10-12', 'Islamabad',  'Delivered'),
(115, 14, '2023-10-15', 'Karachi',    'Delivered'),
(116, 3,  '2023-10-20', 'Islamabad',  'Delivered'),
(117, 7,  '2023-10-25', 'Karachi',    'Returned'),
(118, 15, '2023-11-01', 'Multan',     'Delivered'),
(119, 10, '2023-11-05', 'Karachi',    'Delivered'),
(120, 6,  '2023-11-10', 'Multan',     'Delivered');

-- ORDER ITEMS
INSERT INTO order_items VALUES
(1,  101, 1,  1, 62000),
(2,  101, 7,  2,   950),
(3,  102, 4,  3,  2800),
(4,  102, 8,  1,  1900),
(5,  103, 2,  1,  5500),
(6,  104, 5,  1,  3800),
(7,  104, 9,  2,   750),
(8,  105, 10, 1,  5500),
(9,  106, 6,  1,  6200),
(10, 107, 11, 2,  1600),
(11, 107, 3,  1,  1800),
(12, 108, 12, 2,  1400),
(13, 108, 14, 1,  1400),
(14, 109, 1,  1, 62000),
(15, 110, 13, 1,  3200),
(16, 110, 7,  3,   950),
(17, 111, 2,  2,  5500),
(18, 112, 4,  2,  2800),
(19, 113, 15, 1,  3200),
(20, 114, 6,  1,  6200),
(21, 115, 8,  2,  1900),
(22, 115, 14, 1,  1400),
(23, 116, 11, 3,  1600),
(24, 117, 1,  1, 62000),
(25, 118, 5,  2,  3800),
(26, 119, 13, 1,  3200),
(27, 119, 9,  1,   750),
(28, 120, 3,  3,  1800);