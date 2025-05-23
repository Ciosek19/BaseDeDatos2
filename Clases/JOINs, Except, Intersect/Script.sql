
-- SCRIPT DE CREACIÓN DE TABLAS Y DATOS DE PRUEBA PARA EJERCICIOS DE JOINs Y OPERADORES DE CONJUNTO

-- Limpieza previa si las tablas ya existen
DROP TABLE IF EXISTS OrderItems, Orders, Products, Categories, Customers, Suppliers, Leads;
GO

-- Tabla de clientes
CREATE TABLE Customers (
    CustomerID INT IDENTITY PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- Tabla de órdenes
CREATE TABLE Orders (
    OrderID INT IDENTITY PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATE
);

-- Tabla de ítems de orden
CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT
);

-- Tabla de categorías de productos
CREATE TABLE Categories (
    CategoryID INT IDENTITY PRIMARY KEY,
    CategoryName VARCHAR(50)
);

-- Tabla de proveedores
CREATE TABLE Suppliers (
    SupplierID INT IDENTITY PRIMARY KEY,
    SupplierName VARCHAR(100),
    Email VARCHAR(100)
);

-- Tabla de productos
CREATE TABLE Products (
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    UnitPrice DECIMAL(10,2)
);

-- Tabla de leads para campañas de marketing
CREATE TABLE Leads (
    LeadID INT IDENTITY PRIMARY KEY,
    LeadName VARCHAR(100),
    Email VARCHAR(100)
);

-- Insertar clientes
INSERT INTO Customers (FirstName, LastName, Email) VALUES
('Ana', 'Torres', 'ana.torres@example.com'),
('Luis', 'Pérez', 'luis.perez@example.com'),
('Camila', 'Suárez', 'camila.suarez@example.com');

-- Insertar órdenes
INSERT INTO Orders (CustomerID, OrderDate) VALUES
(1, '2024-03-15'),
(1, '2024-03-20'),
(2, '2024-03-18');

-- Insertar categorías
INSERT INTO Categories (CategoryName) VALUES
('Electrónica'), ('Ropa'), ('Libros');

-- Insertar proveedores
INSERT INTO Suppliers (SupplierName, Email) VALUES
('TechCorp', 'contacto@techcorp.com'),
('ReadHouse', 'info@readhouse.com');

-- Insertar productos
INSERT INTO Products (ProductName, CategoryID, SupplierID, UnitPrice) VALUES
('Auriculares', 1, 1, 29.99),
('Camiseta', 2, 1, 15.00),
('Libro SQL', 3, 2, 35.00),
('Teclado', 1, 1, 40.00),
('Mochila', 2, 1, 25.00);

-- Insertar ítems de órdenes (algunos productos sin venta)
INSERT INTO OrderItems (OrderID, ProductID, Quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 4, 1);

-- Insertar leads
INSERT INTO Leads (LeadName, Email) VALUES
('Pedro Gómez', 'pedro.gomez@example.com'),
('Luis Pérez', 'luis.perez@example.com'), -- igual al cliente 2
('Valeria Méndez', 'valeria.mendez@example.com');
