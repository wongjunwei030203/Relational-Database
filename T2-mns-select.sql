--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-mns-select.sql

--Student ID:
--Student Name:
--Unit Code:
--Applied Class No:

/* Comments for your marker:




*/

/*2(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT item_id, item_desc, item_stdcost, item_stock
FROM mns.item
WHERE item_stock >= 50
AND upper(item_desc) LIKE upper('%COMPOSITE%')
ORDER BY item_stock DESC, item_id ASC;

/*2(b)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT provider_code, (provider_title || '. ' || provider_fname || ' ' || provider_lname) AS provider_name
FROM mns.provider
JOIN mns.specialisation ON provider.spec_id = specialisation.spec_id
WHERE upper(specialisation.spec_name) = upper('Paediatric Dentistry')
ORDER BY provider_lname, provider_fname, provider_code;

/*2(c)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT service_code, service_desc, TO_CHAR(service_stdfee, '$9999.99') AS stdfee
FROM mns.service
WHERE service_stdfee > (SELECT AVG(service_stdfee) FROM mns.service)
ORDER BY service_stdfee DESC, service_code;

/*2(d)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT appt_no, appt_datetime, patient_no, patient_fname || ' ' || patient_lname AS patient_name, CONCAT('$', TO_CHAR(appt_fee, '9990.00')) AS appt_fee
FROM (SELECT appt_no, sum((NVL(apptserv_fee, 0) + NVL(apptserv_itemcost, 0))) as appt_fee
FROM mns.appt_serv
GROUP BY appt_no) NATURAL JOIN mns.appointment NATURAL JOIN mns.patient
WHERE appt_fee = (SELECT max(appt_fee) FROM (SELECT appt_no, sum((NVL(apptserv_fee, 0) + NVL(apptserv_itemcost, 0))) as appt_fee FROM mns.appt_serv GROUP BY appt_no))
ORDER BY appt_fee DESC, appt_no;

/*2(e)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT s.service_code, s.service_desc, TO_CHAR(s.service_stdfee, '$9999.99') AS std_fee, TO_CHAR(AVG(asv.apptserv_fee - s.service_stdfee), '$99990.99') AS difference
FROM mns.service s
LEFT JOIN mns.appt_serv asv ON s.service_code = asv.service_code
GROUP BY s.service_code, s.service_desc, s.service_stdfee
ORDER BY s.service_code;

/*2(f)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT
    p.patient_no,
    p.patient_fname || ' ' || p.patient_lname AS patientname,
    FLOOR(MONTHS_BETWEEN(SYSDATE, p.patient_dob) / 12) AS currentage,
    COUNT(a.appt_datetime) AS numappts,
    TO_CHAR((SUM(CASE WHEN a.appt_prior_apptno IS NOT NULL THEN 1 ELSE 0 END) / COUNT(a.appt_datetime) * 100), '9990.9') || '%' AS followups
FROM mns.patient p
LEFT JOIN mns.appointment a ON p.patient_no = a.patient_no
GROUP BY p.patient_no, p.patient_fname || ' ' || p.patient_lname, p.patient_dob
ORDER BY p.patient_no;

/*2(g)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT a.provider_code as pcode,
LPAD(CASE WHEN count(distinct(appt_no)) = 0 THEN '-' ELSE to_char(count(distinct(appt_no))) END, 10, ' ') AS numberappts,
LPAD(CASE WHEN sum(NVL(apptserv_fee,0) + NVL(apptserv_itemcost,0)) = 0 THEN '-' ELSE CONCAT('$',to_char((sum(NVL(apptserv_fee,0) + NVL(apptserv_itemcost,0))),'9990.00')) END, 10, ' ') AS totalfees,
LPAD(CASE WHEN count(apptserv_itemcost) = 0 THEN '-' ELSE to_char(count(apptserv_itemcost)) END, 10, ' ') AS noitems
FROM mns.provider a LEFT OUTER JOIN (SELECT * FROM mns.appointment NATURAL JOIN mns.appt_serv) b on a.provider_code = b.provider_code
GROUP BY a.provider_code;