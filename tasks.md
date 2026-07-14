# Creating the customer_feedback database
I opened DBeaver and created a new SQLite database called customer_feedback.db

I wrote and ran the following script to create the tables:

CREATE TABLE customers(
	customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
	customer_name TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE
);

CREATE TABLE products(
	product_id INTEGER PRIMARY KEY AUTOINCREMENT,
	product_name TEXT NOT NULL,
	category TEXT NOT NULL
);

CREATE TABLE feedback(
	feedback_id INTEGER PRIMARY KEY AUTOINCREMENT,
	customer_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	feedback_text TEXT,
	rating INTEGER CHECK(rating >=1 AND rating <=5),
	feedback_date TEXT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (product_id) REFERENCES product(product_id)
);

## Populating the Tables
I then ran the following script to populate the tables in order to make sure there was data to fetch:


INSERT INTO customers (customer_name, email) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');

INSERT INTO products (product_name, category) VALUES
('Laptop', 'Electronics'),
('Smartphone', 'Electronics'),
('Headphones', 'Accessories');

INSERT INTO feedback (customer_id, product_id, feedback_text, rating, feedback_date) VALUES
(1, 1, 'Amazing laptop, highly recommend!', 5, '2026-06-25'),
(2, 2, 'Good value for the price.', 4, '2026-06-26'),
(3, 3, 'Sound quality is excellent!', 5, '2026-06-27'),
(1, 2, 'Battery life could be better.', 3, '2026-06-28');

### Finding the total sales amount for each product
The database I had created did not have sales data, so to accomplish this task, I first created the sales table and populated it with data:

CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_date TEXT NOT NULL
);

CREATE TABLE sales_items (
    sales_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO sales (sale_date) VALUES
('2026-06-01'),  -- Sale 1
('2026-06-15'),  -- Sale 2
('2026-06-20');  -- Sale 3

INSERT INTO sales_items (sale_id, product_id, quantity) VALUES
(1, 1, 10),  -- 10 Laptops sold in Sale 1
(2, 2, 20),  -- 20 Smartphones sold in Sale 2
(3, 3, 15),  -- 15 Headphones sold in Sale 3
(2, 1, 5);   -- 5 Laptops sold in Sale 2 (additional product for Sale 2)

I also needed to add a price column to the products table in order to find the total sales amount, as well as for the task after:

ALTER TABLE products ADD COLUMN price DECIMAL NOT NULL DEFAULT 00.00;

UPDATE products SET price = 999.99 WHERE product_id = 1;  -- Laptop
UPDATE products SET price = 499.99 WHERE product_id = 2;  -- Smartphone
UPDATE products SET price = 199.99 WHERE product_id = 3;  -- Headphones

I then wrote the query:

SELECT
    p.product_name,
    SUM(si.quantity * p.price) AS total_sales_amount
FROM
    sales_items si
JOIN
    products p ON si.product_id = p.product_id
JOIN
    sales s ON si.sale_id = s.sale_id
GROUP BY
    p.product_id;


This returned the following data:

product_name|total_sales_amount|
------------+------------------+
Laptop      |14999.849999999999|
Smartphone  |            9999.8|
Headphones  |2999.8500000000004|


### Update the price of a specific product in the database

This task was much simpler to complete without modifying the database. The query for this was:

UPDATE products
SET price = 450.00
WHERE product_id = 2;  -- Update price for Smartphone

### Write a query to retrieve all customer feedback with a rating above 4

I used a multi-join query to complete this task:

feedback_text                    |rating|customer_name|product_name|
---------------------------------+------+-------------+------------+
Amazing laptop, highly recommend!|     5|Alice Smith  |Laptop      |
Sound quality is excellent!      |     5|Charlie Brown|Headphones  |

### Create a new table to store archived sales data and transfer records from the existing sales table that are older than one year

The first step in this task was to create the table:

CREATE TABLE continued_sales (
    sale_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_date TEXT NOT NULL
);

I then ran the following query to migrate the old data:

INSERT INTO continued_sales (sale_id, sale_date)
SELECT sale_id, sale_date
FROM sales
WHERE sale_date < DATE('now', '-1 year');

This query did not migrate any data because there were no entries with a date more than one year old, so I created one:

INSERT INTO sales (sale_date)
VALUES ('2023-01-01'), ('2023-02-05')

And then ran the migration query again, which updated the new table to:

sale_id|sale_date |
-------+----------+
      4|2023-01-01|
      5|2023-02-05|

This marks the end of the tasks list, I am now working on the Final Project, which I will include in the same directory as this document - After I have ensured that the customer_feedback.db file is in the correct directory.
