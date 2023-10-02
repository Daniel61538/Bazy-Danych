/* Zadanie 1 */
SELECT [OrderDate] AS 'Data zam�wienia', [CustomerID] AS 'ID klienta', MAX([Freight]) AS 'Najwy�sza oplata za przesylke' 
	FROM [SalesLT].[SalesOrderHeader]
	GROUP BY [OrderDate], [CustomerID]

/* Zadanie 2 */
SELECT [Product].[Name] AS 'Nazwa produktu', COUNT([SalesOrderDetail].[ProductID]) AS 'Liczba sprzeda�y' 
	FROM [SalesLT].[Product] 
	JOIN [SalesLT].[SalesOrderDetail] ON [Product].[ProductID]=[SalesOrderDetail].[ProductID]
	GROUP BY [Product].[Name] 
	HAVING COUNT([Product].[Name])>3

/* Zadanie 3 */
CREATE TABLE ##Sprzedaz 
	(
	[ID klienta] INT NOT NULL,
	Miesi�c INT NOT NULL,
	Warto�� MONEY NOT NULL
	);
GO

INSERT INTO ##Sprzedaz
	SELECT [CustomerID], DATEPART(MONTH, [OrderDate]), [TotalDue]
	FROM [SalesLT].[SalesOrderHeader];
GO

/* Co� nie dzia�a�o z lokaln� tabel� tymczasow� wi�c stworzy�em globaln� */

SELECT * FROM ##Sprzedaz
	PIVOT (SUM(Warto��) FOR [Miesi�c] IN([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) AS pivocik
