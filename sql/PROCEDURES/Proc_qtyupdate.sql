CREATE OR REPLACE PROCEDURE qtyupdate(cartid INTEGER)
AS $$
DECLARE
	 rec_clothing   record;
	 cur_clothing CURSOR(cartid INTEGER) 
		 for SELECT clothing_id, quantity
		 FROM cart_item
		 WHERE cart_id = cartid;
BEGIN
   OPEN cur_clothing(cartid);
   LOOP
      FETCH cur_clothing INTO rec_clothing;
      EXIT WHEN NOT FOUND;
      UPDATE clothing SET available_quantity = 
	  available_quantity - rec_clothing.quantity 
      WHERE clothing.clothing_id = rec_clothing.clothing_id;
   END LOOP;
   CLOSE cur_clothing;
   UPDATE Cart SET if_bought = TRUE WHERE cart_id = cartid;
   COMMIT;
END; $$
LANGUAGE plpgsql;

