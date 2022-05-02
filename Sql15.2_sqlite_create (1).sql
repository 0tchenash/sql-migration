--сделали табличку с уникальными цветами
CREATE TABLE colors (
 color_id integer PRIMARY KEY AUTOINCREMENT,
 color text (20)
);

--выбрали уникальные значения цветов из основной таблички
INSERT INTO colors (color)
SELECT DISTINCT * FROM (
    SELECT DISTINCT
        color1 AS color
    FROM animals
    UNION ALL
    SELECT DISTINCT
        color2 AS color
    FROM animals
    WHERE color2 is not null
            );

--создаем табличку с породами животных
CREATE TABLE Breeds (
	breed_id integer PRIMARY KEY AUTOINCREMENT,
	breed text
);
--Заполняем таблицу, выбирая уникальные данные
INSERT INTO Breeds (breed)
SELECT DISTINCT breed
FROM animals;
--Таблица с типом животного
CREATE TABLE Types (
 type_id integer PRIMARY KEY AUTOINCREMENT,
 type text
);
--заполнение таблицы с типами
INSERT INTO Types (type)
SELECT DISTINCT animal_type
FROM animals;
--Табличка с программами, в которых участвует животное
CREATE TABLE Programs (
 program_id integer PRIMARY KEY AUTOINCREMENT,
 program text (20)
);
--Заполнение вышеприведенной таблицы
INSERT INTO Programs (program)
SELECT DISTINCT outcome_subtype
FROM animals
WHERE outcome_subtype is not null;
--Таблица с состоянием животного
CREATE TABLE Statuses (
 status_id integer PRIMARY KEY AUTOINCREMENT,
 status text
);
--Заполнение
INSERT INTO Statuses (status)
SELECT DISTINCT outcome_type
FROM animals
WHERE outcome_type is not null;
--создание таблицы, где будет собрана вся информация о том или ином животном
CREATE TABLE animals_new (
	animal_id text PRIMARY KEY,
	name text,
	type_id integer,
	breed_id integer,
	main_color_id integer,
	second_color_id integer,
	date_of_birth text,
	FOREIGN KEY (type_id) REFERENCES Types(type_id) ON UPDATE CASCADE, --внешний ключ на тип
    FOREIGN KEY (breed_id) REFERENCES Breeds(breed_id) ON UPDATE CASCADE, --внешний ключ на породу
    FOREIGN KEY (main_color_id) REFERENCES colors (color_id) ON UPDATE CASCADE, --внешний ключ на основной цвет
    FOREIGN KEY (second_color_id) REFERENCES colors (color_id) ON UPDATE CASCADE --внешний ключ на дополнительный цвет
);
--заполнение таблицы
INSERT INTO animals_new (animal_id, name, date_of_birth, type_id, breed_id, main_color_id, second_color_id)--колонки, которые надо заполнить
SELECT DISTINCT animals.animal_id, animals.name, animals.date_of_birth,-- колонки из старой основной таблицы
                Types.type_id, -- колонка из второстепенной таблицы Types
                Breeds.breed_id, -- колонки из второстепенной таблицы Breeds
                colors1.color_id, -- колонки из второстепенной таблицы colors
                colors2.color_id

FROM animals
LEFT JOIN Breeds ON Breeds.breed = animals.breed --выбираем совпадения из таблицы пород
LEFT JOIN Types ON Types.type = animals.animal_type --выбираем совпадения из таблицы типа
LEFT JOIN colors colors1 ON colors1.color = animals.color1 --выбираем совпадения из таблицы основного цвета
LEFT JOIN colors colors2 ON colors2.color = animals.color2; --выбираем совпадения из таблицы второстепенного цвета
-- создаем таблицу приводов животных в приют
CREATE TABLE Admissions (
	id integer PRIMARY KEY AUTOINCREMENT,
	animal_id text,
	age_upon_outcome text,
	program_id integer,
	status_id integer,
	admission_month text,
	admission_year integer,
	FOREIGN KEY (program_id) REFERENCES Programs(program_id) ON UPDATE CASCADE,--внешний ключ на программу
    FOREIGN KEY (status_id) REFERENCES Statuses(status_id) ON UPDATE CASCADE,--внешний ключ на состояние
    FOREIGN KEY (animal_id) REFERENCES animals_new(animal_id) ON UPDATE CASCADE--внешний ключ на айди животного
);
--заполнение таблицы
INSERT INTO Admissions (animal_id, age_upon_outcome, admission_month, admission_year, program_id, status_id)--колонки, которые надо заполнить
SELECT DISTINCT animals.animal_id, animals.age_upon_outcome, animals.outcome_month, animals.outcome_year,-- колонки из старой основной таблицы
                Programs.program_id, -- колонка из второстепенной таблицы Types
                Statuses.status_id -- колонки из второстепенной таблицы Breeds

FROM animals
LEFT JOIN Programs ON Programs.program = animals.outcome_subtype
LEFT JOIN Statuses ON Statuses.status = animals.outcome_type;



--тестовый запрос на получение данных из всех таблиц
SELECT DISTINCT animals_new.name,
                animals_new.date_of_birth,
                Colors1.color,
                Colors2.color,
                Programs.program,
                Statuses.status,
                B.breed

FROM Admissions
LEFT JOIN Statuses  on Admissions.status_id = Statuses.status_id
LEFT JOIN Programs ON Admissions.program_id = Programs.program_id
LEFT JOIN animals_new ON Admissions.animal_id = animals_new.animal_id
LEFT JOIN Colors Colors1 ON animals_new.main_color_id = Colors1.color_id
LEFT JOIN Colors Colors2 ON animals_new.second_color_id = Colors2.color_id
LEFT JOIN Breeds B on animals_new.breed_id = B.breed_id
WHERE id = 3







