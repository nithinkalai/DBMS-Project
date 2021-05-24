CREATE TABLE Cart (
	cart_id VARCHAR(5) PRIMARY KEY NOT NULL,
	username VARCHAR(10),
	order_date DATE,
	delivery_date DATE,
	total_cost DECIMAL
);

ALTER TABLE Cart ADD CONSTRAINT
user_fk FOREIGN KEY(username) REFERENCES Customer(username);
