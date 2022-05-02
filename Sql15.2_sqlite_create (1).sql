CREATE TABLE animals (
	animal_id text,
	name text,
	type_id integer,
	breed_id integer,
	color_id integer,
	date_of_birth text
);

CREATE TABLE Breeds (
	breed_id integer PRIMARY KEY AUTOINCREMENT,
	breed text
);

CREATE TABLE colors (
	color_id integer PRIMARY KEY AUTOINCREMENT,
	color text
);

CREATE TABLE Types (
	type_id integer PRIMARY KEY AUTOINCREMENT,
	type text
);

CREATE TABLE Programs (
	program_id integer PRIMARY KEY AUTOINCREMENT,
	program text
);

CREATE TABLE Statuses (
	status_id integer PRIMARY KEY AUTOINCREMENT,
	status text
);

CREATE TABLE Admissions (
	animal_id integer PRIMARY KEY AUTOINCREMENT,
	name text,
	program_id integer,
	status_id integer,
	admission_month text,
	admission_year integer
);








