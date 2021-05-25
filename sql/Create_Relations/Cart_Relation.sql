CREATE TABLE Cart (
	cart_id SERIAL PRIMARY KEY NOT NULL,
	username VARCHAR(10),
	order_date DATE,
	delivery_date DATE,
	total_cost DECIMAL,
	if_bought BOOL DEFAULT FALSE
);

ALTER TABLE Cart ADD CONSTRAINT
user_fk FOREIGN KEY(username) REFERENCES Customer(username);



