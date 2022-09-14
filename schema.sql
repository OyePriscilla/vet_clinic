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