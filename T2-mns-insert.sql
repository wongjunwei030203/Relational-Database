--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-mns-insert.sql

--Student ID: 32845650
--Student Name: Wong Jun Wei
--Unit Code: FIT2094
--Applied Class No: 3

/* Comments for your marker:




*/

--------------------------------------
--INSERT INTO emergency_contact
--------------------------------------
INSERT INTO emergency_contact VALUES (
    23,
    'Michael',
    'Jordan',
    '0407967469'
);

INSERT INTO emergency_contact VALUES (
    7,
    'Cristiano',
    'Ronaldo',
    '0562193527'
);

INSERT INTO emergency_contact VALUES (
    32,
    'Magic',
    'Johnson',
    '0498148690'
);

INSERT INTO emergency_contact VALUES (
    69,
    'Quandale',
    'Dingle',
    '0526790846'
);

INSERT INTO emergency_contact VALUES (
    37,
    'Andrew',
    'Tate',
    '0435057043'
);

--------------------------------------
--INSERT INTO patient
--------------------------------------
INSERT INTO patient VALUES (
    2,
    'James',
    'Bond',
    '5 Passage Avenue',
    'Clifton Beach',
    'QLD',
    '4879',
    TO_DATE('20/09/1988','DD/MM/YYYY'),
    '0557960816',
    'jamesbond@gmail.com',
    23
);

INSERT INTO patient VALUES (
    39,
    'Conor',
    'McGregor',
    '80 Normans Road',
    'Warrock',
    'VIC',
    '3312',
    TO_DATE('14/07/1978','DD/MM/YYYY'),
    '0591473261',
    'conormcgregor@gmail.com',
    23
);

INSERT INTO patient VALUES (
    83,
    'Dana',
    'White',
    '65 Gloucester Avenue',
    'Renown Park',
    'SA',
    '5008',
    TO_DATE('28/07/1969','DD/MM/YYYY'),
    '0502748062',
    'danawhite@gmail.com',
    23
);

INSERT INTO patient VALUES (
    77,
    'Barack',
    'Obama',
    '21 Peterho Boulevard',
    'Munno Para Downs',
    'SA',
    '5115',
    TO_DATE('04/08/1961','DD/MM/YYYY'),
    '0445428962',
    'barackobama@gmail.com',
    7
);

INSERT INTO patient VALUES (
    37,
    'Arthur',
    'Morgan',
    '56 Cherokee Road',
    'Laanecoorie',
    'VIC',
    '3463',
    TO_DATE('23/05/1945','DD/MM/YYYY'),
    '0419907257',
    'arthurmorgan@hotmail.com',
    7
);

INSERT INTO patient VALUES (
    99,
    'Logan',
    'Paul',
    '40 Porana Place',
    'Tardun',
    'WA',
    '6628',
    TO_DATE('27/12/2008','DD/MM/YYYY'),
    '0506976602',
    'loganpaul@gmail.com',
    7
);

INSERT INTO patient VALUES (
    38,
    'Tony',
    'Leung',
    '43 Woodwark Crescent',
    'Kairi',
    'QLD',
    '4872',
    TO_DATE('27/06/2009','DD/MM/YYYY'),
    '0462415834',
    'leungchiuwai@gmail.com',
    32
);

INSERT INTO patient VALUES (
    89,
    'Maggie',
    'Cheung',
    '87 Kopkes Road',
    'Illabarook',
    'VIC',
    '3351',
    TO_DATE('20/09/2010','DD/MM/YYYY'),
    '0441130450',
    'cheungmanyuk@yahoo.com',
    69
);

INSERT INTO patient VALUES (
    90,
    'Andy',
    'Lau',
    '90 Carlisle Street',
    'Strathbogie',
    'VIC',
    '3666',
    TO_DATE('27/09/2006','DD/MM/YYYY'),
    '0508549409',
    'lautakwah@hotmail.com',
    37
);

INSERT INTO patient VALUES (
    56,
    'Bruce',
    'Lee',
    '45 Wallis Street',
    'Tamarama',
    'NSW',
    '2026',
    TO_DATE('27/11/2013','DD/MM/YYYY'),
    '0542872731',
    'brucelee@yahoo.com',
    32
);

INSERT INTO patient VALUES (
    69,
    'Donnie',
    'Yen',
    '35 Yangan Drive',
    'Gulf Creek',
    'NSW',
    '2347',
    TO_DATE('03/02/2014','DD/MM/YYYY'),
    '0267688328',
    'donnieyen@gmail.com',
    69
);

--------------------------------------
--INSERT INTO appointment
--------------------------------------

--the three appointment dates are 
--07-MAY-2023
--16-JUN-2023
--25-JUL-2023

--start of 2 appointments
INSERT INTO appointment VALUES (
    42,
    TO_DATE('07/05/2023 10:00','DD/MM/YYYY HH24:MI'),
    16,
    'M',
    37,
    'PER002',
    6,
    NULL
);

--follow up for prev appt (2/2)
INSERT INTO appointment VALUES (
    19,
    TO_DATE('07/05/2023 14:30','DD/MM/YYYY HH24:MI'),
    86,
    'M',
    37,
    'PER002',
    11,
    42
);

--parallel appt with the next
INSERT INTO appointment VALUES (
    7,
    TO_DATE('07/05/2023 15:30','DD/MM/YYYY HH24:MI'),
    67,
    'S',
    89,
    'END001',
    8,
    NULL
);

--parallel appt with the previous
INSERT INTO appointment VALUES (
    48,
    TO_DATE('07/05/2023 15:30','DD/MM/YYYY HH24:MI'),
    24,
    'L',
    99,
    'GEN002',
    3,
    NULL
);

--independent appt
INSERT INTO appointment VALUES (
    58,
    TO_DATE('07/05/2023 16:00','DD/MM/YYYY HH24:MI'),
    8,
    'M',
    2,
    'GEN001',
    15,
    NULL
);

-- first of 2 appointments
INSERT INTO appointment VALUES (
    93,
    TO_DATE('16/06/2023 10:00','DD/MM/YYYY HH24:MI'),
    67,
    'L',
    77,
    'GEN003',
    10,
    NULL
);

-- independent appointment
INSERT INTO appointment VALUES (
    32,
    TO_DATE('16/06/2023 11:30','DD/MM/YYYY HH24:MI'),
    6,
    'M',
    69,
    'ORS001',
    9,
    NULL
);

-- independent appointment
INSERT INTO appointment VALUES (
    41,
    TO_DATE('16/06/2023 12:30','DD/MM/YYYY HH24:MI'),
    16,
    'M',
    38,
    'PED001',
    12,
    NULL
);

-- second of 2 appointments (follow up from first in the morning)
INSERT INTO appointment VALUES (
    76,
    TO_DATE('16/06/2023 15:00','DD/MM/YYYY HH24:MI'),
    67,
    'M',
    77,
    'GEN003',
    4,
    93
);

-- first of 2 appointments (second is on 25/7/2023)
INSERT INTO appointment VALUES (
    23,
    TO_DATE('16/06/2023 15:30','DD/MM/YYYY HH24:MI'),
    86,
    'M',
    39,
    'PED002',
    5,
    NULL
);

-- second of 2 appts (follow up from previous appt)
INSERT INTO appointment VALUES (
    5,
    TO_DATE('25/07/2023 09:00','DD/MM/YYYY HH24:MI'),
    6,
    'M',
    39,
    'PED002',
    7,
    23
);

-- parallel appt with the next
INSERT INTO appointment VALUES (
    78,
    TO_DATE('25/07/2023 11:00','DD/MM/YYYY HH24:MI'),
    3,
    'M',
    83,
    'ORT001',
    14,
    NULL
);

-- parallel appt with the previous AND first of 1/2 appts (2nd one is later on)
INSERT INTO appointment VALUES (
    29,
    TO_DATE('25/07/2023 11:00','DD/MM/YYYY HH24:MI'),
    45,
    'L',
    90,
    'AST002',
    13,
    NULL
);

-- independent appt
INSERT INTO appointment VALUES (
    45,
    TO_DATE('25/07/2023 13:00','DD/MM/YYYY HH24:MI'),
    55,
    'L',
    56,
    'PER001',
    2,
    NULL
);

-- second of 2/2 appts
INSERT INTO appointment VALUES (
    71,
    TO_DATE('25/07/2023 15:00','DD/MM/YYYY HH24:MI'),
    24,
    'S',
    90,
    'AST002',
    1,
    29
);