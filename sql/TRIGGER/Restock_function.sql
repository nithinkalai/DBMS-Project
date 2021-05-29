CREATE OR REPLACE FUNCTION restock()
RETURNS TRIGGER 
LANGUAGE PLPGSQL
AS
$$
BEGIN	
	UPDATE Clothing SET 
	available_quantity = available_quantity + 30
	WHERE available_quantity < 20;
	RETURN NEW;
END;
$$