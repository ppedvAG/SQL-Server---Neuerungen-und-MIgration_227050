
USE [master];
GO

ALTER DATABASE [WideWorldImportersDW] SET COMPATIBILITY_LEVEL = 150;
GO

USE [WideWorldImportersDW];
GO

-- Compare execution time and distinct counts
set statistics io, time on
SELECT COUNT(DISTINCT [WWI Order ID])
FROM [Fact].[OrderHistoryExtended]
OPTION (USE HINT('DISALLOW_BATCH_MODE'), RECOMPILE); -- Isolating out BMOR

SELECT APPROX_COUNT_DISTINCT([WWI Order ID])
FROM [Fact].[OrderHistoryExtended]
OPTION (USE HINT('DISALLOW_BATCH_MODE'), RECOMPILE); -- Isolating out BMOR
