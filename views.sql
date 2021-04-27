#### table 1: house_bills
use us_congress_db;
DROP VIEW IF EXISTS house_bills;

CREATE VIEW senate_bills AS
SELECT b.bill_code AS 'bill code', b.bill_description AS 'bill description', 
	bs.bill_stage_name AS 'current bill stage',
	DATEDIFF(CURRENT_DATE(), b.bill_introduction_date) AS 'days since introduced'
FROM bill b
JOIN bill_stage bs USING(bill_stage_id)
WHERE b.introduced_in_chamber = "Senate";


#### table 2: md_congressmen
use us_congress_db; 
DROP VIEW IF EXISTS md_congressmen;

CREATE VIEW md_congressmen AS
select CONCAT(m.member_first_name, ' ', m.member_last_name) AS 'member name',
	m.member_gender AS 'gender', m.member_date_of_birth AS 'date of birth',
	m.political_affiliation_id AS 'political party', 
        CONCAT(b.bill_code, ': ', b.bill_description) AS 'associating bill information'
FROM bill_sponsors bs
JOIN bill b USING(bill_id)
JOIN member m USING(member_id)
JOIN committee c USING(committee_id)
WHERE member_id IN (SELECT member_id
			FROM member
			WHERE member_state_id = 'MD')
ORDER BY member_last_name, chamber;


#### table 3: members_by_state
use us_congress_db;
DROP VIEW IF EXISTS members_by_state;

CREATE VIEW members_by_state AS
SELECT CONCAT(m.member_last_name, ', ', m.member_first_name) AS members, 
	m.chamber, m.member_state_id AS 'member_state', count(c.committee_id) AS 'num_committees'
 FROM congress.bill_sponsors
 join member m USING(member_id)
 join bill b USING(bill_id)
 join committee c USING(committee_id)
 group by members
 order by member_state, members









