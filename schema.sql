/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(150) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

ALTER TABLE animals
ADD species varchar(100);

CREATE TABLE owners (
    owners_id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(150) NOT NULL,
    age INT,
      PRIMARY KEY(owners_id)
);

CREATE TABLE species (
    species_id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(150) NOT NULL,
    PRIMARY KEY(species_id)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(species_id);
ALTER TABLE animals ADD COLUMN owners_id INT REFERENCES owners(owners_id);

CREATE TABLE vets (
    vet_id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(vet_id)
);

CREATE TABLE specializations (
    id INT GENERATED ALWAYS AS IDENTITY,
    vet_id INT,
    species_id INT,
    PRIMARY KEY(id)
);

ALTER TABLE specializations ADD FOREIGN KEY (vet_id) REFERENCES vets(vet_id);
ALTER TABLE specializations ADD FOREIGN KEY (species_id) REFERENCES species(species_id);

CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY,
    vet_id INT,
    animal_id INT,
    PRIMARY KEY(id)
);

ALTER TABLE visits ADD FOREIGN KEY (vet_id) REFERENCES vets(vet_id);
ALTER TABLE visits ADD FOREIGN KEY (animal_id) REFERENCES animals(id);

ALTER TABLE visits ADD day_of_visit DATE;

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);
