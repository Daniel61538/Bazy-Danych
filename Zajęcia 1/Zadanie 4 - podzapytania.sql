/* Zadanie 1 */
SELECT 
	[SalesOrderID] AS 'Numery zam�wie� z�o�onych przez klienta o nazwisku Eminhizer'
	FROM [SalesLT].[SalesOrderHeader] 
	WHERE [CustomerID] IN 
	(
		SELECT [CustomerID] 
		FROM [SalesLT].[Customer] 
		WHERE [LastName] = 'Eminhizer'
	)

/* Zadanie 2 */
SELECT TOP 5 WITH TIES 
	[SalesOrderID] AS 'Numer Zam�wienia', 
	[TotalDue] AS 'Ca�kowita Warto��' 
	FROM [SalesLT].[SalesOrderHeader] 
	WHERE [SalesOrderID] NOT IN 
	(
		SELECT TOP 10 WITH TIES 
		[SalesOrderID] 
		FROM [SalesLT].[SalesOrderHeader]
		ORDER BY [TotalDue] DESC
	)
	ORDER BY [TotalDue] DESC

/* Zadanie 3 */
SELECT 
	[SalesOrderID] AS 'ID Zam�wienia', 
	[DueDate] AS 'Data Zap�aty', 
	[CustomerID] AS 'ID Klienta' 
	FROM [SalesLT].[SalesOrderHeader] 
	WHERE [DueDate] IN 
	(
		SELECT MAX([DueDate]) 
		FROM [SalesLT].[SalesOrderHeader] 
		GROUP BY YEAR([DueDate]), MONTH([DueDate])
	)
