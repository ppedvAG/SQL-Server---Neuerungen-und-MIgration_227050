
--This example creates a nonclustered columnstore index on an existing OLTP table.  
--Create the table  
CREATE TABLE t_account (  
    accountkey int PRIMARY KEY,  
    accountdescription nvarchar (50),  
    accounttype nvarchar(50),  
    unitsold int  
);  

--Create the columnstore index with a filtered condition  
CREATE NONCLUSTERED COLUMNSTORE INDEX account_NCCI   
ON t_account (accountkey, accountdescription, unitsold)   
;

CREATE TABLE t_account (  
    accountkey int NOT NULL PRIMARY KEY NONCLUSTERED,  
    Accountdescription nvarchar (50),  
    accounttype nvarchar(50),  
    unitsold int,  
    INDEX t_account_cci CLUSTERED COLUMNSTORE  
    )  
    WITH (MEMORY_OPTIMIZED = ON );  
GO  