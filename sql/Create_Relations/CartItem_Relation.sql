CREATE TABLE Cart_Item (
	cart_item_id SERIAL NOT NULL,
	cart_id SERIAL NOT NULL,
	clothing_id INT NOT NULL,
	clothing_cost DECIMAL,
	quantity INTEGER
);

ALTER TABLE Cart_Item ADD CONSTRAINT
cid_pk PRIMARY KEY(cart_item_id, cart_id);

ALTER TABLE Cart_Item ADD CONSTRAINT
cid_fk FOREIGN KEY(cart_id) 
REFERENCES Cart(cart_id);

ALTER TABLE Cart_Item ADD CONSTRAINT
clothingid_fk FOREIGN KEY(clothing_id) 
REFERENCES Clothing(clothing_id);




