PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE Customers(
	customerID INTEGER PRIMARY KEY AUTOINCREMENT,
	firstName TEXT NOT NULL,
	lastName TEXT NOT NULL,
	email TEXT UNIQUE
);
CREATE TABLE Products(
	productID INTEGER PRIMARY KEY AUTOINCREMENT,
	productName TEXT NOT NULL,
	price REAL NOT NULL,
	stock INTEGER
);
CREATE TABLE Orders(
	orderID INTEGER PRIMARY KEY AUTOINCREMENT,
	customerID INTEGER NOT NULL,
	productID INTEGER,
	quantity INTEGER NOT NULL,
	value REAL NOT NULL,
	FOREIGN KEY (customerID) REFERENCES Customers(customerID),
	FOREIGN KEY (productID) REFERENCES Products(productID)
);
CREATE TABLE Feedback(
	feedbackID INTEGER PRIMARY KEY AUTOINCREMENT,
	customerID INTEGER NOT NULL UNIQUE,
	orderID INTEGER NOT NULL UNIQUE,
	feedbackText TEXT,
	rating REAL CHECK(rating >=1 AND rating <=5),
	FOREIGN KEY (customerID) REFERENCES Customers(customerID),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);
CREATE INDEX idx_price ON Products(price);
CREATE INDEX idx_quantity ON Orders(quantity);
CREATE INDEX idx_customer ON Customers(customerID);
CREATE INDEX idx_orders_customerID ON Orders(customerID);
CREATE INDEX idx_orders_productID ON Orders(productID);
COMMIT;
