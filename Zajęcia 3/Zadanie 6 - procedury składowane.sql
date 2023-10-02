DROP PROCEDURE IF EXISTS [Production].[dodaj_produkty]
GO
CREATE PROCEDURE [Production].[dodaj_produkty] 
	@productname AS varchar(255),
	@supplierid AS int,
	@categoryid AS int,
	@unitprice AS money = 0,
	@discontinued AS bit = 0
AS
BEGIN
	DECLARE @blad varchar(255);
	BEGIN TRY
    IF NOT EXISTS(SELECT 1 FROM Production.Suppliers 
		WHERE supplierid = @supplierid)
		BEGIN
			SET @blad = 'Podane Supplierid o warto�ci (' 
				+ CAST(@supplierid AS varchar(255)) + ') nie istnieje';
        THROW 50000, @blad, 0;
    END
    IF NOT EXISTS(SELECT 1 FROM Production.Categories 
		WHERE categoryid = @categoryid)
		BEGIN
			SET @blad = 'Podane Categoryid o warto�ci (' 
				+ CAST(@categoryid AS varchar(255)) + ') nie istnieje';
        THROW 50000, @blad, 0;
    END;
    IF NOT(@unitprice >= 0) 
		BEGIN
			SET @blad = 'Unitprice o warto�ci (' 
				+ CAST(@unitprice AS varchar(255)) + ') jest niepoprawne. Musi by� wi�ksze b�d� r�wne 0.';
        THROW 50000, @blad, 0;
    END;
	IF EXISTS(SELECT 1 FROM Production.Products 
		WHERE productname = @productname)
		BEGIN
			SET @blad = 'Podane productname o warto�ci "' 
				+ @productname + '" ju� istnieje, prosz� podda� inne';
		THROW 50000, @blad, 0;
	END;
	INSERT INTO Production.Products (productname, supplierid, categoryid, unitprice, discontinued)
	VALUES (@productname,@supplierid,@categoryid,@unitprice,@discontinued)
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH;
END;
GO
EXEC Production.dodaj_produkty 
@productname = 'Test Product'
, @supplierid = 10
, @categoryid = 1
, @unitprice = -100
, @discontinued = 0;