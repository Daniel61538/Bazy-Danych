/* Zadanie 1 */
SELECT [Name] AS 'Nazwa produktu', [ListPrice]*1.20 AS 'Cena produktu + 20%' 
	FROM [SalesLT].[Product]

/* Zadanie 2 */
SELECT [SalesOrderID] AS 'Numer zam�wienia', DATEDIFF(DAY, [OrderDate], [ShipDate]) AS 'Up�yne�o dni' 
	FROM [SalesLT].[SalesOrderHeader]

/* Zadanie 3 */
SELECT ([Name] + ' kosztuje ' + CAST(ROUND([ListPrice],1) AS VARCHAR(50))) AS 'Co ile kosztuje?' 
	FROM [SalesLT].[Product]