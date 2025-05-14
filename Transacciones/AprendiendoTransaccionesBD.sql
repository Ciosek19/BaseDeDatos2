CREATE DATABASE AprendiendoTransaccionesBD
GO
USE AprendiendoTransaccionesBD
GO

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY,
	FullName NVARCHAR(100),
	City NVARCHAR(50)
);

GO

CREATE TABLE Products(
	ProductID INT PRIMARY KEY,
	ProductName NVARCHAR(100),
	UnitPrice DECIMAL(10,2)
);

GO

CREATE TABLE Sales (
	SaleID INT PRIMARY KEY IDENTITY,
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
	SaleDate DATE
);

GO

CREATE TABLE SalesDetails (
	DetailID INT PRIMARY KEY,
	SaleID INT FOREIGN KEY REFERENCES Sales(SaleID),
	ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
	Quantity INT
);

GO

--INSERT INTO Customers 
--VALUES
--(1,'Rodrigo Ciosek','Maldonado'),
--(2,'Elsa Balero', 'Tegucigualpa');

--INSERT INTO Products
--VALUES
--(1,'Pelota',50),
--(2,'Gorra',120);

SELECT * FROM Products
SELECT * FROM Customers
SELECT * FROM SalesDetails
SELECT * FROM Sales


--BEGIN TRANSACTION
--	BEGIN TRY
--		DECLARE @customerID INT = 1;
--		DECLARE @productID INT = 1;
--		DECLARE @newSaleId INT;

--		INSERT INTO Sales 
--			(CustomerID, SaleDate)
--		VALUES
--			(@customerID,GETDATE())

--		SET @newSaleId = @@IDENTITY;

--		INSERT INTO SalesDetails 
--			(DetailID,SaleID,ProductID,Quantity)
--		VALUES
--			(1,@newSaleId,@productID, 2)

--		COMMIT
--	END TRY
--	BEGIN CATCH
--		ROLLBACK
--	END CATCH


--BEGIN TRANSACTION
--	BEGIN TRY
--		DECLARE @customerName NVARCHAR(100) = 'Rodrigo Ciosek';
--		DECLARE @customerID INT;
--		DECLARE @productID INT = 1;
--		DECLARE @newSaleId INT;
--		DECLARE @quantity INT = 5;

--		SELECT @customerID = CustomerID FROM Customers WHERE FullName = @customerName;

--		INSERT INTO Sales 
--			(CustomerID, SaleDate)
--		VALUES
--			(@customerID,GETDATE())

--		SET @newSaleId = @@IDENTITY;

--		INSERT INTO SalesDetails 
--			(DetailID,SaleID,ProductID,Quantity)
--		VALUES
--			(1,@newSaleId,@productID, @quantity)

--		COMMIT
--	END TRY
--	BEGIN CATCH
--		ROLLBACK
--	END CATCH

BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @customerName NVARCHAR(100) = 'Rodrigo Ciosek';
		DECLARE @customerID INT;
		DECLARE @productID INT = 1;
		DECLARE @newSaleId INT;
		DECLARE @quantity INT = 5;
		DECLARE @newSaleDetailID INT;

		SELECT @customerID = CustomerID FROM Customers WHERE FullName = @customerName;

		INSERT INTO Sales 
			(CustomerID, SaleDate)
		VALUES
			(@customerID,GETDATE())

		SET @newSaleId = @@IDENTITY;
		SELECT @newSaleDetailID = MAX(DetailID)+1 FROM SalesDetails

		INSERT INTO SalesDetails 
			(DetailID,SaleID,ProductID,Quantity)
		VALUES
			(@newSaleDetailID,@newSaleId,@productID, @quantity)

		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH