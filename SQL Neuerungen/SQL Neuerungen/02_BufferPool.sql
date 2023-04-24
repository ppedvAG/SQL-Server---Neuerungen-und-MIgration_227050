--BufferPool
--falls der Arbeitsspeicher kanpp wird....
--ergänzend auf SSD einen Teil auslagern
--oder mit 

USE MASTER

ALTER SERVER CONFIGURATION 
SET BUFFER POOL EXTENSION ON
    (FILENAME = 'D:\_CACHE\SQL2019.BPE', SIZE = 10 GB);
GO

--DISABLE
ALTER SERVER CONFIGURATION 
    SET BUFFER POOL EXTENSION OFF;
GO

--Ändern

ALTER SERVER CONFIGURATION
SET BUFFER POOL EXTENSION ON
    (FILENAME = 'D:\_CACHE\SQL2019.BPE', SIZE = 11 GB);
GO

--SQL 2019
--aktivieren des hybrid buffer pool -- > PMEM
--Normalerweise cached SQL Server Daten in den Buffer pool.
--In hybrid buffer pools wird keine copy in den buffer Pool 
--geschoben, sondern greift via Pointer direkt auf die Datendatei des PMEM Device zu.
--Nur clean pages werden daruch abgerufen. Wenn eine Seite "dirty" ist,
--wird sie in den DRAM buffer pool kopiert, bevor
--sie auf das PMEM kopiert wird (clean)


ALTER SERVER CONFIGURATION 
SET MEMORY_OPTIMIZED HYBRID_BUFFER_POOL = ON;

--für best. DB
ALTER DATABASE northwind SET MEMORY_OPTIMIZED = ON;

--und aus
ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED HYBRID_BUFFER_POOL = OFF;
ALTER DATABASE <databaseName> SET MEMORY_OPTIMIZED = OFF;


--guggste
SELECT * FROM sys.configurations
WHERE
    name = 'hybrid_buffer_pool';

SELECT name, is_memory_optimized_enabled FROM sys.databases;


