CREATE OR REPLACE FUNCTION restock()
RETURNS TRIGGER AS
$$
BEGIN	
	UPDATE Clothing SET 
	available_quantity = available_quantity + 30
	WHERE available_quantity < 20;

END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER clothing_restock
AFTER UPDATE
ON Clothing
FOR EACH STATEMENT
EXECUTE PROCEDURE restock();
