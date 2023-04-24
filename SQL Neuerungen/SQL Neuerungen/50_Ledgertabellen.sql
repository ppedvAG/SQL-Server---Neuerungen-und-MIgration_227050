 CREATE SCHEMA [Account];
GO  
CREATE TABLE [Account].[Balance]
(
    [CustomerID] INT NOT NULL PRIMARY KEY CLUSTERED,
    [LastName] VARCHAR (50) NOT NULL,
    [FirstName] VARCHAR (50) NOT NULL,
    [Balance] DECIMAL (10,2) NOT NULL
)
WITH 
(
 SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Account].[BalanceHistory]),
 LEDGER = ON
);

SELECT 
ts.[name] + '.' + t.[name] AS [ledger_table_name]
, hs.[name] + '.' + h.[name] AS [history_table_name]
, vs.[name] + '.' + v.[name] AS [ledger_view_name]
FROM sys.tables AS t
JOIN sys.tables AS h ON (h.[object_id] = t.[history_table_id])
JOIN sys.views v ON (v.[object_id] = t.[ledger_view_id])
JOIN sys.schemas ts ON (ts.[schema_id] = t.[schema_id])
JOIN sys.schemas hs ON (hs.[schema_id] = h.[schema_id])
JOIN sys.schemas vs ON (vs.[schema_id] = v.[schema_id])
WHERE t.[name] = 'Balance';


INSERT INTO [Account].[Balance]
VALUES (1, 'Jones', 'Nick', 50);


INSERT INTO [Account].[Balance]
VALUES (2, 'Smith', 'John', 500),
(3, 'Smith', 'Joe', 30),
(4, 'Michaels', 'Mary', 200);


SELECT [CustomerID]
   ,[LastName]
   ,[FirstName]
   ,[Balance]
   ,[ledger_start_transaction_id]
   ,[ledger_end_transaction_id]
   ,[ledger_start_sequence_number]
   ,[ledger_end_sequence_number]
 FROM [Account].[Balance];


 --Ledger TransactionID = eideutige TX ID  mit der die Daten eingefügt wurden

 --ledger Sequenz... in welcher Reihenfolge


 UPDATE [Account].[Balance] SET [Balance] = 100
WHERE [CustomerID] = 1;

 UPDATE [Account].[Balance] SET [Balance] = 100
WHERE [CustomerID] = 2;

delete from account.balance where customerid = 3


select * from account.balanceHistory

SELECT
 t.[commit_time] AS [CommitTime] 
 , t.[principal_name] AS [UserName]
 , l.[CustomerID]
 , l.[LastName]
 , l.[FirstName]
 , l.[Balance]
 , l.[ledger_operation_type_desc] AS Operation
 FROM [Account].[Balance_Ledger] l
 JOIN sys.database_ledger_transactions t
 ON t.transaction_id = l.ledger_transaction_id
 ORDER BY t.commit_time DESC;


 SELECT [CustomerID]
   ,[LastName]
   ,[FirstName]
   ,[Balance]
   ,[ledger_start_transaction_id]
   ,[ledger_end_transaction_id]
   ,[ledger_start_sequence_number]
   ,[ledger_end_sequence_number]
 FROM [Account].[Balance];