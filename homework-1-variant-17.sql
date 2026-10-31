/*
Пацев Вадим Васильевич
Вариант 17. PostgreSQL.

База данных экскурсионных туров.
Для маршрута нужны название, начальный город, описание, базовая стоимость
в рублях без экскурсий, доступные города и число дней пребывания в каждом.
Для экскурсии нужны город, название, описание и стоимость в рублях.
В городе может быть несколько экскурсий, но каждая экскурсия относится
только к одному городу.
Для тура нужны маршрут, дата отправления, длительность в днях,
дополнительные платежи и дополнительное описание.
*/

CREATE TABLE cities (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL CHECK (TRIM(name) <> '')
);

CREATE TABLE routes (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL CHECK (TRIM(name) <> ''),
    departure_city_id INTEGER NOT NULL REFERENCES cities(id),
    description TEXT NOT NULL,
    base_price NUMERIC(12, 2) NOT NULL CHECK (base_price >= 0)
);

CREATE TABLE route_cities (
    route_id INTEGER NOT NULL REFERENCES routes(id),
    city_id INTEGER NOT NULL REFERENCES cities(id),
    stay_days INTEGER NOT NULL CHECK (stay_days > 0),
    PRIMARY KEY (route_id, city_id)
);

CREATE TABLE excursions (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    city_id INTEGER NOT NULL REFERENCES cities(id),
    name TEXT NOT NULL CHECK (TRIM(name) <> ''),
    description TEXT NOT NULL,
    price NUMERIC(12, 2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE tours (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    route_id INTEGER NOT NULL REFERENCES routes(id),
    departure_date DATE NOT NULL,
    duration_days INTEGER NOT NULL CHECK (duration_days > 0),
    extra_fees NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (extra_fees >= 0),
    extra_description TEXT
);
