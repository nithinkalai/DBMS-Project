CREATE TABLE Customer (
	username VARCHAR(10) PRIMARY KEY NOT NULL,
	pass VARCHAR(15) NOT NULL,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	DoB DATE,
	gender CHAR,
	phno INTEGER,
	address VARCHAR(50)
);

ALTER TABLE Customer ADD CONSTRAINT 
chk_gender CHECK (gender IN('M', 'F', 'O'));
