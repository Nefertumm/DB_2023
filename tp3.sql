DROP TABLE IF EXISTS alumnos;
DROP TABLE IF EXISTS paises;
DROP TABLE IF EXISTS colores;
DROP TABLE IF EXISTS ciudades;
DROP TABLE IF EXISTS provincias;

CREATE TABLE paises (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
);

CREATE TABLE colores (
    ID SERIAL PRIMARY KEY,
    Nombre CHAR(50) NOT NULL
);

CREATE TABLE provincias (
    ID SERIAL PRIMARY KEY,
    Nombre CHAR(50) NOT NULL
);

CREATE TABLE ciudades (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Provincia INTEGER REFERENCES provincias (ID)
);

CREATE TABLE alumnos (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Apellido VARCHAR(255) NOT NULL, 
    FechaNacimiento DATE NOT NULL,
    ColorPreferido INTEGER REFERENCES colores (ID),
    Nacionalidad INTEGER REFERENCES paises (ID),
    CiudadNatal INTEGER REFERENCES ciudades (ID),
    CiudadResidencia INTEGER REFERENCES ciudades (ID)
);
