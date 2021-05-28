CREATE OR REPLACE PROCEDURE update_qty
    (cartid IN Cart.cart_id%TYPE)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Clothing SET available_quantity = 
    available_quantity - (SELECT quantity FROM 
	Cart_item WHERE Clothing.clothing_id = Cart_item.clothing_id
    AND cart_id = cartid)
    WHERE Clothing.clothing_id = (SELECT clothing_id
    FROM Cart_item WHERE Cart_item.clothing_id = 
    Clothing.clothing_id AND cart_id = cartid);
    
    UPDATE Cart SET if_bought = TRUE WHERE 
	cart_id = cartid;

    COMMIT;
END $$;
