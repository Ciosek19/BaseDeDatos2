
-- DATASET EXTENDIDO PARA EJERCICIOS DE JOINs Y OPERADORES DE CONJUNTO

DROP TABLE IF EXISTS OrderItems, Orders, Products, Categories, Customers, Suppliers, Leads;
GO

-- Clientes
CREATE TABLE Customers (
    CustomerID INT IDENTITY PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- Pedidos
CREATE TABLE Orders (
    OrderID INT IDENTITY PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATE
);

-- Ítems de pedido
CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT
);

-- Categorías
CREATE TABLE Categories (
    CategoryID INT IDENTITY PRIMARY KEY,
    CategoryName VARCHAR(50)
);

-- Proveedores
CREATE TABLE Suppliers (
    SupplierID INT IDENTITY PRIMARY KEY,
    SupplierName VARCHAR(100),
    Email VARCHAR(100)
);

-- Productos
CREATE TABLE Products (
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    UnitPrice DECIMAL(10,2)
);

-- Leads
CREATE TABLE Leads (
    LeadID INT IDENTITY PRIMARY KEY,
    LeadName VARCHAR(100),
    Email VARCHAR(100)
);

-- Insertar Clientes
INSERT INTO Customers (FirstName, LastName, Email) VALUES
('Ana', 'Torres', 'ana@correo.com'),
('Luis', 'Pérez', 'luis@correo.com'),
('María', 'García', 'maria@correo.com'),
('Jorge', 'López', 'jorge@correo.com'),
('Lucía', 'Martínez', 'lucia@correo.com'),
('Ricardo', 'Gómez', 'ricardo@correo.com'),
('Valentina', 'Sosa', 'valen@correo.com'),
('Daniel', 'Silva', 'daniel@correo.com');

-- Insertar Pedidos
INSERT INTO Orders (CustomerID, OrderDate) VALUES
(1, '2024-03-10'), (1, '2024-03-12'),
(2, '2024-03-15'), (3, '2024-03-16'),
(4, '2024-03-18'), (5, '2024-03-20'),
(6, '2024-03-21'), (7, '2024-03-22');

-- Insertar Categorías
INSERT INTO Categories (CategoryName) VALUES
('Tecnología'), ('Ropa'), ('Libros'), ('Accesorios');

-- Insertar Proveedores
INSERT INTO Suppliers (SupplierName, Email) VALUES
('Electronix', 'contacto@electronix.com'),
('BooksWorld', 'ventas@booksworld.com'),
('FashionHub', 'info@fashionhub.com');

-- Insertar Productos
INSERT INTO Products (ProductName, CategoryID, SupplierID, UnitPrice) VALUES
('Mouse Inalámbrico', 1, 1, 20.00),
('Remera Blanca', 2, 3, 15.00),
('Libro de SQL', 3, 2, 30.00),
('Notebook', 1, 1, 500.00),
('Cable HDMI', 4, 1, 10.00),
('Jeans Slim', 2, 3, 35.00),
('Libro de Python', 3, 2, 40.00),
('Tablet', 1, 1, 300.00),
('Auriculares', 4, 1, 25.00);

-- Insertar OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity) VALUES
(1, 1, 2), (1, 2, 1),
(2, 3, 1), (3, 4, 1),
(4, 5, 2), (5, 6, 1),
(6, 7, 1), (7, 8, 1),
(8, 9, 2);

-- Insertar Leads
INSERT INTO Leads (LeadName, Email) VALUES
('Pedro López', 'pedro@correo.com'),
('Luis Pérez', 'luis@correo.com'),
('Valeria Díaz', 'valeria@correo.com'),
('Natalia Ríos', 'natalia@correo.com'),
('Camilo Torres', 'camilo@correo.com'),
('Lucía Martínez', 'lucia@correo.com'),
('Andrés Vidal', 'andres@correo.com');
