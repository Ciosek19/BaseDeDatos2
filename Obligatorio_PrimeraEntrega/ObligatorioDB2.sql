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
    FechaRegistro DATE NOT NULL DEFAULT GETDATE(),
	Activo BIT NOT NULL CHECK (Activo IN(0,1)) DEFAULT 1,
);
GO

CREATE TABLE Cursos (
    CursoID INT PRIMARY KEY IDENTITY,
    DocenteID INT NOT NULL,
    Titulo VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(MAX) NOT NULL,
    Duracion INT NOT NULL,
    NotaMinima DECIMAL(5,2) NOT NULL,
    Activo BIT NOT NULL CHECK (Activo IN(0,1)) DEFAULT 1,
    FOREIGN KEY (DocenteID) REFERENCES Docentes(DocenteID)
);
GO

CREATE TABLE Modulos (
    ModuloID INT PRIMARY KEY IDENTITY,
    CursoID INT NOT NULL,
    Titulo VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(MAX) NOT NULL,
    Orden INT NOT NULL,
	Activo BIT NOT NULL CHECK (Activo IN(0,1)) DEFAULT 1,
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
GO

CREATE TABLE Clases (
    ClaseID INT PRIMARY KEY IDENTITY,
    ModuloID INT NOT NULL,
    Titulo VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(MAX) NOT NULL,
	Orden INT NOT NULL,
    Activo BIT NOT NULL CHECK (Activo IN(0,1)) DEFAULT 1,
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
    Visto BIT CHECK(Visto IN(0,1)) NOT NULL DEFAULT 0,
    PRIMARY KEY (ClaseID, EstudianteID),
    FOREIGN KEY (ClaseID) REFERENCES Clases(ClaseID),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID)
);
GO

ALTER TABLE Inscripcion (
    InscripcionID INT PRIMARY KEY IDENTITY,
    EstudianteID INT NOT NULL,
    CursoID INT NOT NULL,
    FechaInscripcion DATE NOT NULL DEFAULT GETDATE(),
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

CREATE TABLE AuditoriaDocentes(
OperacionID INT PRIMARY KEY IDENTITY,
Operacion VARCHAR(50) NOT NULL,
Usuario VARCHAR(50) NOT NULL,
Fecha DATE NOT NULL,
DatosRelevantes VARCHAR(255) 
);
GO

CREATE TABLE AuditoriaModulos(
OperacionID INT PRIMARY KEY IDENTITY,
Operacion VARCHAR(50) NOT NULL,
Usuario VARCHAR(50) NOT NULL,
Fecha DATE NOT NULL,
DatosRelevantes VARCHAR(255)
);
GO
CREATE TABLE AuditoriaEstudiantes(
OperacionID INT PRIMARY KEY IDENTITY,
Operacion VARCHAR(50) NOT NULL,
Usuario VARCHAR(50) NOT NULL,
Fecha DATE NOT NULL,
DatosRelevantes VARCHAR(255)
);
GO
CREATE TABLE AuditoriaEstudiantesClases(
OperacionID INT PRIMARY KEY IDENTITY,
Operacion VARCHAR(50) NOT NULL,
Usuario VARCHAR(50) NOT NULL,
Fecha DATE NOT NULL,
DatosRelevantes VARCHAR(255)
);
GO
CREATE TABLE AuditoriaCalificaciones(
OperacionID INT PRIMARY KEY IDENTITY,
Operacion VARCHAR(50) NOT NULL,
Usuario VARCHAR(50) NOT NULL,
Fecha DATE NOT NULL,
DatosRelevantes VARCHAR(255)
);
GO
 --/////// CREACION DE DATOS /////// --

---- DOCENTES
--INSERT INTO Docentes (Nombre, Apellido, Correo, FechaRegistro, Activo) VALUES
--('María', 'González', 'maria.gonzalez@edu.com', '2024-01-01', 1),
--('José', 'Fernández', 'jose.fernandez@edu.com', '2024-01-02', 1);

---- CURSOS
--INSERT INTO Cursos (DocenteID, Titulo, Descripcion, Duracion, Activo, NotaMinima) VALUES
--(1, 'Curso de Matemáticas Básicas', 'Curso introductorio a las matemáticas', 60, 1, 70.00),
--(2, 'Curso de Física General', 'Curso básico de física aplicada', 60, 1, 70.00);

---- MODULOS
--INSERT INTO Modulos (CursoID, Titulo, Descripcion, Orden) VALUES
--(1, 'Álgebra Básica', 'Fundamentos del álgebra', 1),
--(1, 'Geometría', 'Estudio de las figuras geométricas', 2),
--(1, 'Trigonometría', 'Introducción a las funciones trigonométricas', 3),
--(2, 'Cinemática', 'Estudio del movimiento', 1),
--(2, 'Dinámica', 'Fuerzas y movimiento', 2),
--(2, 'Termodinámica', 'Estudio del calor y energía', 3);

--INSERT INTO Clases (ModuloID, Titulo, Descripcion, Orden, Activo) VALUES
--(1,'Clase 1.1: Introducción al Álgebra','Conceptos básicos de álgebra',1,1),
--(1,'Clase 1.2: Ecuaciones Lineales','Resolución de ecuaciones lineales',2,1),
--(1,'Clase 1.3: Sistema de Ecuaciones','Métodos para resolver sistemas',3,1),
--(2,'Clase 2.1: Figuras Geométricas','Introducción a la geometría',1,1),
--(2,'Clase 2.2: Áreas y Volúmenes','Cálculo de áreas y volúmenes',2,1),
--(2,'Clase 2.3: Teorema de Pitágoras','Aplicaciones del teorema de Pitágoras',3,1),
--(3,'Clase 3.1: Funciones Trigonométricas','Estudio de seno, coseno y tangente',1,1),
--(3,'Clase 3.2: Identidades Trigonométricas','Identidades y ecuaciones',2,1),
--(3,'Clase 3.3: Aplicaciones de la Trigonometría','Usos de la trigonometría',3,1),
--(4,'Clase 4.1: Movimiento Rectilíneo','Estudio del movimiento rectilíneo',1,1),
--(4,'Clase 4.2: Leyes de Newton','Introducción a las leyes de Newton',2,1),
--(4,'Clase 4.3: Velocidad y Aceleración','Cálculo de velocidad y aceleración',3,1),
--(5,'Clase 5.1: Ley de la Gravedad','Gravedad y fuerzas de atracción',1,1),
--(5,'Clase 5.2: Fuerzas de Fricción','Fuerzas que afectan el movimiento',2,1),
--(5,'Clase 5.3: Trabajo y Energía','Conceptos de trabajo y energía',3,1),
--(6,'Clase 6.1: Leyes de la Termodinámica','Introducción a la termodinámica',1,1),
--(6,'Clase 6.2: Ciclo Termodinámico','Estudio de los ciclos termodinámicos',2,1),
--(6,'Clase 6.3: Transferencia de Calor','Mecanismos de transferencia de calor',3,1);

---- ESTUDIANTES
--INSERT INTO Estudiantes (Nombre, Apellido, Correo) VALUES
--('Juan', 'Pérez', 'juan.perez@example.com'),
--('Ana', 'López', 'ana.lopez@example.com'),
--('Carlos', 'Martínez', 'carlos.martinez@example.com');

---- ESTUDIANTESMODULOS
--INSERT INTO EstudiantesModulos (ModuloID, EstudianteID, NotaExamen) VALUES
--(1, 1, 85.00), (2, 1, 80.00), (3, 1, 90.00),
--(4, 1, 95.00), (5, 1, 85.00), (6, 1, 90.00),
--(1, 2, 65.00), (2, 2, 70.00), (3, 2, 75.00),
--(1, 3, 50.00), (2, 3, 60.00), (3, 3, 55.00),
--(4, 3, 45.00), (5, 3, 50.00), (6, 3, 40.00);

---- ESTUDIANTESCLASES
--INSERT INTO EstudiantesClases (ClaseID, EstudianteID, Visto) VALUES
---- Estudiante 1
--(1, 1, 1), (2, 1, 1), (3, 1, 1), (4, 1, 1), (5, 1, 1), (6, 1, 1),
--(7, 1, 1), (8, 1, 1), (9, 1, 1), (10, 1, 1), (11, 1, 1), (12, 1, 1),
--(13, 1, 1), (14, 1, 1), (15, 1, 1), (16, 1, 1), (17, 1, 1), (18, 1, 1),
---- Estudiante 2
--(1, 2, 1), (2, 2, 1), (3, 2, 1), (4, 2, 1), (5, 2, 1), (6, 2, 1),
--(7, 2, 0), (8, 2, 0), (9, 2, 0), (10, 2, 0), (11, 2, 0), (12, 2, 0),
--(13, 2, 0), (14, 2, 0), (15, 2, 0), (16, 2, 0), (17, 2, 0), (18, 2, 0),
---- Estudiante 3
--(1, 3, 1), (2, 3, 1), (3, 3, 1), (4, 3, 1), (5, 3, 1), (6, 3, 1),
--(7, 3, 1), (8, 3, 1), (9, 3, 1), (10, 3, 1), (11, 3, 1), (12, 3, 1),
--(13, 3, 1), (14, 3, 1), (15, 3, 1), (16, 3, 1), (17, 3, 1), (18, 3, 1);

---- INSCRIPCION
--INSERT INTO Inscripcion (EstudianteID, CursoID, FechaInscripcion) VALUES
--(1, 1, '2024-02-01'),
--(2, 1, '2024-02-02'),
--(3, 2, '2024-02-03');

---- PROGRESO
--INSERT INTO Progreso (EstudianteID, CursoID, PorcentajeAvance) VALUES
--(1, 1, 100.00),
--(2, 1, 50.00),
--(3, 2, 40.00);

---- CALIFICACION
--INSERT INTO Calificacion (EstudianteID, CursoID, Nota) VALUES
--(1, 1, 87.5),
--(3, 2, 50.0);

---- CERTIFICACION
--INSERT INTO Certificacion (EstudianteID, CursoID, FechaEmision) VALUES
--(1, 1, '2024-03-01');
-----------------------------------------------------------------------------------------

--  Stored Procedure para nuevo alumno

CREATE PROCEDURE NuevoAlumno @nombre varchar(50), @apellido varchar(50),@correo varchar(50) 
AS
BEGIN 
	BEGIN TRANSACTION 
		BEGIN TRY

		IF exists (SELECT 1 FROM Estudiantes WHERE Correo = TRIM(@correo))
			THROW 50001, 'Usuario ya existente',1

		INSERT INTO Estudiantes(Nombre,Apellido,Correo,FechaRegistro,Activo)
		VALUES (TRIM(@nombre),TRIM(@apellido),TRIM(@correo),GETDATE(),1)

		COMMIT;
		END TRY

		BEGIN CATCH
		ROLLBACK;
		PRINT 'ERROR :' + Error_Message()

		END CATCH
END

-- Ejecucion Stored Procedure

DECLARE @nombreNuevo varchar(50)='Ramiro';
DECLARE @apellidoNuevo varchar(50)= 'Alonso'
DECLARE @correoNuevo varchar(50) = 'ramrio.alonso@example.com'

EXEC NuevoAlumno @nombre= @nombreNuevo, @apellido= @apellidoNuevo, @correo= @correoNuevo;
SELECT * FROM Estudiantes


--  Stored Procedure para nueva inscripcion

CREATE PROCEDURE InscripcionCurso @estudianteID int, @cursoID int
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY

		IF not exists (SELECT 1 FROM Cursos WHERE CursoID = @cursoID)
			THROW 50001, 'El curso ingresado no existe',1

		IF not exists (SELECT 1 FROM Estudiantes WHERE EstudianteID = @estudianteID)
			THROW 50002, 'El estudiante ingresado no existe',1


		IF exists (SELECT 1 FROM Inscripcion WHERE EstudianteID =@estudianteID AND CursoID =@cursoID)
			THROW 50003, 'Este estudiante ya se encuentra inscripto en el curso',1

		INSERT INTO Inscripcion(EstudianteID,CursoID,FechaInscripcion)
		VALUES(@estudianteID,@cursoID,GETDATE())

		COMMIT;
	END TRY

	BEGIN CATCH
		ROLLBACK;
		PRINT 'ERROR :' + ERROR_MESSAGE()
	END CATCH
END


-- Ejecucion Stored Procedure

DECLARE @estudianteIDNuevo int = 1
DECLARE @cursoIDNuevo int = 2

EXEC InscripcionCurso 
@estudianteID= @estudianteIDNuevo,
@cursoID= @cursoIDNuevo

SELECT * FROM Inscripcion
SELEcT * FROM Cursos

--  Stored Procedure para nueva certificacion

CREATE PROCEDURE GenerarCertificacion @estudianteID int, @cursoID int 
AS
BEGIN 
	BEGIN TRANSACTION
		BEGIN TRY
		IF not exists (SELECT 1 FROM Cursos WHERE CursoID = @cursoID)
			THROW 50001, 'El curso ingresado no existe',1

		IF not exists (SELECT 1 FROM Estudiantes WHERE EstudianteID = @estudianteID)
			THROW 50002, 'El estudiante ingresado no existe',1

		IF exists(SELECT 1 FROM Certificacion WHERE  EstudianteID = @estudianteID AND CursoID = @cursoID)
			THROW 50003,'La certificacion ya existe',1

		IF not exists(SELECT 1 FROM Calificacion WHERE  EstudianteID = @estudianteID AND CursoID = @cursoID)
			THROW 50004, ' Este estudiante no tiene calificaciones',1

		DECLARE @notaAlumno int
		SELECT @notaAlumno = Nota FROM Calificacion WHERE EstudianteID = @estudianteID AND CursoID = @cursoID

		DECLARE @minimaCurso int
		SELECT @minimaCurso = NotaMinima FROM Cursos WHERE CursoID = @cursoID

		IF( @notaAlumno >= @minimaCurso)
			BEGIN

			INSERT INTO Certificacion(EstudianteID,CursoID,FechaEmision)
			VALUES(@estudianteID,@cursoID,GETDATE())

			END 
		COMMIT;

		END TRY
		BEGIN CATCH
		ROLLBACK
		PRINT 'ERROR: ' + ERROR_MESSAGE()
		END CATCH
END

-- Ejecucion Stored Procedure

DECLARE @estudianteIDNuevo int = 1
DECLARE @cursoIDNuevo int = 1

EXEC GenerarCertificacion @estudianteID= @estudianteIDNuevo, @cursoID= @cursoIDNuevo


-- Stored Procedure para nuevo docente
CREATE PROCEDURE NuevoDocente 
@nombre NVARCHAR(50),
@apellido NVARCHAR(50),
@correo NVARCHAR(50)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM Docentes WHERE Correo = TRIM(@correo))
			THROW 50001, 'Este correo ya fue registrado',1;
		INSERT INTO Docentes (Nombre,Apellido,Correo)
		VALUES (TRIM(@nombre), TRIM(@apellido), TRIM(@correo))
		COMMIT;
	END TRY
	BEGIN CATCH
		PRINT 'ERROR: ' + ERROR_MESSAGE()
		ROLLBACK;
	END CATCH
END
-- Ejecucion
DECLARE @nombreDocente VARCHAR(50)= 'Jose';
DECLARE @apellidoDocente VARCHAR(50) = 'Lopez';
DECLARE @correoDocente VARCHAR(50) = 'Joselopez@correo.com'

EXEC NuevoDocente 
@nombre = @nombreDocente, 
@apellido = @apellidoDocente, 
@correo = @correoDocente;

SELECT * FROM Docentes


-- Stored Procedure crear curso asociado a un docente
CREATE PROCEDURE CrearCurso
@docenteId INT,
@titulo VARCHAR(50),
@descripcion VARCHAR(MAX),
@duracion INT,
@notaMinima DECIMAL(5,2)
AS 
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM Docentes WHERE DocenteID = @docenteId)
			THROW 50001, 'El docente no existe',1;
		INSERT INTO Cursos (DocenteID,Titulo,Descripcion,Duracion,NotaMinima)
		VALUES (@docenteId,@titulo,@descripcion,@duracion,@notaMinima)
		COMMIT;
	END TRY
	BEGIN CATCH
		PRINT 'ERROR: ' + ERROR_MESSAGE()
		ROLLBACK
	END CATCH
END

-- Ejecucion
DECLARE @docenteIdRef INT = 1;
DECLARE @tituloCurso VARCHAR(50) = 'Titulo Ejemplo';
DECLARE @descripcionCurso VARCHAR(MAX) = 'Descripcion ejemplo';
DECLARE @duracionCurso INT = 65;
DECLARE @notaMinimaCurso DECIMAL(5,2) = 75;

EXEC CrearCurso 
@docenteId = @docenteIdRef, 
@titulo = @tituloCurso, 
@descripcion = @descripcionCurso, 
@duracion = @duracionCurso, 
@notaMinima = @notaMinimaCurso

SELECT * FROM Cursos

-- Stored Procedure para actualizar la calificacion final de un estudiante
--	para un curso tomando en cuenta los puntos de modulos/clases y la nota
--	minima para aprobar

CREATE PROCEDURE ActualizarCalificacionEstudiante
@estudianteID INT,
@cursoID INT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM Estudiantes WHERE EstudianteID = @estudianteID)
			THROW 50001, 'El estudiante no existe',1;
		IF NOT EXISTS (SELECT 1 FROM Cursos WHERE CursoID = @cursoID)
			THROW 50002, 'El curso no existe',1;
		IF NOT EXISTS (SELECT 1 FROM Inscripcion WHERE EstudianteID = @estudianteID AND CursoID = @cursoID)
			THROW 50003, 'El estudiante no se ha inscrito en ese curso',1;
		IF EXISTS (SELECT 1 FROM dbo.fnExamenesPendientesTabla(@estudianteID,@cursoID))
			THROW 50004, 'El estudiante no ha completado el curso',1;
		UPDATE Calificacion 
		SET Nota = dbo.fnCalificacionEstudianteCurso(@estudianteID,@cursoID)
		WHERE CursoID = @cursoID AND EstudianteID = @estudianteID
		COMMIT;
	END TRY
	BEGIN CATCH
		PRINT 'ERROR: ' + ERROR_MESSAGE()
		ROLLBACK
	END CATCH
END

-- Ejecucion
DECLARE @estudianteIdPrueba INT = 1;
DECLARE @cursoIdPrueba INT = 1;
EXEC ActualizarCalificacionEstudiante 
@estudianteID = @estudianteIdPrueba,
@cursoID = @cursoIdPrueba
SELECT * FROM Calificacion WHERE EstudianteID = 1


-- Vista de “Cursos y su docente” con la nota mínima y el estado del curso. 

CREATE VIEW vwCursosDisponibles
AS
SELECT c.Titulo, (d.Nombre +' '+ d.Apellido) AS NombreCompleto,c.NotaMinima,c.Estado FROM Cursos c 
INNER JOIN Docentes d ON c.DocenteID=d.DocenteID;

-- Vista de “Estudiantes, progreso y calificación en cada curso”. 

CREATE VIEW vwEstudisntesPorCursos
AS 
SELECT c.Titulo,(e.Nombre + ' ' + e.Apellido) AS NombreCompleto,AVG(em.NotaExamen) AS TotalNotas,i.PorcentajeAvance
FROM Inscripcion i
INNER JOIN Estudiantes e ON i.EstudianteID = e.EstudianteID
INNER JOIN Cursos c ON c.CursoID = i.CursoID
INNER JOIN EstudiantesModulos em ON em.EstudianteID = e.EstudianteID
INNER JOIN Modulos m ON m.ModuloID = em.ModuloID
GROUP BY c.Titulo,e.Nombre,e.Apellido,i.PorcentajeAvance;

-- TRIGGER PARA DOCENTES
CREATE TRIGGER trgDocentes
ON Docentes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Si hubo INSERT (hay datos en INSERTED pero no en DELETED)
    IF EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaDocentes(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
            'INSERT',
			SUSER_SNAME(),
            GETDATE(),
            ('Nuevo docente insertado: '+ Correo) 
        FROM INSERTED i;
    END

    -- Si hubo DELETE (hay datos en DELETED pero no en INSERTED)
    ELSE IF NOT EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaDocentes(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
             'DELETED',
			SUSER_SNAME(),
            GETDATE(),
            ('Docente eliminado: '+ Correo)
        FROM DELETED;
    END

    -- Si hubo UPDATE (hay datos tanto en INSERTED como en DELETED)
    ELSE IF EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO  AuditoriaDocentes(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
            'UPDATE',
			SUSER_SNAME(),
            GETDATE(),
            ('Docente actualizado :'  +  i.Correo)
        FROM INSERTED i
        JOIN DELETED d ON i.DocenteID = d.DocenteID;
    END
END;


-- TRIGGER PARA MODULOS
CREATE TRIGGER trgModulos
ON Modulos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    IF EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaModulos(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
            'INSERT',
			SUSER_SNAME(),
            GETDATE(),
            ('Nuevo modulo insertado: '+ Titulo ) 
        FROM INSERTED i;
    END

    ELSE IF NOT EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaModulos(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
             'DELETED',
			SUSER_SNAME(),
            GETDATE(),
            ('Modulo eliminado: '+ Titulo)
        FROM DELETED;
    END

    ELSE IF EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO  AuditoriaModulos(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
            'UPDATE',
			SUSER_SNAME(),
            GETDATE(),
            ('Modulo actualizado :'  +  i.Titulo)
        FROM INSERTED i
        JOIN DELETED d ON i.ModuloID = d.ModuloID;
    END
END;


-- TRIGGER PARA ESTUDIANTES
CREATE TRIGGER trgEstudiantes
ON Estudiantes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    IF EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaEstudiantes(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
            'INSERT',
			SUSER_SNAME(),
            GETDATE(),
            ('Nuevo estudiante insertado: '+ Correo ) 
        FROM INSERTED i;
    END

    ELSE IF NOT EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaEstudiantes(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
             'DELETED',
			SUSER_SNAME(),
            GETDATE(),
            ('Estudiante eliminado: '+ Correo)
        FROM DELETED;
    END

    ELSE IF EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO  AuditoriaEstudiantes(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
            'UPDATE',
			SUSER_SNAME(),
            GETDATE(),
            ('Estudiante actualizado :'  +  i.Correo)
        FROM INSERTED i
        JOIN DELETED d ON i.EstudianteID = d.EstudianteID;
    END
END;

-- TRIGGER PARA ESTUDIANTES_CLASES
ALTER TRIGGER trgEstudiantesClases
ON EstudiantesClases
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    IF EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaEstudiantesClases(Operacion,Usuario,Fecha)
        SELECT
            'INSERT',
			SUSER_SNAME(),
            GETDATE()
        FROM INSERTED i;
    END

    ELSE IF NOT EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaEstudiantesClases(Operacion,Usuario,Fecha)
        SELECT
             'DELETED',
			SUSER_SNAME(),
            GETDATE()
        FROM DELETED;
    END

    ELSE IF EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO  AuditoriaEstudiantesClases(Operacion,Usuario,Fecha)
        SELECT
            'UPDATE',
			SUSER_SNAME(),
            GETDATE()
        FROM INSERTED i
        JOIN DELETED d ON i.EstudianteID = d.EstudianteID;
    END
END;


-- TRIGGER PARA ESTUDIANTES_CLASES
ALTER TRIGGER trgEstudiantesClases
ON EstudiantesClases
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    IF EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaEstudiantesClases(Operacion,Usuario,Fecha)
        SELECT
            'INSERT',
			SUSER_SNAME(),
            GETDATE()
        FROM INSERTED i;
    END

    ELSE IF NOT EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaEstudiantesClases(Operacion,Usuario,Fecha)
        SELECT
             'DELETED',
			SUSER_SNAME(),
            GETDATE()
        FROM DELETED;
    END

    ELSE IF EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO  AuditoriaEstudiantesClases(Operacion,Usuario,Fecha)
        SELECT
            'UPDATE',
			SUSER_SNAME(),
            GETDATE()
        FROM INSERTED i
        JOIN DELETED d ON i.EstudianteID = d.EstudianteID;
    END
END;


-- TRIGGER PARA CALIFICACIONES
CREATE TRIGGER trgCalificaciones
ON Calificacion
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    IF EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaCalificaciones(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
            'INSERT',
			SUSER_SNAME(),
            GETDATE(),
		  CONCAT('Nueva calificación insertada para: ', EstudianteID)      
		  FROM INSERTED i;
    END

    ELSE IF NOT EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO AuditoriaCalificaciones(Operacion,Usuario,Fecha,DatosRelevantes)
        SELECT
             'DELETED',
			SUSER_SNAME(),
            GETDATE(),
		  CONCAT('Eliminacion de calificación para: ', EstudianteID)      
        FROM DELETED;
    END

    ELSE IF EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
    BEGIN
        INSERT INTO  AuditoriaCalificaciones(Operacion,Usuario,Fecha)
        SELECT
            'UPDATE',
			SUSER_SNAME(),
            GETDATE()
        FROM INSERTED i
        JOIN DELETED d ON i.EstudianteID = d.EstudianteID;
    END
END;