--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-mns-json.sql

--Student ID:
--Student Name:
--Unit Code:
--Applied Class No:

/* Comments for your marker:




*/

/*3(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT TO GENERATE 
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT JSON_OBJECT('_id' VALUE a.appt_no,
    'datetime' VALUE TO_CHAR(a.appt_datetime, 'DD/MM/YYYY HH24:MI'),
    'provider_code' VALUE b.provider_code,
    'provider_name' VALUE b.provider_title || '' || b.provider_fname || ' ' || b.provider_lname,
    'item_totalcost' VALUE SUM(c.as_item_quantity * d.item_stdcost),
    'no_of_items' VALUE COUNT(c.item_id),
    'items' VALUE JSON_ARRAYAGG(
      JSON_OBJECT('id' VALUE c.item_id,
        'desc' VALUE d.item_desc,
        'standardcost' VALUE d.item_stdcost,
        'quantity' VALUE c.as_item_quantity)
      ) FORMAT JSON)
   || ','

FROM mns.appointment a
JOIN mns.provider b ON a.provider_code = b.provider_code
LEFT JOIN mns.apptservice_item c ON a.appt_no = c.appt_no
JOIN mns.item d on c.item_id = d.item_id
WHERE c.item_id IS NOT NULL
GROUP BY a.appt_no, appt_datetime, b.provider_code, provider_title, provider_fname, provider_lname
ORDER BY a.appt_no;