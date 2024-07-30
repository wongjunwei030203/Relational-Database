--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-mns-alter.sql

--Student ID: 32845650
--Student Name: Wong Jun Wei
--Unit Code: FIT2094
--Applied Class No: 3

--4(a)
--adding new column (attribute) to the patient table
ALTER TABLE patient
ADD appointment_count NUMBER(4) DEFAULT 0;

UPDATE patient p
SET p.appointment_count = (
    SELECT COUNT(*) FROM appointment a
    WHERE a.patient_no = p.patient_no
);

SELECT * FROM patient;
DESC patient;

COMMIT;

--4(b)
--junction table between patient and emergency contact to allow for many-to-many rs
DROP TABLE patient_emergency_contact;

CREATE TABLE patient_emergency_contact (
    patient_no  NUMBER(4) NOT NULL,
    ec_id       NUMBER(4) NOT NULL
);

COMMENT ON COLUMN patient_emergency_contact.patient_no IS
    'Patient number';
    
COMMENT ON COLUMN patient_emergency_contact.ec_id IS
    'Emergency Contact ID';
    
INSERT INTO patient_emergency_contact (patient_no, ec_id)
SELECT patient_no, ec_id
FROM patient
WHERE ec_id IS NOT NULL;

ALTER TABLE patient
DROP COLUMN ec_id;

ALTER TABLE patient_emergency_contact 
ADD CONSTRAINT pt_ec_pk PRIMARY KEY (patient_no,ec_id);

ALTER TABLE patient_emergency_contact
    ADD CONSTRAINT pt_ec_fk1 FOREIGN KEY (patient_no)
        REFERENCES patient(patient_no);

ALTER TABLE patient_emergency_contact
    ADD CONSTRAINT pt_ec_fk2 FOREIGN KEY (ec_id)
        REFERENCES emergency_contact(ec_id);

COMMIT;

SELECT * FROM patient_emergency_contact;
DESC patient_emergency_contact;

--4(c)

DROP TABLE training_relationship;

CREATE TABLE training_relationship (
    training_nurse_no       NUMBER(3) NOT NULL,
    trainee_nurse_no       NUMBER(3) NOT NULL,
    training_start_datetime DATE NOT NULL,
    training_end_datetime   DATE NOT NULL,
    training_desc           VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN training_relationship.training_nurse_no IS
    'Training Nurse identifier (unique)';
    
COMMENT ON COLUMN training_relationship.trainee_nurse_no IS
    'Trainee nurse number';
    
COMMENT ON COLUMN training_relationship.training_start_datetime IS
    'Date and time of the training start';
    
COMMENT ON COLUMN training_relationship.training_end_datetime IS
    'Date and time of the training end';
    
COMMENT ON COLUMN training_relationship.training_desc IS
    'Training description';

ALTER TABLE training_relationship 
ADD CONSTRAINT tr_pk PRIMARY KEY (training_nurse_no, trainee_nurse_no, training_start_datetime);

ALTER TABLE training_relationship
ADD CONSTRAINT tr_fk FOREIGN KEY (trainee_nurse_no)
REFERENCES nurse(nurse_no);

COMMIT;