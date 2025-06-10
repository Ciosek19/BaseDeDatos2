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
	-- Se repite informaci�n entre el apartado de inscripciones y progreso. Podr�a optimizarse el texto y clarificar si ambas son necesarias o si se superponen en funcionalidad.
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
('Mar�a', 'Gonz�lez', 'maria.gonzalez@edu.com', '2024-01-01'),
('Jos�', 'Fern�ndez', 'jose.fernandez@edu.com', '2024-01-02');
GO

-- Cursos
INSERT INTO Cursos (DocenteID, Titulo, Descripcion, Duracion, Estado, NotaMinima) VALUES
(1, 'Curso de Matem�ticas B�sicas', 'Curso introductorio a las matem�ticas', 60, 1, 70.00),
(2, 'Curso de F�sica General', 'Curso b�sico de f�sica aplicada', 60, 1, 70.00);
GO

-- Modulos
INSERT INTO Modulos (CursoID, Titulo, Descripcion, Orden) VALUES
-- Curso Matem�ticas B�sicas
(1, '�lgebra B�sica', 'Fundamentos del �lgebra', 1),
(1, 'Geometr�a', 'Estudio de las figuras geom�tricas', 2),
(1, 'Trigonometr�a', 'Introducci�n a las funciones trigonom�tricas', 3),
-- Curso F�sica General
(2, 'Cinem�tica', 'Estudio del movimiento', 1),
(2, 'Din�mica', 'Fuerzas y movimiento', 2),
(2, 'Termodin�mica', 'Estudio del calor y energ�a', 3);
GO

-- Clases
INSERT INTO Clases (ModuloID, Titulo, Descripcion) VALUES
-- Curso Matem�ticas B�sicas: M�dulos 1-3
(1, 'Clase 1.1: Introducci�n al �lgebra', 'Conceptos b�sicos de �lgebra'),
(1, 'Clase 1.2: Ecuaciones Lineales', 'Resoluci�n de ecuaciones lineales'),
(1, 'Clase 1.3: Sistema de Ecuaciones', 'M�todos para resolver sistemas de ecuaciones'),
(2, 'Clase 2.1: Figuras Geom�tricas', 'Introducci�n a la geometr�a'),
(2, 'Clase 2.2: �reas y Vol�menes', 'C�lculo de �reas y vol�menes'),
(2, 'Clase 2.3: Teorema de Pit�goras', 'Aplicaciones del teorema de Pit�goras'),
(3, 'Clase 3.1: Funciones Trigonom�tricas', 'Estudio de las funciones seno, coseno y tangente'),
(3, 'Clase 3.2: Identidades Trigonom�tricas', 'Identidades y ecuaciones trigonom�tricas'),
(3, 'Clase 3.3: Aplicaciones de la Trigonometr�a', 'Uso de la trigonometr�a'),
-- Curso F�sica General: M�dulos 4-6
(4, 'Clase 4.1: Movimiento Rectil�neo', 'Estudio del movimiento rectil�neo'),
(4, 'Clase 4.2: Leyes de Newton', 'Introducci�n a las leyes de Newton'),
(4, 'Clase 4.3: Velocidad y Aceleraci�n', 'C�lculo de velocidad y aceleraci�n'),
(5, 'Clase 5.1: Ley de la Gravedad', 'Gravedad y fuerzas de atracci�n'),
(5, 'Clase 5.2: Fuerzas de Fricci�n', 'Fuerzas que afectan el movimiento'),
(5, 'Clase 5.3: Trabajo y Energ�a', 'Conceptos de trabajo y energ�a'),
(6, 'Clase 6.1: Leyes de la Termodin�mica', 'Introducci�n a las leyes de la termodin�mica'),
(6, 'Clase 6.2: Ciclo Termodin�mico', 'Estudio de los ciclos termodin�micos'),
(6, 'Clase 6.3: Transferencia de Calor', 'Mecanismos de transferencia de calor');
GO

-- Estudiantes
INSERT INTO Estudiantes (Nombre, Apellido, Correo) VALUES
('Juan', 'P�rez', 'juan.perez@example.com'),
('Ana', 'L�pez', 'ana.lopez@example.com'),
('Carlos', 'Mart�nez', 'carlos.martinez@example.com');
GO

-- EstudiantesCursos
INSERT INTO EstudiantesCursos (CursoID, EstudianteID) VALUES
(1, 1), (1, 2), (2, 3);
GO

-- EstudiantesModulos
INSERT INTO EstudiantesModulos (ModuloID, EstudianteID, NotaExamen) VALUES
-- Estudiante 1 (Aprob� el curso)
(1, 1, 85.00), (2, 1, 80.00), (3, 1, 90.00),
(4, 1, 95.00), (5, 1, 85.00), (6, 1, 90.00),
-- Estudiante 2 (En proceso, no termin� todos los m�dulos)
(1, 2, 65.00), (2, 2, 70.00), (3, 2, 75.00), -- Solo complet� 3 m�dulos
-- Estudiante 3 (No aprob� el curso)
(1, 3, 50.00), (2, 3, 60.00), (3, 3, 55.00),
(4, 3, 45.00), (5, 3, 50.00), (6, 3, 40.00);
GO

-- EstudiantesClases
INSERT INTO EstudiantesClases (ClaseID, EstudianteID, Visto) VALUES
-- Estudiante 1 (Aprob� el curso)
(1, 1, 1), (2, 1, 1), (3, 1, 1), (4, 1, 1), (5, 1, 1), (6, 1, 1), 
(7, 1, 1), (8, 1, 1), (9, 1, 1), (10, 1, 1), (11, 1, 1), (12, 1, 1), 
(13, 1, 1), (14, 1, 1), (15, 1, 1),
-- Estudiante 2 (En proceso, no termin� todos los m�dulos)
(1, 2, 1), (2, 2, 1), (3, 2, 1), (4, 2, 1), (5, 2, 1), (6, 2, 1), 
(7, 2, 0), (8, 2, 0), (9, 2, 0), -- No complet� el resto de clases
(10, 2, 0), (11, 2, 0), (12, 2, 0), 
(13, 2, 0), (14, 2, 0), (15, 2, 0),
-- Estudiante 3 (No aprob� el curso)
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
(1, 1, 100.00), -- Estudiante 1: Aprob�
(2, 1, 50.00), -- Estudiante 2: En proceso (no complet� todos los m�dulos)
(3, 2, 40.00); -- Estudiante 3: No aprob�
GO

-- Calificacion
-- Estudiante 2 no tiene calificaci�n porque no complet� todos los m�dulos
INSERT INTO Calificacion (EstudianteID, CursoID, Nota) VALUES
(1, 1, (85 + 80 + 90 + 95 + 85 + 90) / 6.0),  -- Aprobado
(3, 2, (50 + 60 + 55 + 45 + 50 + 40) / 6.0);  -- No aprobado
GO


-- Certificacion
INSERT INTO Certificacion (EstudianteID, CursoID, FechaEmision) VALUES
(1, 1, '2024-03-01');  -- Certificaci�n entregada solo al estudiante 1
GO



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
DECLARE @cursoIDNuevo int = 3

EXEC InscripcionCurso @estudianteID= @estudianteIDNuevo, @cursoID= @cursoIDNuevo




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



 