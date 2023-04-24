--Suche alle, die nicht RJ sind...

--sicher korrekt.. auch NUll werte?

--  IS DISTINCT FROM 'RJ'
--  IS NOT DISTINCT FROM 'RJ'	   
-- IS DISTINCT FROM NULL


SELECT * from orders WHERE Shipregion  != 'RJ'	--keine NULLS
--also

SELECT * from orders WHERE Shipregion  != 'RJ'	
							or
							shipregion is  null 


SELECT * from orders WHERE isnull(Shipregion,'NIX') not in  ('RJ', 'NIX')	
						


SELECT * from orders WHERE Shipregion  IS DISTINCT FROM 'RJ'




