-- Create CUSTOMER table
CREATE TABLE CUSTOMER (
    cust_id INT PRIMARY KEY,
    city NVARCHAR(100),
    state NVARCHAR(100),
    region NVARCHAR(100),
    country NVARCHAR(100)
);

-- Create PRODUCT table
CREATE TABLE PRODUCT (
    prod_id INT PRIMARY KEY,
    prod_name NVARCHAR(100),
    category NVARCHAR(100),
    cost_price DECIMAL(10,2),
    sell_price DECIMAL(10,2),
    supplier NVARCHAR(100)
);

-- Create TIME table
CREATE TABLE TIME (
    time_key INT PRIMARY KEY,
    month INT,
    month_name NVARCHAR(20),
    quarter INT,
    year INT
);

-- Create PURCHASES table
CREATE TABLE PURCHASES (
    prod_id INT,
    time_key INT,
    cust_id INT,
    ship_date DATE,
    purchase_price DECIMAL(10,2),
    shipping_charge DECIMAL(10,2),
    FOREIGN KEY (prod_id) REFERENCES PRODUCT(prod_id),
    FOREIGN KEY (time_key) REFERENCES TIME(time_key),
    FOREIGN KEY (cust_id) REFERENCES CUSTOMER(cust_id)
);

-- Fill in CUSTOMER table
INSERT INTO CUSTOMER (cust_id, city, state, region, country) VALUES 
(1, 'New York', 'NY', 'East', 'USA'),
(2, 'Los Angeles', 'CA', 'West', 'USA'),
(3, 'Chicago', 'IL', 'Midwest', 'USA'),
(4, 'Houston', 'TX', 'South', 'USA'),
(5, 'Paris', NULL, 'Europe', 'France');

-- Fill in PRODUCT table
INSERT INTO PRODUCT (prod_id, prod_name, category, cost_price, sell_price, supplier) VALUES 
(101, 'Wireless Mouse', 'Electronics', 10.00, 20.00, 'LogiTech'),
(102, 'USB-C Charger', 'Electronics', 8.00, 15.00, 'Anker'),
(103, 'Notebook', 'Stationery', 2.00, 4.50, 'Moleskine'),
(104, 'Office Chair', 'Furniture', 50.00, 90.00, 'IKEA'),
(105, 'Desk Lamp', 'Furniture', 15.00, 30.00, 'Philips');

-- Fill in TIME table
INSERT INTO TIME (time_key, month, month_name, quarter, year) VALUES 
(202401, 1, 'January', 1, 2024),
(202402, 2, 'February', 1, 2024),
(202403, 3, 'March', 1, 2024),
(202404, 4, 'April', 2, 2024),
(202405, 5, 'May', 2, 2024);

-- Fill in PURCHASES table
INSERT INTO PURCHASES (prod_id, time_key, cust_id, ship_date, purchase_price, shipping_charge) VALUES 
(101, 202401, 1, '2024-01-10', 20.00, 5.00),
(102, 202402, 2, '2024-02-15', 15.00, 3.50),
(103, 202403, 3, '2024-03-20', 4.50, 2.00),
(104, 202404, 4, '2024-04-05', 90.00, 10.00),
(105, 202405, 5, '2024-05-22', 30.00, 4.00),
(101, 202401, 2, '2024-01-18', 20.00, 5.00),
(103, 202403, 1, '2024-03-25', 4.50, 2.00);

SELECT category, year, AVG(purchase_price)
FROM PURCHASES
JOIN PRODUCT
ON PURCHASES.prod_id = PRODUCT.prod_id
JOIN TIME
ON TIME.time_key = PURCHASES.time_key
GROUP BY category, year;

SELECT category, year, AVG(purchase_price)
FROM PURCHASES
JOIN PRODUCT
ON PURCHASES.prod_id = PRODUCT.prod_id
JOIN TIME
ON TIME.time_key = PURCHASES.time_key
GROUP BY GROUPING SETS (category, year);

SELECT category, year, AVG(purchase_price)
FROM PURCHASES
JOIN PRODUCT
ON PURCHASES.prod_id = PRODUCT.prod_id
JOIN TIME
ON TIME.time_key = PURCHASES.time_key
GROUP BY ROLLUP (category, year);

SELECT category, year, AVG(purchase_price)
FROM PURCHASES
JOIN PRODUCT
ON PURCHASES.prod_id = PRODUCT.prod_id
JOIN TIME
ON TIME.time_key = PURCHASES.time_key
GROUP BY CUBE (category, year);

SELECT category, year, region, SUM(purchase_price)
FROM PURCHASES
JOIN PRODUCT
ON PURCHASES.prod_id = PRODUCT.prod_id
JOIN TIME
ON TIME.time_key = PURCHASES.time_key
JOIN CUSTOMER
ON CUSTOMER.cust_id = PURCHASES.cust_id
GROUP BY CUBE (category, year, region);

SELECT category, year, region, SUM(purchase_price)
FROM PURCHASES
JOIN PRODUCT
ON PURCHASES.prod_id = PRODUCT.prod_id
JOIN TIME
ON TIME.time_key = PURCHASES.time_key
JOIN CUSTOMER
ON CUSTOMER.cust_id = PURCHASES.cust_id
GROUP BY ROLLUP (category, year, region);