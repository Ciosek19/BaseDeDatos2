-----------------------------------------
-- 1. Crear la base de datos 
-----------------------------------------
IF DB_ID('BDPracticas') IS NULL
BEGIN
    CREATE DATABASE BDPracticas;
END
GO

USE BDPracticas;
GO

-----------------------------------------
-- 2. Crear tabla: Departamentos
-----------------------------------------
IF OBJECT_ID('Departamentos', 'U') IS NOT NULL
    DROP TABLE Departamentos;
GO

CREATE TABLE Departamentos (
    DepartamentoID INT PRIMARY KEY,
    NombreDepto    VARCHAR(50) NOT NULL
);

INSERT INTO Departamentos (DepartamentoID, NombreDepto)
VALUES 
    (10, 'Ventas'),
    (20, 'Marketing'),
    (30, 'Finanzas');

-----------------------------------------
-- 3. Crear tabla: Empleados
-----------------------------------------
IF OBJECT_ID('Empleados', 'U') IS NOT NULL
    DROP TABLE Empleados;
GO

CREATE TABLE Empleados (
    EmpleadoID      INT PRIMARY KEY,
    Nombre          VARCHAR(50) NOT NULL,
    Salario         DECIMAL(10,2) NOT NULL,
    DepartamentoID  INT NOT NULL,
    EsJefe          BIT NOT NULL DEFAULT 0
    -- Podrías agregar más columnas si quieres
);

ALTER TABLE Empleados
ADD CONSTRAINT FK_Empleados_Departamentos
    FOREIGN KEY (DepartamentoID)
    REFERENCES Departamentos (DepartamentoID);

INSERT INTO Empleados (EmpleadoID, Nombre, Salario, DepartamentoID, EsJefe)
VALUES
    (1,  'Ana',       2000.00, 10, 0),
    (2,  'Carlos',    2500.00, 10, 1),
    (3,  'Fernanda',  1800.00, 20, 1),
    (4,  'Pedro',     3000.00, 20, 0),
    (5,  'Lucía',     2200.00, 10, 0),
    (6,  'Luis',      2700.00, 20, 1),  -- otro jefe en dpto 20
    (7,  'Sofía',     1500.00, 30, 0),
    (8,  'Miguel',    1800.00, 30, 1),
    (9,  'Isabel',    2700.00, 10, 0),
    (10, 'Raúl',      2100.00, 20, 0);

-----------------------------------------
-- 4. Crear tabla: Productos
-----------------------------------------
IF OBJECT_ID('Productos', 'U') IS NOT NULL
    DROP TABLE Productos;
GO

CREATE TABLE Productos (
    ProductoID     INT PRIMARY KEY,
    NombreProducto VARCHAR(50) NOT NULL,
    CategoriaID    INT NOT NULL,
    Precio         DECIMAL(10,2) NOT NULL
    -- Podrías agregar más columnas si quieres
);

-- Para simplificar, no creamos tabla de Categorias. Usamos CategoriaID = 1, 2
INSERT INTO Productos (ProductoID, NombreProducto, CategoriaID, Precio)
VALUES
    (1, 'Laptop',      1,  1200.00),
    (2, 'Smartphone',  1,   800.00),
    (3, 'Impresora',   1,   200.00),
    (4, 'Mesa',        2,   150.00),
    (5, 'Silla',       2,    80.00),
    (6, 'Monitor',     1,   300.00);

-----------------------------------------
-- 5. Crear tabla: Ventas
-----------------------------------------
IF OBJECT_ID('Ventas', 'U') IS NOT NULL
    DROP TABLE Ventas;
GO

CREATE TABLE Ventas (
    VentaID        INT PRIMARY KEY,
    EmpleadoID     INT NOT NULL,
    ProductoID     INT NOT NULL,
    Cantidad       INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    FechaVenta     DATE NOT NULL
);

ALTER TABLE Ventas
ADD CONSTRAINT FK_Ventas_Empleados
    FOREIGN KEY (EmpleadoID)
    REFERENCES Empleados (EmpleadoID);

ALTER TABLE Ventas
ADD CONSTRAINT FK_Ventas_Productos
    FOREIGN KEY (ProductoID)
    REFERENCES Productos (ProductoID);

INSERT INTO Ventas (VentaID, EmpleadoID, ProductoID, Cantidad, PrecioUnitario, FechaVenta)
VALUES
    (1,  1,  1,  2,   1200.00, '2023-01-10'), -- Ana vendió 2 Laptops
    (2,  2,  2,  1,    800.00, '2023-01-11'), -- Carlos vendió 1 Smartphone
    (3,  2,  3,  2,    200.00, '2023-01-11'), -- Carlos vendió 2 Impresoras
    (4,  3,  1,  1,   1200.00, '2023-02-05'), -- Fernanda vendió 1 Laptop
    (5,  3,  4,  2,    150.00, '2023-02-15'), -- Fernanda vendió 2 Mesas
    (6,  4,  2,  3,    800.00, '2023-03-01'), -- Pedro vendió 3 Smartphones
    (7,  5,  6,  4,    300.00, '2023-03-10'), -- Lucía vendió 4 Monitores
    (8,  5,  5,  6,     80.00, '2023-03-11'), -- Lucía vendió 6 Sillas
    (9,  9,  1,  1,   1200.00, '2023-04-01'), -- Isabel vendió 1 Laptop
    (10, 6,  1,  1,   1200.00, '2023-04-02'), -- Luis vendió 1 Laptop
    (11, 8,  2,  2,    800.00, '2023-05-01'), -- Miguel vendió 2 Smartphones
    (12, 10, 3,  1,    200.00, '2023-05-02'), -- Raúl vendió 1 Impresora
    (13, 2,  6,  2,    300.00, '2023-05-03'), -- Carlos vendió 2 Monitores
    (14, 9,  6,  3,    300.00, '2023-05-03'), -- Isabel vendió 3 Monitores
    (15, 1,  2,  1,    800.00, '2023-05-05'); -- Ana vendió 1 Smartphone

-- Script finalizado
SELECT 'Script de creación e inserción completado.' AS Mensaje;
