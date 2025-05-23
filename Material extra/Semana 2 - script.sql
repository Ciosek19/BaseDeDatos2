CREATE TABLE Alumnos (
    id_alumno INT PRIMARY KEY,
    nombre VARCHAR(100),
    edad INT,
    curso VARCHAR(50)
);

CREATE TABLE Notas (
    id_nota INT PRIMARY KEY,
    id_alumno INT,
    materia VARCHAR(50),
    calificacion INT,
    FOREIGN KEY (id_alumno) REFERENCES Alumnos(id_alumno)
);

-- Datos de ejemplo
INSERT INTO Alumnos VALUES (1, 'Lucía', 20, 'Base de Datos');
INSERT INTO Alumnos VALUES (2, 'Juan', 21, 'Programación');
INSERT INTO Alumnos VALUES (3, 'Sofía', 22, 'Base de Datos');
INSERT INTO Alumnos VALUES (4, 'Diego', 23, 'Redes');
INSERT INTO Alumnos VALUES (5, 'Ana', 20, 'Programación');
INSERT INTO Alumnos VALUES (6, 'Luis', 24, 'Programación');

INSERT INTO Notas VALUES (1, 1, 'SQL', 95);
INSERT INTO Notas VALUES (2, 2, 'Java', 78);
INSERT INTO Notas VALUES (3, 3, 'SQL', 88);
INSERT INTO Notas VALUES (4, 4, 'Redes', 85);
INSERT INTO Notas VALUES (5, 5, 'Programación', 91);
INSERT INTO Notas VALUES (6, 6, 'Programación', 80);