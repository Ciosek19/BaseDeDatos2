CREATE DATABASE ObligatorioBD2
GO

USE ObligatorioBD2
GO

-- /////// CREACION TABLAS /////// --

CREATE TABLE Docentes (
    DocenteID INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo VARCHAR(50) UNIQUE NOT NULL,
    FechaRegistro DATE NOT NULL
);
GO

CREATE TABLE Cursos (
    CursoID INT PRIMARY KEY IDENTITY,
    DocenteID INT NOT NULL,
    Titulo VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    Duracion INT NOT NULL,
    Estado BIT NOT NULL CHECK (Estado IN(0,1)),
    NotaMinima DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (DocenteID) REFERENCES Docentes(DocenteID)
);
GO

CREATE TABLE Modulos (
    ModuloID INT PRIMARY KEY IDENTITY,
    CursoID INT NOT NULL,
    Titulo VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    Orden INT NOT NULL,
    NotaMaxima DECIMAL(5,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
GO

CREATE TABLE Clases (
    ClaseID INT PRIMARY KEY IDENTITY,
    ModuloID INT NOT NULL,
    Titulo VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    FOREIGN KEY (ModuloID) REFERENCES Modulos(ModuloID)
);
GO

CREATE TABLE Estudiantes (
    EstudianteID INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo VARCHAR(50) UNIQUE NOT NULL,
    FechaRegistro DATE NOT NULL DEFAULT GETDATE(),
    Activo BIT CHECK(Activo IN(0,1)) NOT NULL DEFAULT 1
);
GO

CREATE TABLE EstudiantesCursos (
    CursoID INT NOT NULL,
    EstudianteID INT NOT NULL,
    PRIMARY KEY (CursoID, EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID)
);
GO

CREATE TABLE EstudiantesModulos (
    ModuloID INT NOT NULL,
    EstudianteID INT NOT NULL,
    NotaExamen DECIMAL(5,2),
    PRIMARY KEY (ModuloID, EstudianteID),
    FOREIGN KEY (ModuloID) REFERENCES Modulos(ModuloID),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID)
);
GO

CREATE TABLE EstudiantesClases (
    ClaseID INT NOT NULL,
    EstudianteID INT NOT NULL,
    Visto BIT CHECK(Visto IN(0,1)) NOT NULL,
    PRIMARY KEY (ClaseID, EstudianteID),
    FOREIGN KEY (ClaseID) REFERENCES Clases(ClaseID),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID)
);
GO

CREATE TABLE Inscripcion (
    InscripcionID INT PRIMARY KEY IDENTITY,
    EstudianteID INT NOT NULL,
    CursoID INT NOT NULL,
    FechaInscripcion DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
GO

CREATE TABLE Progreso (
    ProgresoID INT PRIMARY KEY IDENTITY,
    EstudianteID INT NOT NULL,
    CursoID INT NOT NULL,
    PorcentajeAvance DECIMAL(5,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
GO

CREATE TABLE Calificacion (
    CalificacionID INT PRIMARY KEY IDENTITY,
    EstudianteID INT NOT NULL,
    CursoID INT NOT NULL,
    Nota DECIMAL(5,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
GO

CREATE TABLE Certificacion (
    CertificacionID INT PRIMARY KEY IDENTITY,
    EstudianteID INT NOT NULL,
    CursoID INT NOT NULL,
    FechaEmision DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
GO

-- /////// CREACION DE DATOS /////// --

-- Docentes
INSERT INTO Docentes (Nombre, Apellido, Correo, FechaRegistro) VALUES
('María', 'González', 'maria.gonzalez@edu.com', '2024-01-01'),
('José', 'Fernández', 'jose.fernandez@edu.com', '2024-01-02');
GO

-- Cursos
INSERT INTO Cursos (DocenteID, Titulo, Descripcion, Duracion, Estado, NotaMinima) VALUES
(1, 'Curso de Matemáticas Básicas', 'Curso introductorio a las matemáticas', 60, 1, 70.00),
(2, 'Curso de Física General', 'Curso básico de física aplicada', 60, 1, 70.00);
GO

-- Modulos
INSERT INTO Modulos (CursoID, Titulo, Descripcion, Orden) VALUES
-- Curso Matemáticas Básicas
(1, 'Álgebra Básica', 'Fundamentos del álgebra', 1),
(1, 'Geometría', 'Estudio de las figuras geométricas', 2),
(1, 'Trigonometría', 'Introducción a las funciones trigonométricas', 3),
-- Curso Física General
(2, 'Cinemática', 'Estudio del movimiento', 1),
(2, 'Dinámica', 'Fuerzas y movimiento', 2),
(2, 'Termodinámica', 'Estudio del calor y energía', 3);
GO

-- Clases
INSERT INTO Clases (ModuloID, Titulo, Descripcion) VALUES
-- Curso Matemáticas Básicas: Módulos 1-3
(1, 'Clase 1.1: Introducción al Álgebra', 'Conceptos básicos de álgebra'),
(1, 'Clase 1.2: Ecuaciones Lineales', 'Resolución de ecuaciones lineales'),
(1, 'Clase 1.3: Sistema de Ecuaciones', 'Métodos para resolver sistemas de ecuaciones'),
(2, 'Clase 2.1: Figuras Geométricas', 'Introducción a la geometría'),
(2, 'Clase 2.2: Áreas y Volúmenes', 'Cálculo de áreas y volúmenes'),
(2, 'Clase 2.3: Teorema de Pitágoras', 'Aplicaciones del teorema de Pitágoras'),
(3, 'Clase 3.1: Funciones Trigonométricas', 'Estudio de las funciones seno, coseno y tangente'),
(3, 'Clase 3.2: Identidades Trigonométricas', 'Identidades y ecuaciones trigonométricas'),
(3, 'Clase 3.3: Aplicaciones de la Trigonometría', 'Uso de la trigonometría'),
-- Curso Física General: Módulos 4-6
(4, 'Clase 4.1: Movimiento Rectilíneo', 'Estudio del movimiento rectilíneo'),
(4, 'Clase 4.2: Leyes de Newton', 'Introducción a las leyes de Newton'),
(4, 'Clase 4.3: Velocidad y Aceleración', 'Cálculo de velocidad y aceleración'),
(5, 'Clase 5.1: Ley de la Gravedad', 'Gravedad y fuerzas de atracción'),
(5, 'Clase 5.2: Fuerzas de Fricción', 'Fuerzas que afectan el movimiento'),
(5, 'Clase 5.3: Trabajo y Energía', 'Conceptos de trabajo y energía'),
(6, 'Clase 6.1: Leyes de la Termodinámica', 'Introducción a las leyes de la termodinámica'),
(6, 'Clase 6.2: Ciclo Termodinámico', 'Estudio de los ciclos termodinámicos'),
(6, 'Clase 6.3: Transferencia de Calor', 'Mecanismos de transferencia de calor');
GO

-- Estudiantes
INSERT INTO Estudiantes (Nombre, Apellido, Correo) VALUES
('Juan', 'Pérez', 'juan.perez@example.com'),
('Ana', 'López', 'ana.lopez@example.com'),
('Carlos', 'Martínez', 'carlos.martinez@example.com');
GO

-- EstudiantesCursos
INSERT INTO EstudiantesCursos (CursoID, EstudianteID) VALUES
(1, 1), (1, 2), (2, 3);
GO

-- EstudiantesModulos
INSERT INTO EstudiantesModulos (ModuloID, EstudianteID, NotaExamen) VALUES
-- Estudiante 1 (Aprobó el curso)
(1, 1, 85.00), (2, 1, 80.00), (3, 1, 90.00),
(4, 1, 95.00), (5, 1, 85.00), (6, 1, 90.00),
-- Estudiante 2 (En proceso, no terminó todos los módulos)
(1, 2, 65.00), (2, 2, 70.00), (3, 2, 75.00), -- Solo completó 3 módulos
-- Estudiante 3 (No aprobó el curso)
(1, 3, 50.00), (2, 3, 60.00), (3, 3, 55.00),
(4, 3, 45.00), (5, 3, 50.00), (6, 3, 40.00);
GO

-- EstudiantesClases
INSERT INTO EstudiantesClases (ClaseID, EstudianteID, Visto) VALUES
-- Estudiante 1 (Aprobó el curso)
(1, 1, 1), (2, 1, 1), (3, 1, 1), (4, 1, 1), (5, 1, 1), (6, 1, 1), 
(7, 1, 1), (8, 1, 1), (9, 1, 1), (10, 1, 1), (11, 1, 1), (12, 1, 1), 
(13, 1, 1), (14, 1, 1), (15, 1, 1),
-- Estudiante 2 (En proceso, no terminó todos los módulos)
(1, 2, 1), (2, 2, 1), (3, 2, 1), (4, 2, 1), (5, 2, 1), (6, 2, 1), 
(7, 2, 0), (8, 2, 0), (9, 2, 0), -- No completó el resto de clases
(10, 2, 0), (11, 2, 0), (12, 2, 0), 
(13, 2, 0), (14, 2, 0), (15, 2, 0),
-- Estudiante 3 (No aprobó el curso)
(1, 3, 1), (2, 3, 1), (3, 3, 1), (4, 3, 1), (5, 3, 1), (6, 3, 1),
(7, 3, 1), (8, 3, 1), (9, 3, 1), (10, 3, 1), (11, 3, 1), (12, 3, 1),
(13, 3, 1), (14, 3, 1), (15, 3, 1);
GO

-- Inscripcion
INSERT INTO Inscripcion (EstudianteID, CursoID, FechaInscripcion) VALUES
(1, 1, '2024-02-01'),
(2, 1, '2024-02-02'),
(3, 2, '2024-02-03');
GO

-- Progreso
INSERT INTO Progreso (EstudianteID, CursoID, PorcentajeAvance) VALUES
(1, 1, 100.00), -- Estudiante 1: Aprobó
(2, 1, 50.00), -- Estudiante 2: En proceso (no completó todos los módulos)
(3, 2, 40.00); -- Estudiante 3: No aprobó
GO

-- Calificacion
-- Estudiante 2 no tiene calificación porque no completó todos los módulos
INSERT INTO Calificacion (EstudianteID, CursoID, Nota) VALUES
(1, 1, (85 + 80 + 90 + 95 + 85 + 90) / 6.0),  -- Aprobado
(3, 2, (50 + 60 + 55 + 45 + 50 + 40) / 6.0);  -- No aprobado
GO


-- Certificacion
INSERT INTO Certificacion (EstudianteID, CursoID, FechaEmision) VALUES
(1, 1, '2024-03-01');  -- Certificación entregada solo al estudiante 1
GO
