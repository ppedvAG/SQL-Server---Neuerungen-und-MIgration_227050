--Create memory optimized table and indexes on the memory optimized table.
CREATE TABLE imTabelle
(
	id int identity, 
	sp1 varchar(50),
	sp2 money INDEX IXIM NONCLUSTERED (sp2), 

   CONSTRAINT PK_IM PRIMARY KEY NONCLUSTERED (sp1),
   INDEX IXhash HASH (id) WITH (BUCKET_COUNT = 131072)
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = Schema_only)
GO

--in mmeory erstellen

CREATE TABLE imTabelle
(
	id int identity, 
	sp1 varchar(50),
	sp2 money INDEX IXIM NONCLUSTERED (sp2), 

   CONSTRAINT PK_IM PRIMARY KEY NONCLUSTERED (sp1),
  INDEX IXhash HASH (id) WITH (BUCKET_COUNT = 131072)
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = Schema_only)
GO


--Bucketcount
--Wird uf die nächste 2er Potenz gerundet
--> 1 MIo --> 1.048.576
--> Bucket Count *8
-- + 8 bytes mal Anzahl der zeilen

---> 1,073,741,824 ---> 8.589.934.592 bytes

--Formel für Bucket Count
SELECT
  POWER(
    2,
    CEILING( LOG( COUNT( 0)) / LOG( 2)))
    AS 'BUCKET_COUNT'
FROM
  (SELECT DISTINCT id 
      FROM ku1) T