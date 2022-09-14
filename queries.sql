/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals;
/*Find all animals whose name ends in "mon".*/
SELECT * from animals WHERE name like '%mon';

/*List the name of all animals born between 2016 and 2019.*/
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

/*List the name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

/*List the date of birth of all animals named either "Agumon" or "Pikachu".*/
 SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

/*List name and escape attempts of animals that weight more than 10.5kg*/
 SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/*Find all animals that are neutered.*/
SELECT name FROM animals where neutered = true;

/*Find all animals not named Gabumon.*/
SELECT name FROM animals WHERE name != 'Gabumon';

/*Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT name FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*TRANSACTIONS*/
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE animals;
ROLLBACK;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT animals_deleted;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO animals_deleted;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/*Count the number of animals*/
SELECT COUNT(*) from animals;

/*Count the number of animals that had not made attempt to escape*/
SELECT COUNT(*) from animals WHERE escape_attempts = 0;

/* Average weight of all the animals*/
SELECT ROUND(AVG(weight_kg)::numeric, 3) FROM animals;

/*Who escapes the most, neutered or not neutered animals?*/
SELECT name FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

/*What is the minimum and maximum weight of each type of animal?*/
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/clear
SELECT species, ROUND(AVG(escape_attempts)::numeric, 0) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;