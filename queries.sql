-- -- /*Queries that provide answers to the questions from all projects.*/

-- -- SELECT * from animals;

-- -- /*Find all animals whose name ends in "mon".*/
-- -- SELECT * from animals WHERE name like '%mon';

-- -- /*List the name of all animals born between 2016 and 2019.*/
-- -- SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

-- -- /*List the name of all animals that are neutered and have less than 3 escape attempts.*/
-- -- SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- -- /*List the date of birth of all animals named either "Agumon" or "Pikachu".*/
-- --  SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- -- /*List name and escape attempts of animals that weight more than 10.5kg*/
-- --  SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- -- /*Find all animals that are neutered.*/
-- -- SELECT name FROM animals where neutered = true;

-- -- /*Find all animals not named Gabumon.*/
-- -- SELECT name FROM animals WHERE name != 'Gabumon';

-- -- /*Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
-- -- SELECT name FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- -- /*TRANSACTIONS*/
-- -- BEGIN;
-- -- UPDATE animals SET species = 'unspecified';
-- -- ROLLBACK;
-- -- SELECT * FROM animals;

-- -- BEGIN;
-- -- UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
-- -- UPDATE animals SET species = 'pokemon' WHERE species is NULL;
-- -- COMMIT;
-- -- SELECT * FROM animals;

-- -- BEGIN;
-- -- DELETE animals;
-- -- ROLLBACK;
-- -- COMMIT;
-- -- SELECT * FROM animals;

-- -- BEGIN;
-- -- DELETE FROM animals WHERE date_of_birth > '2022-01-01';
-- -- SELECT * FROM animals;
-- -- SAVEPOINT animals_deleted;
-- -- UPDATE animals SET weight_kg = weight_kg * -1;
-- -- ROLLBACK TO animals_deleted;
-- -- SELECT * FROM animals;
-- -- UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- -- COMMIT;
-- -- SELECT * FROM animals;

-- -- /*Count the number of animals*/
-- -- SELECT COUNT(*) from animals;

-- -- /*Count the number of animals that had not made attempt to escape*/
-- -- SELECT COUNT(*) from animals WHERE escape_attempts = 0;

-- -- /* Average weight of all the animals*/
-- -- SELECT ROUND(AVG(weight_kg)::numeric, 3) FROM animals;

-- -- /*Who escapes the most, neutered or not neutered animals?*/
-- -- SELECT name FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

-- -- /*What is the minimum and maximum weight of each type of animal?*/
-- -- SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- -- /*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/clear
-- -- SELECT species, ROUND(AVG(escape_attempts)::numeric, 0) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

-- -- /* Write query using JOIN */

-- -- /*What animals belong to Melody Pond*/
-- -- SELECT animals.name FROM animals INNER JOIN owners ON animals.owners_id = owners.owners_id WHERE owners.full_name = 'Melody Pond';

-- -- /*List of all animals that are pokemon*/
-- -- SELECT animals.name FROM animals JOIN species ON animals.species_id = species.species_id WHERE species.name = 'Pokemon';

-- -- /* List all owners and their animals, remember to include those that don't own any animal.*/
-- -- SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON animals.owners_id = owners.owners_id ;

-- -- /* How many animals are there per species?*/
-- -- SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.species_id GROUP by species.name;

-- -- /*List all Digimon owned by Jennifer Orwell*/
-- -- SELECT animals.name FROM animals JOIN owners ON animals.owners_id = owners.owners_id JOIN species ON animals.species_id = species.species_id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
-- -- /* List all animals owned by Dean Winchester that haven't tried to escape.*/
-- -- SELECT animals.name FROM animals JOIN owners ON animals.owners_id = owners.owners_id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0 GROUP BY animals.name;
-- -- /*Who owns the most animals?*/
-- -- SELECT owners.full_name, COUNT(*) FROM owners JOIN animals ON owners.owners_id = animals.owners_id GROUP BY owners.full_name ORDER BY COUNT(*) DESC LIMIT 1;

-- /*Who was the last animal seen by William Tatcher?*/
-- SELECT animals.name FROM animals
-- JOIN visits ON visits.animal_id = animals.id
-- WHERE vet_id = 1
-- ORDER BY day_of_visit DESC
-- LIMIT 1;

-- /*How many different animals did Stephanie Mendez see?*/
-- SELECT animals.name FROM animals
-- JOIN visits ON visits.animal_id = animals.id
-- WHERE vet_id = 3;

-- /*List all vets and their specialties, including vets with no specialties.*/
-- SELECT vets.name, species.name FROM vets
-- LEFT JOIN specializations ON specializations.vet_id = vets.vet_id
-- LEFT JOIN species ON specializations.species_id = species.species_id;

-- /*List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
-- SELECT animals.name, visits.day_of_visit FROM animals
-- JOIN visits ON visits.animal_id = animals.id
-- WHERE vet_id = 3 AND visits.day_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- /*-- What animal has the most visits to vets?*/
-- SELECT COUNT(visits.animal_id) as visit_count, animals.name from animals
-- JOIN visits On animals.id = visits.animal_id
-- GROUP BY visits.animal_id, animals.name
-- ORDER BY visit_count DESC
-- LIMIT 1;

-- /*Who was Maisy Smith's first visit?*/
-- SELECT animals.name, vets.name, visits.day_of_visit FROM animals
-- JOIN visits ON animals.id = visits.animal_id
-- JOIN vets ON visits.vet_id = vets.vet_id
-- WHERE visits.vet_id = 2
-- ORDER BY day_of_visit ASC
-- LIMIT 1;

-- /*Details for most recent visit: animal information, vet information, and date of visit.*/
-- SELECT animals.name, vets.name, visits.day_of_visit FROM animals
-- JOIN visits ON animals.id = visits.animal_id
-- JOIN vets ON visits.vet_id = vets.vet_id
-- WHERE visits.day_of_visit = '2021-05-04';

-- /*How many visits were with a vet that did not specialize in that animal's species?*/
-- SELECT COUNT(*) FROM animals
-- INNER JOIN visits ON animals.id = visits.animal_id
-- INNER JOIN vets ON vets.vet_id = visits.vet_id WHERE vets.vet_id = 2;

-- /*What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
-- SELECT COUNT(visits.animal_id) AS count_visits, species.name FROM visits
-- JOIN animals ON animals.id = visits.animal_id
-- JOIN species ON animals.species_id = species.species_id
-- WHERE visits.vet_id = 2
-- GROUP BY species.name
-- ORDER BY count_visits DESC
-- LIMIT 1;

-- explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

-- explain analyze SELECT * FROM visits where vet_id = 2;

explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';