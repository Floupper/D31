DROP TABLE mespays CASCADE CONSTRAINTS;
DROP TABLE mesvilles CASCADE CONSTRAINTS;
DROP TABLE meslangues CASCADE CONSTRAINTS;


CREATE TABLE mespays (
  country_id char(3) NOT NULL,
  name varchar2(52) NOT NULL,
  continent varchar2(14) NOT NULL,
  region varchar2(26) NOT NULL,
  surface_area number(10,2) NOT NULL,
  independence_year number(6),
  population number(11),
  life_expectancy number(3,1),
  gnp number(10,2),
  gnp_old number(10,2),
  local_name varchar2(60),
  government_form varchar2(45) NOT NULL,
  head_of_state varchar2(60),
  capital number(11),
  code2 char(2) NOT NULL UNIQUE,
  CONSTRAINT PK_COUNTRIES PRIMARY KEY (COUNTRY_ID),
  CONSTRAINT ck_continent CHECK (INITCAP(continent) IN ('Asia', 'Europe', 'North America', 'Africa', 'Oceania', 'Antarctica', 'South America'))
);

CREATE TABLE mesvilles (
  city_id number(11) NOT NULL,
  name varchar2(60) NOT NULL,
  country_id char(3) NOT NULL,
  district varchar2(60),
  population number(11),
  CONSTRAINT PK_CITIES PRIMARY KEY (CITY_ID)
);



ALTER TABLE mespays
ADD CONSTRAINT fk_countries_capital
FOREIGN KEY (capital)
REFERENCES mesvilles(city_id);


ALTER TABLE mesvilles
ADD CONSTRAINT fk_cities_country_code
FOREIGN KEY (country_id)
REFERENCES mespays(country_id);



CREATE TABLE meslangues (
  country_code char(3) NOT NULL,
  language varchar2(30) NOT NULL,
  official char(1) NOT NULL,
  percentage number(4,1),
  CONSTRAINT PK_LANGUAGES PRIMARY KEY (country_code, language)
);

ALTER TABLE meslangues
ADD CONSTRAINT fk_languages_country_code
FOREIGN KEY (country_code)
REFERENCES mespays(country_id);



ALTER TABLE mespays
DISABLE CONSTRAINT fk_countries_capital;

ALTER TABLE mesvilles
DISABLE CONSTRAINT fk_cities_country_code;

ALTER TABLE meslangues
DISABLE CONSTRAINT fk_languages_country_code;

INSERT INTO mespays (country_id, name, continent, region, surface_area, independence_year, population, life_expectancy, gnp, gnp_old, local_name, government_form, head_of_state, code2)
VALUES ('FRA', 'France', 'Europe', 'Western Europe', 551500.00, 843, 59225700, 78.8, 1424285.00, 1392448.00, 'France', 'Republic', 'Jacques Chirac', 'FR');


INSERT INTO mesvilles (city_id, name, country_id, district, population)
VALUES (2974, 'Paris', 'FRA', 'Île-de-France', NULL);