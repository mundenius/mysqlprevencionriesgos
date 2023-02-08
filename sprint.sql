CREATE DATABASE asesoriaPrevRiesgos;
USE asesoriaPrevRiesgos;

CREATE TABLE clientes (
rutcliente INT not null PRIMARY KEY,
clinombres VARCHAR(30) NOT NULL,
cliapellidos VARCHAR(50) NOT NULL,
clitelefono VARCHAR (20) NOT NULL,
cliafp VARCHAR(30),
clisistemasalud INT NOT NULL,
clidireccion VARCHAR(100) NOT NULL,
clicomuna VARCHAR(50) NOT NULL,
cliedad INT NOT NULL
);


CREATE TABLE capacitaciones (
idcapacitacion INT PRIMARY KEY,
capfecha DATE NOT NULL,
caphora TIME,
caplugar VARCHAR(100) NOT NULL,
capduracion INT,
cliente_rutcliente INT NOT NULL
);

ALTER TABLE capacitaciones ADD FOREIGN KEY (cliente_rutcliente) REFERENCES clientes(rutcliente);

CREATE TABLE asistentes (
idasistente INT PRIMARY KEY,
asistnombrecompleto VARCHAR(100) NOT NULL,
asistedad INT NOT NULL,
asistcorreo VARCHAR(70),
asisttelefono VARCHAR(30),
/*F*/capacitacion_idcapacitacion INT NOT NULL
);

ALTER TABLE asistentes ADD FOREIGN KEY (capacitacion_idcapacitacion) REFERENCES capacitaciones(idcapacitacion);

CREATE TABLE accidente (
idaccidente INT PRIMARY KEY,
accifecha DATE NOT NULL,
accihora TIME NOT NULL,
accilugar VARCHAR(150) NOT NULL,
acciorigen VARCHAR(100) NOT NULL,
acciconsecuencias VARCHAR(100),
/*F*/cliente_rutcliente INT NOT NULL
);

ALTER TABLE accidente ADD FOREIGN KEY (cliente_rutcliente) REFERENCES clientes(rutcliente);

CREATE TABLE visitas (
idvisita INT PRIMARY KEY,
visfecha DATE NOT NULL,
vishora TIME,
vislugar VARCHAR(50) NOT NULL,
viscomentarios VARCHAR(250) NOT NULL,
/*F*/cliente_rutcliente INT NOT NULL
);

ALTER TABLE visitas ADD FOREIGN KEY (cliente_rutcliente) REFERENCES clientes(rutcliente);

create table chequeo (
idchequeo int not null auto_increment primary key, 
aprobado boolean not null, 
reprobado boolean not null,
comentarios varchar(250));

create table usuarios (
idusuario varchar(15) not null primary key, 
nombre varchar(30) not null, 
apellido varchar(30) not null, 
fechanacimiento varchar(10) not null, 
run int not null);

alter table chequeo 
add column idvisita_chequeo int not null; 
alter table chequeo
add foreign key (idvisita_chequeo) references visitas(idvisita);

alter table visitas
add foreign key (cliente_rutcliente) references clientes(rutcliente);

alter table usuarios
add column rutcliente_usuario int not null;
alter table usuarios
add foreign key (rutcliente_usuario) references clientes(rutcliente); 

create table tipochequeo (
nombrechequeo varchar(30) not null, 
idtipochequeo int not null primary key, 
idchequeo_tipochequeo int not null unique ) ;

alter table tipochequeo 
add foreign key (idchequeo_tipochequeo) references chequeo(idchequeo); 

create table administrativos (
idadministrativo int not null primary key, 
run varchar(15) not null unique, 
nombre varchar(25) not null, 
apellido varchar(30) not null, 
email varchar(20) not null, 
area varchar(15) not null, 
idusuario_administrativos varchar(15)
 ); 
 
 alter table administrativos 
 add foreign key (idusuario_administrativos) references usuarios(idusuario);
 
 create table profesionales (
idprofesional int not null auto_increment primary key, 
run varchar(15) not null unique, 
nombre varchar(25) not null, 
apellido varchar(30) not null, 
telefono int, 
tituloprofesional varchar(50) not null, 
proyecto varchar(30) not null, 
idusuario_profesionales varchar(15) not null ); 

alter table profesionales
add foreign key (idusuario_profesionales) references usuarios(idusuario);

create table pagos (
idpagos int not null auto_increment primary key, 
fechapago date not null, 
monto int not null, 
mespagado varchar(15) not null, 
añopagado int not null,
rutcliente_pagos int not null ); 

alter table pagos 
add foreign key (rutcliente_pagos) references clientes(rutcliente);

create table asesorias (
idasesoria int not null auto_increment unique primary key,
fecha date not null, 
motivo varchar(250) not null, 
idprofesional_asesorias int not null,
rutcliente_asesorado int not null ); 

alter table asesorias 
add foreign key (idprofesional_asesorias) references profesionales(idprofesional); 
alter table asesorias
add foreign key (rutcliente_asesorado) references clientes(rutcliente); 

create table actividadesmejora (
idmejora int not null auto_increment primary key, 
titulomejora varchar(50) not null, 
descripcion varchar(250) not null, 
plazoresolucion int not null, 
profesionalrecomendador int not null ,
clienterecomendado int not null
); 

alter table actividadesmejora 
add foreign key (profesionalrecomendador) references profesionales(idprofesional); 
alter table actividadesmejora
add foreign key (clienterecomendado) references clientes(rutcliente);

INSERT INTO clientes (rutcliente, clinombres, cliapellidos, clitelefono,
 cliafp, clisistemasalud, clidireccion, clicomuna, cliedad)
VALUES (181112220, 'Abel Andres', 'Valenzuela Perez', 999888222, 'afp lala',1,'mi casa#123','comuna salada',80),
(29888333,'Maria paz','Rios Lagos',111222999,'afp lele', 0, 'mi depto #123 depto 10', 'valparaiso', 22),
(134206621,'Adriel Luis', 'Rauschgift Mendoza',763876100, 'afp platita', 1, 'calle desolada #398', 'Comuna Esperanza',32);

INSERT INTO accidente (idaccidente, accifecha, accihora, accilugar, acciorigen,
acciconsecuencias, cliente_rutcliente) VALUES
(1, '2023-01-15','14:32:54','calle peligrosa #532', 'caida desnivel','torcedura tobillo',181112220),
(2,'2023-01-20','04:05:24','Ruta 4 norte km 45','accidente transito','Fractura costillas',134206621),
(3,'2023-02-02)','15:32:22', 'avenida sur 432','caida escalera', 'nariz rota', 29888333);

INSERT INTO pagos (fechapago, monto, mespagado, añopagado, rutcliente_pagos) 
VALUES ('2023-01-16', 50000, 'enero', 2023, 181112220),
('2023-01-23', 34000, 'enero', 2023, 134206621),
('2023-02-06', 30000, 'febrero', 2023, 29888333);

INSERT INTO visitas (idvisita, visfecha, vishora, vislugar, viscomentarios, cliente_rutcliente)
VALUES (1, '2023-01-16','13:10:11', 'sala 1','paciente estable',181112220),
(2, '2023-01-22','13:00:23', 'sala 2','paciente inestable',134206621),
(3, '2023-02-05', '13:05:02','sala 3','sin comentarios',29888333);

INSERT INTO chequeo (aprobado, reprobado, comentarios, idvisita_chequeo)
VALUES (1, 0, 'mejorando',1), 
(0, 1, 'mejora leve, falta reposo', 2),
(1, 0, 'sin comentarios', 3);

INSERT INTO tipochequeo (nombrechequeo, idtipochequeo, idchequeo_tipochequeo)
VALUES ('revision tobillo', 1, 1),
('revision torax', 2, 2), 
('revision nariz', 3, 3); 

INSERT INTO capacitaciones (idcapacitacion, capfecha, caphora, caplugar, capduracion, cliente_rutcliente)
VALUES (1,'2023-01-16', '16:00:23', 'Sala capacitacion 2', 60, 181112220),
(2,'2023-01-22', '16:00:02', 'Sala capacitacion 53', 45, 134206621),
(3,'2023-02-05','16:00:34', 'Sala capacitacion 4', 60,29888333);

INSERT INTO asistentes (idasistente, asistnombrecompleto, asistedad, asistcorreo, asisttelefono,
capacitacion_idcapacitacion) VALUES 
(1 , 'Juan Daniel Rodriguez Jeje', 45, 'Juandaniel@correo.com', '+569123123123', 1),
(2, 'Sofia laura Gonzalez Diaz', 39, 'Sofialaura@correo.com', '+569345876123', 2),
(3, 'Constanza Camila Paez Riquelme', 54, 'CCamila@correo.com', '+569777444333', 3);

INSERT INTO usuarios (idusuario, nombre, apellido, fechanacimiento, run, rutcliente_usuario)
VALUES (1, 'pato', 'donald', '05-05-1980', 157773330,181112220),
(2, 'Raul','Blebla', '20-04-1984', 178883332, 134206621),
(3, 'Clara', 'Estrella', '06-03-1987', 179992220, 29888333);

INSERT INTO administrativos (idadministrativo, run, nombre, apellido, email, area,
idusuario_administrativos) VALUES 
(1, '155559990', 'David', 'Riquelme', 'david@admin.com', 'admin adultos', 1),
(2, '134443332', 'Cynthia', 'Altamirano', 'cynthia@admin.com', 'admin salud', 2),
(3, '123334442', 'Rafael', 'Riquelme', 'Rafa@admin.com', 'admin salud', 3);

INSERT INTO profesionales (idprofesional, run, nombre, apellido, telefono, tituloprofesional,
proyecto, idusuario_profesionales) VALUES
(1, '125547741', 'Jorge', 'Salina', 44877888, 'Ingeniero Civil', 'Puente Cau Cau', 1),
(2, '203369984', 'Maria', 'Latorre', 888555111, 'Constructor Civil', 'Puente Cau Cau', 2),
(3, '156632009', 'Esteban', 'Lobos', 148884446, 'Maestro Concretero', 'Puente Canal Chacao', 3);

INSERT INTO asesorias (idasesoria, fecha, motivo, idprofesional_asesorias, rutcliente_asesorado) VALUES 
(1, '2023-01-16', 'mejoramiento de rendimiento profesional', 1, 181112220),
(2, '2023-01-22', 'taller de trabajo en equipo', 2, 29888333),
(3, '2023-02-05', 'control de ira laboral', 3, 134206621);

INSERT INTO actividadesmejora (titulomejora, descripcion, plazoresolucion,
profesionalrecomendador, clienterecomendado) VALUES
('titulo mejora 1', 'reposo', 20, 1, 181112220),
('titulo mejora 2', 'vacaciones', 60, 2, 29888333),
('titulo mejora 3', 'aislamiento', 90, 3,134206621);


/*a) Realice una consulta que permita listar todas las capacitaciones de un cliente en particular, 
indicando el nombre completo, la edad y el correo electrónico de los asistentes.*/
SELECT a.asistnombrecompleto, a.asistedad, a.asistcorreo FROM capacitaciones c
INNER JOIN asistentes a ON c.idcapacitacion = a.capacitacion_idcapacitacion INNER JOIN 
clientes cl ON cl.rutcliente = c.cliente_rutcliente;

/*b) Realice una consulta que permita desplegar todas las visitas en terreno realizadas a los clientes 
que sean de la comuna de Valparaíso. Por cada visita debe indicar todos los chequeos que se hicieron
 en ella, junto con el estado de cumplimiento de cada uno.*/
SELECT v.*, c.* FROM visitas v INNER JOIN chequeo c ON c.idvisita_chequeo = v.idvisita INNER JOIN
clientes cl ON cl.rutcliente = v.cliente_rutcliente WHERE cl.clicomuna = 'valparaiso';

/*c) Realice una consulta que despliegue los accidentes registrados para todos los clientes, indicando 
los datos de detalle del accidente, y el nombre, apellido, RUT y teléfono del cliente al que se 
asocia dicha situación.*/
SELECT a.*, cl.clinombres, cl.cliapellidos, cl.rutcliente, cl.clitelefono FROM accidente a INNER JOIN 
clientes cl ON a.cliente_rutcliente = cl.rutcliente;
