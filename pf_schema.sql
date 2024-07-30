-- start spooling output to pf_schema_output.txt
set echo on
SPOOL pf_schema_output.txt

-- dropping all the tables of they already exist
DROP TABLE clinic CASCADE CONSTRAINTS;
DROP TABLE drug CASCADE CONSTRAINTS;
DROP TABLE pet CASCADE CONSTRAINTS;
DROP TABLE pet_owner CASCADE CONSTRAINTS;
DROP TABLE pet_type CASCADE CONSTRAINTS;
DROP TABLE prescription CASCADE CONSTRAINTS;
DROP TABLE service CASCADE CONSTRAINTS;
DROP TABLE service_provided CASCADE CONSTRAINTS;
DROP TABLE specialization CASCADE CONSTRAINTS;
DROP TABLE training CASCADE CONSTRAINTS;
DROP TABLE vet CASCADE CONSTRAINTS;
DROP TABLE vet_training CASCADE CONSTRAINTS;
DROP TABLE visit CASCADE CONSTRAINTS;

-- create the clinic table with all constraints
CREATE TABLE clinic (
    clinic_id       NUMBER(2) NOT NULL,
    clinic_name     VARCHAR2(30) NOT NULL,
    clinic_address  VARCHAR2(50) NOT NULL,
    clinic_phone_no NUMBER(10) NOT NULL
);


-- adding comments to the columns of the clinic table
COMMENT ON COLUMN clinic.clinic_id IS
    'Clinic ID';

COMMENT ON COLUMN clinic.clinic_name IS
    'Clinic Name';

COMMENT ON COLUMN clinic.clinic_address IS
    'Clinic address';

COMMENT ON COLUMN clinic.clinic_phone_no IS
    'Clinic phone number';

-- adding a primary key constraint to the clinic table on the clinic_id column
ALTER TABLE clinic ADD CONSTRAINT clinic_pk PRIMARY KEY ( clinic_id );


-- creating the drug table with columns for ID, name, usage information, and charge
CREATE TABLE drug (
    drug_id         NUMBER(3) NOT NULL,
    drug_name       VARCHAR2(30) NOT NULL,
    drug_usage_info VARCHAR2(50) NOT NULL,
    drug_charge     NUMBER(5, 2) NOT NULL
);

-- adding comments to the columns of the drug table
COMMENT ON COLUMN drug.drug_id IS
    'Drug ID';

COMMENT ON COLUMN drug.drug_name IS
    'Drug name';

COMMENT ON COLUMN drug.drug_usage_info IS
    'Usage information of the drug';

COMMENT ON COLUMN drug.drug_charge IS
    'Cost for each drug';

-- adding a primary key constraint to the drug table on the drug_id column
ALTER TABLE drug ADD CONSTRAINT drug_pk PRIMARY KEY ( drug_id );

-- creating the pet table with columns for ID, type ID, owner ID, name, birth year, and alive status
CREATE TABLE pet (
    pet_id           NUMBER(3) NOT NULL,
    pet_type_id      CHAR(5) NOT NULL,
    owner_id         NUMBER(3) NOT NULL,
    pet_name         VARCHAR2(30) NOT NULL,
    pet_birthyear    NUMBER(4) NOT NULL,
    pet_alive_status CHAR(1) NOT NULL
);

-- adding a check constraint to the pet_alive_status column to ensure it is either 'Y' or 'N'
ALTER TABLE pet
    ADD CONSTRAINT alive CHECK ( pet_alive_status IN ( 'N', 'Y' ) );

COMMENT ON COLUMN pet.pet_id IS
    'Pet ID';

COMMENT ON COLUMN pet.pet_type_id IS
    'ID of the pet (animal type)';

COMMENT ON COLUMN pet.owner_id IS
    'Pet owner ID';

COMMENT ON COLUMN pet.pet_name IS
    'Pet name';

COMMENT ON COLUMN pet.pet_birthyear IS
    'Birth year of the pet';

COMMENT ON COLUMN pet.pet_alive_status IS
    'Alive status of the pet';

-- adding a primary key constraint to the pet table on the pet_id column
ALTER TABLE pet ADD CONSTRAINT pet_pk PRIMARY KEY ( pet_id );

-- creating the pet_owner table with columns for ID, given name, family name, and phone number
CREATE TABLE pet_owner (
    owner_id       NUMBER(3) NOT NULL,
    owner_gname    VARCHAR2(20) NOT NULL,
    owner_fname    VARCHAR2(20) NOT NULL,
    owner_phone_no NUMBER(10) NOT NULL
);

COMMENT ON COLUMN pet_owner.owner_id IS
    'Pet owner ID';

COMMENT ON COLUMN pet_owner.owner_gname IS
    'Owner given name';

COMMENT ON COLUMN pet_owner.owner_fname IS
    'Owner family name';

COMMENT ON COLUMN pet_owner.owner_phone_no IS
    'Owner phone number';

-- adding a primary key constraint to the pet_owner table on the owner_id column
ALTER TABLE pet_owner ADD CONSTRAINT owner_pk PRIMARY KEY ( owner_id );

-- creating the pet_type table with columns for ID and name
CREATE TABLE pet_type (
    pet_type_id   CHAR(5) NOT NULL,
    pet_type_name VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN pet_type.pet_type_id IS
    'ID of the pet (animal type)';

COMMENT ON COLUMN pet_type.pet_type_name IS
    'Name of the pet type (animal type)';

-- adding a primary key constraint to the pet_type table on the pet_type_id column
ALTER TABLE pet_type ADD CONSTRAINT animal_type_pk PRIMARY KEY ( pet_type_id );

-- creating the prescription table with columns for drug ID, visit ID, quantity, line cost, dosage, and frequency of administration
CREATE TABLE prescription (
    drug_id                     NUMBER(3) NOT NULL,
    visit_id                    CHAR(5) NOT NULL,
    drug_quantity               NUMBER(2) NOT NULL,
    drug_line_cost              NUMBER(5, 2) NOT NULL,
    drug_dosage                 VARCHAR2(20) NOT NULL,
    drug_freq_of_administration VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN prescription.drug_id IS
    'Drug ID';

COMMENT ON COLUMN prescription.visit_id IS
    'Visit ID';

COMMENT ON COLUMN prescription.drug_quantity IS
    'Drug quantitiy provided';

COMMENT ON COLUMN prescription.drug_line_cost IS
    'Drug line cost';

COMMENT ON COLUMN prescription.drug_dosage IS
    'Drug dosage';

COMMENT ON COLUMN prescription.drug_freq_of_administration IS
    'The frequency of administration of the drug';

-- adding a primary key constraint to the prescription table on the visit_id and drug_id columns
ALTER TABLE prescription ADD CONSTRAINT prescription_pk PRIMARY KEY ( visit_id,
                                                                      drug_id );

-- creating the service table with columns for visit ID, service code, and service line cost
CREATE TABLE service (
    visit_id          CHAR(5) NOT NULL,
    service_code      CHAR(5) NOT NULL,
    service_line_cost NUMBER(5, 2) NOT NULL
);

COMMENT ON COLUMN service.visit_id IS
    'Visit ID';

COMMENT ON COLUMN service.service_code IS
    'Code for the service';

COMMENT ON COLUMN service.service_line_cost IS
    'Service line cost';

-- adding a primary key constraint to the service table on the visit_id and service_code columns
ALTER TABLE service ADD CONSTRAINT service_pk PRIMARY KEY ( service_code,
                                                            visit_id );

-- creating the service_provided table with columns for service code, description, and charge
CREATE TABLE service_provided (
    service_code   CHAR(5) NOT NULL,
    service_desc   VARCHAR2(30) NOT NULL,
    service_charge NUMBER(5, 2) NOT NULL
);

COMMENT ON COLUMN service_provided.service_code IS
    'Code for the service';

COMMENT ON COLUMN service_provided.service_desc IS
    'Description of the service';

COMMENT ON COLUMN service_provided.service_charge IS
    'Charge for a particular service';

-- adding a primary key constraint to the service_provided table on the service_code column
ALTER TABLE service_provided ADD CONSTRAINT service_provided_pk PRIMARY KEY ( service_code
);

-- creating the specialization table with columns for ID and name
CREATE TABLE specialization (
    specialization_id   CHAR(5) NOT NULL,
    specialization_name VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN specialization.specialization_id IS
    'ID for the vet''s specialization area';

COMMENT ON COLUMN specialization.specialization_name IS
    'Name of the vet''s specialization area';

-- adding a primary key constraint to the specialization table on the specialization_id column
ALTER TABLE specialization ADD CONSTRAINT specialization_pk PRIMARY KEY ( specialization_id
);

-- creating the training table with columns for ID, clinic ID, vet ID, title, date and time, and duration
CREATE TABLE training (
    training_id        NUMBER(3) NOT NULL,
    clinic_id          NUMBER(2) NOT NULL,
    vet_id             NUMBER(3) NOT NULL,
    training_title     VARCHAR2(50) NOT NULL,
    training_date_time DATE NOT NULL,
    training_duration  NUMBER(5, 5) NOT NULL
);

COMMENT ON COLUMN training.training_id IS
    'Training ID';

COMMENT ON COLUMN training.clinic_id IS
    'Clinic ID';

COMMENT ON COLUMN training.vet_id IS
    'Vet ID';

COMMENT ON COLUMN training.training_title IS
    'Training title';

COMMENT ON COLUMN training.training_date_time IS
    'Training date and time';

COMMENT ON COLUMN training.training_duration IS
    'Duration of the training course';

-- adding a primary key constraint to the training table on the training_id column
ALTER TABLE training ADD CONSTRAINT training_pk PRIMARY KEY ( training_id );

-- creating the vet table with columns for ID, clinic ID, given name, family name, phone number, employment date, specialization ID, and training clinic ID
CREATE TABLE vet (
    vet_id              NUMBER(3) NOT NULL,
    clinic_id           NUMBER(2) NOT NULL,
    vet_fname           VARCHAR2(10) NOT NULL,
    vet_gname           VARCHAR2(10),
    vet_phone_no        CHAR(10) NOT NULL,
    vet_employment_date DATE NOT NULL,
    specialization_id   CHAR(5),
    training_clinic_id  NUMBER(2)
);

COMMENT ON COLUMN vet.vet_id IS
    'Vet ID';

COMMENT ON COLUMN vet.clinic_id IS
    'Clinic ID';

COMMENT ON COLUMN vet.vet_fname IS
    'Vet family name';

COMMENT ON COLUMN vet.vet_gname IS
    'Vet given name';

COMMENT ON COLUMN vet.vet_phone_no IS
    'Contact number for vet';

COMMENT ON COLUMN vet.vet_employment_date IS
    'Employment date of each vet';

COMMENT ON COLUMN vet.specialization_id IS
    'ID for the vet''s specialization area';

COMMENT ON COLUMN vet.training_clinic_id IS
    'Clinic ID';

-- Create a unique index named vet__idx on the training_clinic_id column of the vet table in ascending order
CREATE UNIQUE INDEX vet__idx ON
    vet (
        training_clinic_id
    ASC );

-- adding a primary key constraint to the vet table on the vet_id column
ALTER TABLE vet ADD CONSTRAINT vet_pk PRIMARY KEY ( vet_id );

-- creating the vet_training table with columns for training ID, vet ID, course completion status, and expiry date
CREATE TABLE vet_training (
    training_id          NUMBER(3) NOT NULL,
    vet_id               NUMBER(3) NOT NULL,
    vet_course_completed CHAR(1) NOT NULL,
    vet_course_expiry    DATE
);

-- adding a check constraint to the vet_course_completed column to ensure it is either 'Y' or 'N'
ALTER TABLE vet_training
    ADD CONSTRAINT completed CHECK ( vet_course_completed IN ( 'N', 'Y' ) );

COMMENT ON COLUMN vet_training.training_id IS
    'Training ID';

COMMENT ON COLUMN vet_training.vet_id IS
    'Vet ID';

COMMENT ON COLUMN vet_training.vet_course_completed IS
    'Vet course completion';

COMMENT ON COLUMN vet_training.vet_course_expiry IS
    'Vet course expiry date';

-- adding a primary key constraint to the vet_training table on the training_id and vet_id columns
ALTER TABLE vet_training ADD CONSTRAINT participant_pk PRIMARY KEY ( training_id,
                                                                     vet_id );

-- creating the visit table with columns for ID, date and time, pet ID, vet ID, follow-up visit ID, clinic ID, amount, payment method, pet weight, duration, and notes
CREATE TABLE visit (
    visit_id             CHAR(5) NOT NULL,
    visit_date_time      DATE NOT NULL,
    pet_id               NUMBER(3) NOT NULL,
    vet_id               NUMBER(3) NOT NULL,
    follow_up_visit_id   CHAR(5),
    clinic_id            NUMBER(2) NOT NULL,
    visit_amount         NUMBER(6, 2) NOT NULL,
    visit_payment_method CHAR(1) NOT NULL,
    visit_pet_weight     NUMBER(3) NOT NULL,
    visit_duration       NUMBER(2, 2) NOT NULL,
    visit_notes          VARCHAR2(300) NOT NULL
);

-- adding a check constraint to the visit_payment_method column to ensure it is either 'C' or 'E'
ALTER TABLE visit
    ADD CONSTRAINT "Payment method" CHECK ( visit_payment_method IN ( 'C', 'E' ) );

COMMENT ON COLUMN visit.visit_id IS
    'Visit ID';

COMMENT ON COLUMN visit.visit_date_time IS
    'Visit date and time';

COMMENT ON COLUMN visit.pet_id IS
    'Pet ID';

COMMENT ON COLUMN visit.vet_id IS
    'Vet ID';

COMMENT ON COLUMN visit.follow_up_visit_id IS
    'Visit ID';

COMMENT ON COLUMN visit.clinic_id IS
    'Clinic ID';

COMMENT ON COLUMN visit.visit_amount IS
    'Visit amount';

COMMENT ON COLUMN visit.visit_payment_method IS
    'Visit payment method';

COMMENT ON COLUMN visit.visit_pet_weight IS
    'Visiting pet weight';

COMMENT ON COLUMN visit.visit_duration IS
    'Duration of each visit ';

COMMENT ON COLUMN visit.visit_notes IS
    'Additional notes for each visit';

-- adding a primary key constraint to the visit table on the visit_id column
ALTER TABLE visit ADD CONSTRAINT visit_pk PRIMARY KEY ( visit_id );

-- creating foreign key constraints for the visit table
ALTER TABLE visit ADD CONSTRAINT key_2 UNIQUE ( visit_date_time,
                                                pet_id );

-- Alter the prescription table to add a foreign key constraint
ALTER TABLE prescription
    -- Add a foreign key constraint named appears_in on the drug_id column
    ADD CONSTRAINT appears_in FOREIGN KEY ( drug_id )
        -- Reference the drug_id column in the drug table
        REFERENCES drug ( drug_id );


ALTER TABLE visit
    ADD CONSTRAINT attends FOREIGN KEY ( pet_id )
        REFERENCES pet ( pet_id );

ALTER TABLE vet
    ADD CONSTRAINT base_of FOREIGN KEY ( clinic_id )
        REFERENCES clinic ( clinic_id );

ALTER TABLE pet
    ADD CONSTRAINT belongs FOREIGN KEY ( pet_type_id )
        REFERENCES pet_type ( pet_type_id );

ALTER TABLE visit
    ADD CONSTRAINT follow_up FOREIGN KEY ( follow_up_visit_id )
        REFERENCES visit ( visit_id );

ALTER TABLE service
    ADD CONSTRAINT gave FOREIGN KEY ( visit_id )
        REFERENCES visit ( visit_id );

ALTER TABLE visit
    ADD CONSTRAINT has FOREIGN KEY ( clinic_id )
        REFERENCES clinic ( clinic_id );

ALTER TABLE visit
    ADD CONSTRAINT hasv1 FOREIGN KEY ( vet_id )
        REFERENCES vet ( vet_id );

ALTER TABLE prescription
    ADD CONSTRAINT hasv2 FOREIGN KEY ( visit_id )
        REFERENCES visit ( visit_id );

ALTER TABLE vet
    ADD CONSTRAINT head_of FOREIGN KEY ( training_clinic_id )
        REFERENCES clinic ( clinic_id );

ALTER TABLE vet_training
    ADD CONSTRAINT "is" FOREIGN KEY ( vet_id )
        REFERENCES vet ( vet_id );

ALTER TABLE pet
    ADD CONSTRAINT owns FOREIGN KEY ( owner_id )
        REFERENCES pet_owner ( owner_id );

ALTER TABLE vet_training
    ADD CONSTRAINT participates_in FOREIGN KEY ( training_id )
        REFERENCES training ( training_id );

ALTER TABLE service
    ADD CONSTRAINT provided FOREIGN KEY ( service_code )
        REFERENCES service_provided ( service_code );

ALTER TABLE training
    ADD CONSTRAINT provides FOREIGN KEY ( clinic_id )
        REFERENCES clinic ( clinic_id );

ALTER TABLE training
    ADD CONSTRAINT providesv1 FOREIGN KEY ( vet_id )
        REFERENCES vet ( vet_id );

ALTER TABLE vet
    ADD CONSTRAINT specializes FOREIGN KEY ( specialization_id )
        REFERENCES specialization ( specialization_id );

-- end spooling output to pf_schema_output.txt        
SPOOL off

set echo off