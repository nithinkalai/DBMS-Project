CREATE TABLE Bill (
	bill_id SERIAL PRIMARY KEY NOT NULL,
	cart_id BIGINT UNIQUE NOT NULL,
	order_date DATE,
	delivery_date DATE,
	total_cost BIGINT
);

ALTER TABLE Bill ADD CONSTRAINT
cartid_fk FOREIGN KEY(cart_id)
REFERENCES Cart(cart_id);