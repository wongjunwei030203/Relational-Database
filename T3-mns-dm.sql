--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-mns-dm.sql

--Student ID: 32845650
--Student Name: Wong Jun Wei
--Unit Code: FIT2094
--Applied Class No: 3

--3(a)
-- Drop and Create Sequence for EMERGENCY_CONTACT
DROP SEQUENCE emergency_contact_seq;
CREATE SEQUENCE emergency_contact_seq START WITH 100 INCREMENT BY 5;

-- Drop and Create Sequence for PATIENT
DROP SEQUENCE patient_seq;
CREATE SEQUENCE patient_seq START WITH 100 INCREMENT BY 5;

-- Drop and Create Sequence for APPOINTMENT
DROP SEQUENCE appointment_seq;
CREATE SEQUENCE appointment_seq START WITH 100 INCREMENT BY 5;

COMMIT;

--3(b)
INSERT INTO emergency_contact VALUES (
    emergency_contact_seq.NEXTVAL,
    'Jonathan',
    'Robey',
    '0412523122'
);

-- laura
INSERT INTO patient VALUES(
    patient_seq.NEXTVAL,
    'Laura',
    'Robey',
    '123 Elm Street',
    'Cityville',
    'VIC',
    '3000',
    TO_DATE('20/05/2010','DD/MM/YYYY'),
    '0492648392',
    'laurarobey@gmail.com',
    emergency_contact_seq.CURRVAL
);

--laura
INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL, -- appt number
    TO_DATE('04/09/2023 15:30','DD/MM/YYYY HH24:MI'),
    8, --appt room number
    'S', -- appt length
    patient_seq.CURRVAL,
    (
        SELECT provider_code
        FROM provider
        WHERE upper(provider_title) = upper('Dr')
        AND upper(provider_fname) = upper('Bruce')
        AND upper(provider_lname) = upper('Striplin')
    ),
    6, --nurse number
    NULL
);

-- lachlan
INSERT INTO patient VALUES(
    patient_seq.NEXTVAL,
    'Lachlan',
    'Robey',
    '123 Elm Street',
    'Cityville',
    'VIC',
    '3000',
    TO_DATE('20/05/2010','DD/MM/YYYY'),
    '0446927304',
    'lachlanrobey@gmail.com',
    emergency_contact_seq.CURRVAL
);

--lachlan
INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL, -- appt number
    TO_DATE('04/09/2023 16:00','DD/MM/YYYY HH24:MI'),
    8, -- appt room number
    'S',
    patient_seq.CURRVAL,
    (   SELECT provider_code
        FROM provider
        WHERE upper(provider_title) = upper('Dr')
        AND upper(provider_fname) = upper('Bruce')
        AND upper(provider_lname) = upper('Striplin')
    ),
    6,
    NULL
);

COMMIT;

--3(c)
--follow up from lachlan's first appt
INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL, -- appt number
    TO_DATE('04/09/2023 16:00','DD/MM/YYYY HH24:MI') + 10,
    8,
    'L',
    patient_seq.CURRVAL,
    (
        SELECT provider_code
        FROM provider
        WHERE upper(provider_title) = upper('Dr')
        AND upper(provider_fname) = upper('Bruce')
        AND upper(provider_lname) = upper('Striplin')
    ),
    14,
    appointment_seq.NEXTVAL
);

COMMIT;

--3(d)
--Updating Lachlan's follow-up appointment date and time
UPDATE appointment
SET appt_datetime = TO_DATE('04/09/2023 16:00','DD/MM/YYYY HH24:MI') + 14
WHERE patient_no = (
    SELECT patient_no
    FROM patient
    WHERE PATIENT_FNAME = 'Lachlan'
    AND PATIENT_LNAME = 'Robey'
)
AND appt_datetime = TO_DATE('14/09/2023 16:00', 'DD/MM/YYYY HH24:MI');

COMMIT;

--3(e)
--Deleting all appointments of Dr Bruce Striplin that fall within date range
DELETE FROM appointment
WHERE appt_no IN (
    SELECT appt_no
    FROM appointment
    WHERE provider_code = (
        SELECT provider_code
        FROM provider
        WHERE upper(provider_title) = upper('Dr')
        AND upper(provider_fname) = upper('Bruce')
        AND upper(provider_lname) = upper('Striplin')
    )
    AND appt_datetime BETWEEN TO_DATE('15/09/2023', 'DD/MM/YYYY') AND TO_DATE('22/09/2023', 'DD/MM/YYYY')
);

COMMIT;