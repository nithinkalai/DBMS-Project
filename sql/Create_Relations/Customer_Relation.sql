CREATE TABLE Customer (
	username VARCHAR(20) PRIMARY KEY NOT NULL,
	pass VARCHAR(65) NOT NULL,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	DoB DATE,
	gender CHAR,
	phno BIGINT,
	email TEXT UNIQUE NOT NULL,
	address VARCHAR(500)
);

ALTER TABLE Customer ADD CONSTRAINT 
chk_gender CHECK (gender IN('M', 'F', 'O'));
