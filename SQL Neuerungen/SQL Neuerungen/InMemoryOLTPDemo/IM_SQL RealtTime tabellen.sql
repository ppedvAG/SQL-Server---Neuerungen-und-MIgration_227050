USE [Northwind]
GO

DROP TABLE IF EXISTS BEST;
GO

CREATE TABLE [dbo].[BEST](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
 CONSTRAINT [PK_O] PRIMARY KEY NONCLUSTERED 
(
	[OrderID] ASC
))
USE [Northwind]
GO

CREATE CLUSTERED INDEX [NIX1] ON [dbo].[BEST]
(
	[OrderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
USE [Northwind]
GO
CREATE NONCLUSTERED INDEX [NIX2] ON [dbo].[BEST]
(
	[Freight] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


--Jetzt in Memomory mit Columstore
--alle Indizes löschen
--dafür NON CL COL Store filtered
DROP INDEX [NIX1] ON [dbo].[BEST] 
GO
DROP INDEX [NIX2] ON [dbo].[BEST] 

GO
create nonclustered Columnstore Index NCCSfilter on BEST(orderid, customerid, freight, orderdate)
 WHERE (orderdate < '1.1.2020');
GO



-----oder----


DROP TABLE IF EXISTS BEST;
GO

CREATE TABLE [dbo].[BEST](
	[OrderID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,

	  INDEX t_account_cci CLUSTERED COLUMNSTORE  
    )  
    WITH (MEMORY_OPTIMIZED = ON );  
	
