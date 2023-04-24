SELECT name, modify_date,
  MonthModified = DATEADD(MONTH, DATEDIFF(MONTH, '19000101', modify_date), '19000101')
FROM sys.all_objects;


SELECT name, modify_date,
  MonthModified = DATEFROMPARTS(YEAR(modify_date), 
								MONTH(modify_date), 1)
FROM sys.all_objects;


SELECT name, modify_date,
  MonthModified = DATE_BUCKET(MONTH, 1, modify_date)
FROM sys.all_objects;


select date_bucket(week,3,getdate())


DECLARE @date DATETIME2 = '2023-01-12 14:30:45';
SELECT 'Week', DATE_BUCKET(WEEK, 1, @date)
UNION ALL
SELECT 'Day', DATE_BUCKET(DAY, 2, @date)
UNION ALL
SELECT 'Hour', DATE_BUCKET(HOUR, 2, @date)
UNION ALL
SELECT 'Minutes', DATE_BUCKET(MINUTE, 2, @date)
UNION ALL
SELECT 'Seconds', DATE_BUCKET(SECOND, 2, @date);



DECLARE @origin DATE = '2023/01/01';
DECLARE @bucketsize INT = 4
SELECT 
 date_bucket(week, @bucketsize, CAST('2023/01/15' as date), @origin),
 date_bucket(week, @bucketsize, CAST('2023/01/30' as date), @origin),
 date_bucket(week, @bucketsize, CAST('2023/02/25' as date), @origin),
 date_bucket(week, @bucketsize, CAST('2023/03/04' as date), @origin),
 date_bucket(day, @bucketsize, 	 CAST('2023/01/15' as date), @origin)

DECLARE @origin DATE = '1.1.2023';
DECLARE @bucketsize INT = 7




select orderdate ,
		date_bucket(week,1,cast(orderdate as date),cast('1.1.1996' as date))  
		from orders


select orderdate ,
		date_bucket(week,1,cast(orderdate as date),cast('1.1.1996' as date)) ,
		avg(freight)
from orders
group by orderdate,date_bucket(week,1,cast(orderdate as date),cast('1.1.1996' as date)) 
 

 --14 tägig
select Shipcountry ,
		date_bucket(week,2,cast(orderdate as date),cast('1.1.1996' as date)) ,
		avg(freight)
from orders
group by shipcountry,date_bucket(week,1,cast(orderdate as date),cast('1.1.1996' as date)), orderdate 
 
