CREATE TABLE Empleados (
	DNI BIGINT NOT NULL PRIMARY KEY,
	Nombre VARCHAR(30) NOT NULL,
	ID_cine INT NOT NULL,
	Fecha_inicio DATE NOT NULL,
	Fecha_fin DATE,
	Supervisado_por BIGINT
);

CREATE TABLE Tarea_empleado (
	DNI BIGINT NOT NULL,
	ID_Tarea INT NOT NULL
);

CREATE TABLE Tarea (
	ID_Tarea INT NOT NULL PRIMARY KEY,
	Nombre VARCHAR(30) NOT NULL,
	Es_riesgo BOOL NOT NULL
);

CREATE TABLE Cine (
	ID_cine INT NOT NULL PRIMARY KEY,
	CUIT VARCHAR(40) NOT NULL,
	Nombre VARCHAR(30) NOT NULL
);

CREATE TABLE Cine_sala (
	ID_cine INT NOT NULL,
	ID_sala INT NOT NULL
);

CREATE TABLE Sala (
	ID_sala INT NOT NULL PRIMARY KEY,
	Tipo VARCHAR(30)
);

ALTER TABLE Empleados
	ADD CONSTRAINT Empleado_Cine_FK FOREIGN KEY (ID_cine) REFERENCES Cine(ID_cine),
	ADD CONSTRAINT Empleado_Empleado_FK FOREIGN KEY (Supervisado_por) REFERENCES Empleados(DNI);

ALTER TABLE Tarea_Empleado
	ADD CONSTRAINT Tarea_Empleado_PK PRIMARY KEY (DNI, ID_tarea),
	ADD CONSTRAINT Tarea_Empleado_Empleado_FK FOREIGN KEY (DNI) REFERENCES Empleados(DNI),
	ADD CONSTRAINT Tarea_Empleado_Tarea_FK FOREIGN KEY (ID_tarea) REFERENCES Tarea(ID_tarea);

ALTER TABLE Cine_sala
	ADD CONSTRAINT Cine_sala_PK PRIMARY KEY (ID_cine, ID_sala),
	ADD CONSTRAINT Cine_sala_Cine_FK FOREIGN KEY (ID_cine) REFERENCES Cine(ID_cine),
	ADD CONSTRAINT Cine_sala_Sala_FK FOREIGN KEY (ID_sala) REFERENCES Sala(ID_sala);

INSERT INTO Cine (ID_cine, CUIT, Nombre) VALUES 
(5, 61291929893, 'illum'),
(9, 86194852330, 'id');

INSERT INTO Sala (ID_sala, tipo) VALUES
(0, 'Comun'),
(2, 'Ultra'),
(3, 'HD'),
(5, 'Común'),
(8, 'HD');

INSERT INTO Cine_sala (ID_cine, ID_sala) VALUES 
(5, 0),
(5, 3),
(5, 8),
(9, 2),
(9, 5);

INSERT INTO Empleados (DNI,Nombre,ID_cine,Fecha_inicio,Fecha_fin,Supervisado_por)
VALUES
  (20599421,'Brielle Mendez',9,'Apr 3, 2019',NULL,NULL),
  (22211008,'Nash Abbott',9,'Feb 7, 2020','Dec 28, 2020',20599421),
  (39409537,'Melinda Manning',5,'Jul 12, 2019',NULL,22211008),
  (33752869,'Hu Snyder',9,'Mar 22, 2019','Jan 4, 2021',39409537),
  (33807023,'Yuli Slater',5,'Dec 23, 2019','Aug 6, 2020',22211008),
  (32748731,'Christen Bowen',9,'Feb 21, 2020',NULL,39409537),
  (31130764,'Regina Briggs',5,'Jan 30, 2020','Aug 5, 2020',22211008),
  (14854147,'Cedric Burt',5,'Jan 14, 2020',NULL,39409537),
  (17914042,'Knox Garcia',5,'Nov 1, 2019',NULL,39409537);

INSERT INTO Tarea (ID_tarea, Nombre, Es_riesgo) VALUES 
(0, 'Limpieza', False),
(6, 'Orden', False),
(9, 'Reposición', True);

INSERT INTO Tarea_Empleado (ID_tarea, DNI) VALUES
(0, 20599421),
(6, 20599421),
(9, 20599421),
(0, 31130764);

SELECT COUNT(*) FROM Empleados WHERE Fecha_fin IS NULL; -- 5

SELECT CUIT FROM Cine WHERE Nombre LIKE 'illum'; -- 61291929893

SELECT COUNT(*) FROM Tarea_Empleado TE, Empleados E, Tarea T WHERE
T.Nombre LIKE 'Limpieza' AND T.ID_Tarea = TE.ID_Tarea AND E.DNI = TE.DNI AND E.Fecha_fin IS NULL; -- 1

DROP TABLE IF EXISTS Empleados, Tarea_Empleado, Tarea, Cine, Cine_Sala, Sala CASCADE;

ALTER TABLE Sala
	RENAME COLUMN Tipo TO ID_tipo;

ALTER TABLE Sala
	ADD COLUMN Capacidad INT NOT NULL DEFAULT 0,
	ALTER COLUMN ID_tipo TYPE INT USING ID_tipo::INT;
	
CREATE TABLE Sala_tipo (
	ID_tipo INT PRIMARY KEY,
	Descripcion VARCHAR(100)
);

ALTER TABLE Sala
	ADD CONSTRAINT Sala_Sala_tipo_FK FOREIGN KEY (ID_Tipo) REFERENCES Sala_tipo(ID_tipo);