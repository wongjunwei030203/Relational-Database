--*****PLEASE ENTER YOUR DETAILS BELOW*****

--Student ID: 32845650
--Student Name: Wong Jun Wei
--Unit Code: FIT2094
--Applied Class No: 3

-- Task 1 Add Create table statements for the white TABLES below
-- Ensure all column comments, and constraints (other than FK's) are included.
-- FK constraints are to be added at the end of this script

-- TABLE: APPOINTMENT
CREATE TABLE appointment (

    appt_no             NUMBER(7) NOT NULL,
    appt_datetime       DATE NOT NULL,
    appt_roomno         NUMBER(2) NOT NULL,
    appt_length         CHAR(1) NOT NULL,
    patient_no          NUMBER(4) NOT NULL,
    provider_code       CHAR(6) NOT NULL,
    nurse_no            NUMBER(3) NOT NULL,
    appt_prior_apptno   NUMBER(7)
);

COMMENT ON COLUMN appointment.appt_no IS
    'Appointment number (identifier)';
    
COMMENT ON COLUMN appointment.appt_datetime IS
    'Date and time of the appointment';

COMMENT ON COLUMN appointment.appt_roomno IS
    'Room in which appointment is scheduled to take place';

COMMENT ON COLUMN appointment.appt_length IS
    'Length of appointment - Short, Standard or Long (S, T or L)';

COMMENT ON COLUMN appointment.patient_no IS
    'Patient who books the appointment';

COMMENT ON COLUMN appointment.provider_code IS
    'Provider who is assigned to the appointment';
    
COMMENT ON COLUMN appointment.nurse_no IS
    'Nurse who is assigned to the appointment';
    
COMMENT ON COLUMN appointment.appt_prior_apptno IS
    'Prior appointment number which leads to this appointment';

-- PK Constraint
ALTER TABLE appointment ADD CONSTRAINT appointment_pk PRIMARY KEY (appt_no);
-- Unique Constraints
ALTER TABLE appointment ADD CONSTRAINT appointment_nk UNIQUE (appt_datetime, appt_roomno, patient_no, provider_code, appt_prior_apptno);
-- Check Constraint
ALTER TABLE appointment ADD CONSTRAINT check_length CHECK (appt_length IN ('S', 'M', 'L'));

-- TABLE: EMERGENCY_CONTACT
CREATE TABLE emergency_contact (
    ec_id       NUMBER(4) NOT NULL,
    ec_fname    VARCHAR2(30),
    ec_lname    VARCHAR2(30),
    ec_phone    CHAR(10) NOT NULL 
);

-- Column Comments
COMMENT ON COLUMN emergency_contact.ec_id IS
    'Emergency contact identifier';
    
COMMENT ON COLUMN emergency_contact.ec_fname IS
    'Emergency contact first name';
    
COMMENT ON COLUMN emergency_contact.ec_lname IS
    'Emergency contact last name';
    
COMMENT ON COLUMN emergency_contact.ec_phone IS
    'Emergency contact phone number';

-- PK Constraint
ALTER TABLE emergency_contact ADD CONSTRAINT ec_pk PRIMARY KEY (ec_id);
-- Unique Constraint
ALTER TABLE emergency_contact ADD CONSTRAINT ec_nk UNIQUE (ec_phone);

-- TABLE: PATIENT
CREATE TABLE patient (
    patient_no              NUMBER(4) NOT NULL,
    patient_fname           VARCHAR2(30),
    patient_lname           VARCHAR2(30),
    patient_street          VARCHAR2(50) NOT NULL,
    patient_city            VARCHAR2(20) NOT NULL,
    patient_state           VARCHAR2(3) NOT NULL,
    patient_postcode        CHAR(4) NOT NULL,
    patient_dob             DATE NOT NULL,
    patient_contactmobile   CHAR(10) NOT NULL,
    patient_contactemail    VARCHAR2(25) NOT NULL,
    ec_id NUMBER(4)         NOT NULL
);

COMMENT ON COLUMN patient.patient_no IS
    'Patient number';
    
COMMENT ON COLUMN patient.patient_fname IS
    'Patient first name';
    
COMMENT ON COLUMN patient.patient_lname IS
    'Patient last name';
    
COMMENT ON COLUMN patient.patient_street IS
    'Patient residential street address';
    
COMMENT ON COLUMN patient.patient_city IS
    'Patient residential city';
    
COMMENT ON COLUMN patient.patient_state IS
    'Patient residential state';
    
COMMENT ON COLUMN patient.patient_postcode IS
    'Patient residential postcode';
    
COMMENT ON COLUMN patient.patient_dob IS
    'Patient date of birth';
    
COMMENT ON COLUMN patient.patient_contactmobile IS
    'Patient contact mobile number';
    
COMMENT ON COLUMN patient.patient_contactemail IS 
    'Patient contact email address';
    
-- PK Constraint
ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY (patient_no);
-- Check Constraint
ALTER TABLE patient ADD CONSTRAINT check_state CHECK (patient_state IN ('NT', 'QLD', 'NSW', 'ACT', 'VIC', 'TAS', 'SA', 'WA'));

-- Add all missing FK Constraints below here
ALTER TABLE appointment
    ADD CONSTRAINT appointment_fk1 FOREIGN KEY (patient_no)
        REFERENCES patient(patient_no);
            
ALTER TABLE appointment
    ADD CONSTRAINT appointment_fk2 FOREIGN KEY (provider_code)
        REFERENCES provider(provider_code);
            
ALTER TABLE appointment
    ADD CONSTRAINT appointment_fk3 FOREIGN KEY (nurse_no)
        REFERENCES nurse(nurse_no);
            
ALTER TABLE appointment
    ADD CONSTRAINT appointment_fk4 FOREIGN KEY (appt_prior_apptno)
        REFERENCES appointment(appt_no);

ALTER TABLE patient 
    ADD CONSTRAINT patient_fk1 FOREIGN KEY (ec_id)
        REFERENCES emergency_contact(ec_id);
