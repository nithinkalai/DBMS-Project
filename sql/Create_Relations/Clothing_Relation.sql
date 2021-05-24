CREATE TABLE Clothing (
	clothing_id VARCHAR(5) PRIMARY KEY,
	clothing_name VARCHAR(15) NOT NULL,
	category VARCHAR(15),
	description VARCHAR(45),
	seller VARCHAR(20),
	price INTEGER NOT NULL,
	available_quantity INTEGER
);

ALTER TABLE Clothing ADD CONSTRAINT 
chk_price CHECK(price >= 0);
