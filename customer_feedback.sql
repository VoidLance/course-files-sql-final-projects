PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE customers(
	customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
	customer_name TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE
);
INSERT INTO customers VALUES(1,'Alice Smith','alice@example.com');
INSERT INTO customers VALUES(2,'Bob Johnson','bob@example.com');
INSERT INTO customers VALUES(3,'Charlie Brown','charlie@example.com');
CREATE TABLE products(
	product_id INTEGER PRIMARY KEY AUTOINCREMENT,
	product_name TEXT NOT NULL,
	category TEXT NOT NULL
, price DECIMAL NOT NULL DEFAULT 00.00);
INSERT INTO products VALUES(1,'Laptop','Electronics',999.99);
INSERT INTO products VALUES(2,'Smartphone','Electronics',499.99);
INSERT INTO products VALUES(3,'Headphones','Accessories',199.99);
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
INSERT INTO feedback VALUES(1,1,1,'Amazing laptop, highly recommend!',5,'2026-06-25');
INSERT INTO feedback VALUES(2,2,2,'Good value for the price.',4,'2026-06-26');
INSERT INTO feedback VALUES(3,3,3,'Sound quality is excellent!',5,'2026-06-27');
INSERT INTO feedback VALUES(4,1,2,'Battery life could be better.',3,'2026-06-28');
CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_date TEXT NOT NULL
);
INSERT INTO sales VALUES(1,'2026-06-01');
INSERT INTO sales VALUES(2,'2026-06-15');
INSERT INTO sales VALUES(3,'2026-06-20');
INSERT INTO sales VALUES(4,'2023-01-01');
INSERT INTO sales VALUES(5,'2023-02-05');
CREATE TABLE sales_items (
    sales_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO sales_items VALUES(1,1,1,10);
INSERT INTO sales_items VALUES(2,2,2,20);
INSERT INTO sales_items VALUES(3,3,3,15);
INSERT INTO sales_items VALUES(4,2,1,5);
CREATE TABLE continued_sales (
    sale_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_date TEXT NOT NULL
);
INSERT INTO continued_sales VALUES(4,'2023-01-01');
INSERT INTO continued_sales VALUES(5,'2023-02-05');
PRAGMA writable_schema=ON;
CREATE TABLE IF NOT EXISTS sqlite_sequence(name,seq);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('customers',3);
INSERT INTO sqlite_sequence VALUES('products',3);
INSERT INTO sqlite_sequence VALUES('feedback',4);
INSERT INTO sqlite_sequence VALUES('sales',5);
INSERT INTO sqlite_sequence VALUES('sales_items',4);
INSERT INTO sqlite_sequence VALUES('continued_sales',5);
PRAGMA writable_schema=OFF;
COMMIT;
