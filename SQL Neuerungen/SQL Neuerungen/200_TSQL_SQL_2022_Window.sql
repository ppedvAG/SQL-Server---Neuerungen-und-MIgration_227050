 SELECT orderid, custid, orderdate, qty, val,
  SUM(qty) OVER( PARTITION BY custid 
                 ORDER BY orderdate, orderid
                 ROWS UNBOUNDED PRECEDING ) AS runsumqty,
  SUM(val) OVER( PARTITION BY custid 
                 ORDER BY orderdate, orderid
                 ROWS UNBOUNDED PRECEDING ) AS runsumval
FROM Sales.OrderValues
WHERE custid IN (1, 2)
ORDER BY custid, orderdate, orderid;


SELECT orderid, custid, orderdate, qty, val,
  SUM(qty) OVER W AS runsumqty,
  SUM(val) OVER W AS runsumval
FROM Sales.OrderValues
WHERE custid IN (1, 2)
WINDOW W AS ( PARTITION BY custid 
              ORDER BY orderdate, orderid
              ROWS UNBOUNDED PRECEDING )
ORDER BY custid, orderdate, orderid;


-------------

SELECT orderid, custid, orderdate, qty, val,
  ROW_NUMBER() OVER( PARTITION BY custid
                     ORDER BY orderdate, orderid ) AS ordernum,
  MAX(orderdate) OVER( PARTITION BY custid ) AS maxorderdate,
  SUM(qty) OVER( PARTITION BY custid 
                 ORDER BY orderdate, orderid
                 ROWS UNBOUNDED PRECEDING ) AS runsumqty,
  SUM(val) OVER( PARTITION BY custid           
                 ORDER BY orderdate, orderid   
                 ROWS UNBOUNDED PRECEDING ) AS runsumval
FROM Sales.OrderValues
WHERE custid IN (1, 2)
ORDER BY custid, orderdate, orderid;

SELECT orderid, custid, orderdate, qty, val,
  ROW_NUMBER() OVER PO AS ordernum,
  MAX(orderdate) OVER P AS maxorderdate,
  SUM(qty) OVER POF AS runsumqty,
  SUM(val) OVER POF AS runsumval
FROM Sales.OrderValues
WHERE custid IN (1, 2)
WINDOW P AS ( PARTITION BY custid ),
       PO AS ( P ORDER BY orderdate, orderid ),
       POF AS ( PO ROWS UNBOUNDED PRECEDING )
ORDER BY custid, orderdate, orderid;
--oder
  ROW_NUMBER() OVER PO AS ordernum,
  MAX(orderdate) OVER P AS maxorderdate,
  SUM(qty) OVER POF AS runsumqty,
  SUM(val) OVER POF AS runsumval
FROM Sales.OrderValues
WHERE custid IN (1, 2)
WINDOW POF AS ( PO ROWS UNBOUNDED PRECEDING ),
       PO AS ( P ORDER BY orderdate, orderid ),
       P AS ( PARTITION BY custid )
ORDER BY custid, orderdate, orderid;
--geht nicht
SELECT orderid, custid, orderdate, qty, val,
  SUM(qty) OVER ( P O F ) AS runsumqty,
  SUM(val) OVER ( P O F ) AS runsumval
FROM Sales.OrderValues
WHERE custid IN (1, 2)
WINDOW P AS ( PARTITION BY custid ),
       O AS ( ORDER BY orderdate, orderid ),
       F AS ( ROWS UNBOUNDED PRECEDING )
ORDER BY custid, orderdate, orderid;








use northwind;
go

select row_number() over (partition by shipcountry order by freight desc) 
		as Rownumber,  shipcountry,
	orderid, customerid
from orders
order by 2,1



select row_number() over win as Rownumber
		,  shipcountry,
	orderid, customerid
from orders
window win as  (partition by shipcountry order by freight desc) 
order by 2,1


SELECT ROW_NUMBER() OVER win AS "Row Number",
    p.LastName, s.SalesYTD, a.PostalCode
FROM Sales.SalesPerson AS s
    INNER JOIN Person.Person AS p
        ON s.BusinessEntityID = p.BusinessEntityID
    INNER JOIN Person.Address AS a
        ON a.AddressID = p.BusinessEntityID
WHERE TerritoryID IS NOT NULL
    AND SalesYTD <> 0
WINDOW win AS (PARTITION BY PostalCode ORDER BY SalesYTD DESC)
ORDER BY PostalCode;
GO



use northwind;
go

select row_number() over (partition by shipcountry order by freight desc) 
		as Rownumber,  shipcountry,
	orderid, customerid
from orders
order by 2,1



select row_number() over win as Rownumber
		,  shipcountry,
	orderid, customerid
from orders
window win as  (partition by shipcountry order by freight desc) 
order by 2,1


SELECT ROW_NUMBER() OVER win AS "Row Number",
    p.LastName, s.SalesYTD, a.PostalCode
FROM Sales.SalesPerson AS s
    INNER JOIN Person.Person AS p
        ON s.BusinessEntityID = p.BusinessEntityID
    INNER JOIN Person.Address AS a
        ON a.AddressID = p.BusinessEntityID
WHERE TerritoryID IS NOT NULL
    AND SalesYTD <> 0
WINDOW win AS (PARTITION BY PostalCode ORDER BY SalesYTD DESC)
ORDER BY PostalCode;
