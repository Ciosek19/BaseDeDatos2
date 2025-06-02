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
    FechaRegistro DATE NOT NULL,
	Activo BIT NOT NULL CHECK (Activo IN(0,1)),
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
    Descripcion VARCHAR(MAX) NOT NULL,
    Orden INT NOT NULL,
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
GO

CREATE TABLE Clases (
    ClaseID INT PRIMARY KEY IDENTITY,
    ModuloID INT NOT NULL,
    Titulo VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(MAX) NOT NULL,
	Orden INT NOT NULL,
	Activo BIT CHECK(Activo IN(0,1)) NOT NULL DEFAULT 1 
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
	-- Ver si en esta tabla sacar el curso, ya que la inscripcion es a la plataforma
    InscripcionID INT PRIMARY KEY IDENTITY,
    EstudianteID INT NOT NULL,
    CursoID INT NOT NULL,
    FechaInscripcion DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
GO

CREATE TABLE Progreso (
	-- Se repite información entre el apartado de inscripciones y progreso. Podría optimizarse el texto y clarificar si ambas son necesarias o si se superponen en funcionalidad.
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

