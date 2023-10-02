/* Zadanie 1 */
SELECT 
	[Product].[ProductNumber] as 'Numer produktu', 
	COUNT([SalesOrderDetail].[SalesOrderDetailID]) AS 'Liczba sprzeda�y',
	ROW_NUMBER() OVER (ORDER BY COUNT([SalesOrderDetail].[SalesOrderDetailID]) DESC) AS 'Najwi�ksza sprzeda� wg. Pozycji', 
	DENSE_RANK() OVER (ORDER BY COUNT([SalesOrderDetail].[SalesOrderDetailID]) DESC) AS 'Najwi�ksza sprzeda� wg. Ilo�ci'
	FROM [SalesLT].[SalesOrderDetail]
	JOIN [SalesLT].[Product] ON [Product].[ProductID] = [SalesOrderDetail].[ProductID] 
	GROUP BY [Product].[ProductNumber]
	ORDER BY COUNT([SalesOrderDetail].[SalesOrderDetailID]) DESC

/* Zadanie 2 */
SELECT 
	YEAR([DueDate]) AS 'Rok',
	MONTH([DueDate]) AS 'Miesi�c', 
	DAY([DueDate]) AS 'Dzie�',
	SUM ([TotalDue]) OVER (PARTITION BY DAY([DueDate])) AS 'Sprzeda� na Dzie�',
	SUM ([TotalDue]) OVER (PARTITION BY MONTH([DueDate])) AS 'Sprzeda� na Miesi�c',
	SUM ([TotalDue]) OVER (PARTITION BY YEAR([DueDate])) AS 'Sprzeda� na Rok',
	SUM ([TotalDue]) OVER () AS 'Sprzeda� ca�o�ciowa' 
	FROM [SalesLT].[SalesOrderHeader]

/* Zadanie 3 */
SELECT 
	[SalesOrderID] AS 'ID Zam�wienia', 
	[TotalDue] AS 'Ca�kowita warto��',    
	[TotalDue] - LAG ([TotalDue]) OVER (ORDER BY [SalesOrderID]) AS 'R�nica warto�ci pomi�dzy dwoma zam�wieniami'
	FROM [SalesLT].[SalesOrderHeader]