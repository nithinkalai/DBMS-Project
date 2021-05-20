CREATE TABLE Cart_Items (
	cart_item_id VARCHAR(5) PRIMARY KEY NOT NULL,
	cart_id VARCHAR(5),
	clothing_id VARCHAR(5),
	clothing_cost DECIMAL,
	quantity INTEGER
);

ALTER TABLE Cart_Items ADD CONSTRAINT
cid_fk FOREIGN KEY(cart_id) 
REFERENCES Cart(cart_id);

ALTER TABLE Cart_Items ADD CONSTRAINT
clothingid_fk FOREIGN KEY(clothing_id) 
REFERENCES Clothing(clothing_id)




