CREATE TABLE Clothing (
	clothing_id INT PRIMARY KEY,
	clothing_name VARCHAR(15) NOT NULL,
	category VARCHAR(15),
	description VARCHAR(200),
	seller VARCHAR(20),
	price INTEGER NOT NULL,
	available_quantity INTEGER
);

ALTER TABLE Clothing ADD CONSTRAINT 
chk_price CHECK(price >= 0);

CREATE SEQUENCE IF NOT EXISTS cloth_sequence
AS INT
INCREMENT 1
MINVALUE 1000
START 1000
NO CYCLE
OWNED BY Clothing.clothing_id;






