-- Proyecto POO-BD 01/2021
-- Grupo 4
-- Integrante 1	[00074320	Barahona Hern?ndez, Eddy Ren?]
-- Integrante 2	[00051120	Canales Guill?n, Ernesto Jos?]
-- Integrante 3	[00143320	Peraza Bola?os, V?ctor Daniel]
-- Integrante 4	[00043920	Ramos Guardado, Diego Fernando]

CREATE DATABASE G4ProyectoDB;
USE G4ProyectoDB;
SET LANGUAGE us_english;

-- Tables section
-- Do not need a FK
CREATE TABLE SIDE_EFFECT(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	effect VARCHAR(150) NOT NULL
);

CREATE TABLE CITIZEN(
	dui VARCHAR(9) NOT NULL PRIMARY KEY,
	citizen_name VARCHAR(50) NOT NULL,
	identifier_number VARCHAR(50),
	phone_number CHAR(12) NOT NULL,
	citizen_address VARCHAR(100) NOT NULL,
	e_mail VARCHAR(100)
);

CREATE TABLE EMPLOYEE_TYPE(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	employee_type VARCHAR(50) NOT NULL
);

CREATE TABLE VACCINATION_CENTER(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	center_address VARCHAR(100) NOT NULL,
	center_name VARCHAR(50) NOT NULL,
	capacity INT NOT NULL
);

CREATE TABLE DOSE_TYPE(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	shot_type VARCHAR(50) NOT NULL
);

CREATE TABLE CABIN(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	cabin_address VARCHAR(100) NOT NULL,
	phone_number CHAR(12) NOT NULL,
	e_mail VARCHAR(25) NOT NULL
);

-- Need a FK
CREATE TABLE DISEASE(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	disease_name VARCHAR(50) NOT NULL,
	dui_citizen VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES CITIZEN(dui)
);

CREATE TABLE DISABILITY(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	disability_name VARCHAR(50) NOT NULL,
	dui_citizen VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES CITIZEN(dui)
);

CREATE TABLE VACCINATION_PROCESS(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	vaccination_date DATE NOT NULL,
	start_time TIME NOT NULL,
	vaccination_time TIME NOT NULL,
	end_time TIME NOT NULL,
	shot_type INT NOT NULL FOREIGN KEY REFERENCES DOSE_TYPE(id),
	dui_citizen VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES CITIZEN(dui)
);

CREATE TABLE EMPLOYEE(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	employee_user VARCHAR(50) NOT NULL,
	employee_password VARCHAR(50) NOT NULL,
	employee_name VARCHAR(50) NOT NULL,
	employee_address VARCHAR(100) NOT NULL,
	e_mail VARCHAR(25) NOT NULL,
	id_type INT NOT NULL FOREIGN KEY REFERENCES EMPLOYEE_TYPE(id)
);

CREATE TABLE APPOINTMENT(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	appointment_date DATETIME NOT NULL,
	shot_type INT NOT NULL FOREIGN KEY REFERENCES DOSE_TYPE(id),
	id_center INT NOT NULL FOREIGN KEY REFERENCES VACCINATION_CENTER(id),
	dui_citizen VARCHAR(9) NOT NULL FOREIGN KEY REFERENCES CITIZEN(dui),
	id_employee INT NOT NULL FOREIGN KEY REFERENCES EMPLOYEE(id)
);

CREATE TABLE SESSION_CONTROL(
	id INT NOT NULL PRIMARY KEY IDENTITY,
	session_date DATETIME NOT NULL,
	id_employee INT NOT NULL FOREIGN KEY REFERENCES EMPLOYEE(id),
	id_cabin INT NOT NULL FOREIGN KEY REFERENCES CABIN(id)
);

CREATE TABLE PRESENTED_SIDE_EFFECT(
	id INT PRIMARY KEY IDENTITY,
	appearance_time INT NOT NULL,
	id_vaccination_process INT NOT NULL FOREIGN KEY REFERENCES VACCINATION_PROCESS(id),
	id_side_effect INT NOT NULL FOREIGN KEY REFERENCES SIDE_EFFECT(id)
);

-- Need a PK-FK
CREATE TABLE IN_CHARGE(
	id_employee INT NOT NULL,
	id_cabin INT NOT NULL,
	CONSTRAINT PK_in_charge PRIMARY KEY (id_employee, id_cabin),
	FOREIGN KEY (id_employee) REFERENCES EMPLOYEE(id),
	FOREIGN KEY (id_cabin) REFERENCES CABIN(id)
);

-- NOTES:
-- DATE: format YYYY-MM-DD
-- TIME: format hh:mm:ss
-- telefono CHAR(12): +50300000000

-- Inserting data to tables
-- EFECTO_SECUNDARIO
INSERT INTO SIDE_EFFECT
	VALUES ('Dolor y/o sensibilidad en el sitio de la inyecci?n.');
INSERT INTO SIDE_EFFECT
	VALUES ('Enrojecimiento en el sitio de la inyecci?n.');
INSERT INTO SIDE_EFFECT
	VALUES ('Fatiga');
INSERT INTO SIDE_EFFECT
	VALUES ('Dolor de cabeza');
INSERT INTO SIDE_EFFECT
	VALUES ('Fiebre');
INSERT INTO SIDE_EFFECT
	VALUES ('Mialgia');
INSERT INTO SIDE_EFFECT
	VALUES ('Artralgia');
INSERT INTO SIDE_EFFECT
	VALUES ('Anafilaxia');

-- TIPO_EMPLEADO
INSERT INTO EMPLOYEE_TYPE
	VALUES('Administrador/Encargado');
INSERT INTO EMPLOYEE_TYPE
	VALUES('Gestor');

-- CENTRO_VACUNACION
INSERT INTO VACCINATION_CENTER
	VALUES('4945 Purus. St.', 'Mega Centro de Vacunaci?n', 1000);
INSERT INTO VACCINATION_CENTER
	VALUES('5249 Lobortis St.', 'Centro de Salud General', 200);
INSERT INTO VACCINATION_CENTER
	VALUES('P.O. Box 772, 6980 Faucibus. St.', 'ISSS Santa Tecla', 100);
INSERT INTO VACCINATION_CENTER
	VALUES('3067 Nec Road', 'Fundaci?n Juan Carlos Bodoque', 3500);
INSERT INTO VACCINATION_CENTER
	VALUES('Ap #684-4488 Dui St.', 'Hospital General EEVD', 80);
INSERT INTO VACCINATION_CENTER
	VALUES('202-3173 In Avenue', 'Vacunaci?n La Gran V?a', 10);

-- TIPO_DOSIS
INSERT INTO DOSE_TYPE
	VALUES('Primera dosis');
INSERT INTO DOSE_TYPE
	VALUES('Segunda dosis');

-- CABINA
INSERT INTO CABIN
	VALUES('4945 Purus. St.', '+50323235687', 'Purus@gmail.com');
INSERT INTO CABIN
	VALUES('5249 Lobortis St.', '+50398453214', 'Lobortis@yahoo.es');
INSERT INTO CABIN
	VALUES('P.O. Box 772, 6980 Faucibus. St.', '+50324242424', 'Faucibus@gmail.gov.sv');
INSERT INTO CABIN
	VALUES('3067 Nec Road', '+50371529846', 'Nec_Road@gmail.com');
INSERT INTO CABIN
	VALUES('Ap #684-4488 Dui St.', '+50398632541', 'dui@hotmail.com');
INSERT INTO CABIN
	VALUES('202-3173 In Avenue', '+50377436852', 'InAv@yahoo.com');
INSERT INTO CABIN
	VALUES('4355 Santa Ana', '+50396318542', 'santa_ana@gmail.gov.sv');
INSERT INTO CABIN
	VALUES('P.O. Box 354, 4543 La Uni?n', '+50322436578', 'union@uca.edu.sv');
INSERT INTO CABIN
	VALUES('5654 San Julian Av.', '+50323864571', 'SanJu@hotmail.com');
INSERT INTO CABIN
	VALUES('45345 Cojutepeque St.', '+50376482514', 'cojute14@gmail.com');

-- EMPLEADO
INSERT INTO EMPLOYEE
	VALUES('Gestor_01', 'ABC123', 'Holo', 'Yoitsu Village', 'holo537@gmail.com', 1);
INSERT INTO EMPLOYEE
	VALUES('Root', 'Admin', 'Kraft Lawrence', '5213 Pazzio City', 'kraft@yahoo.com', 2);

-- ENCARGADO
INSERT INTO IN_CHARGE
	VALUES(2, 5);