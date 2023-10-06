-- Question 2
SELECT * FROM h_hartz.mespays; -- renvoie rien, j'ai pas les droits

-- Question 3
GRANT select ON mespays TO h_hartz; -- Maintenant il peut voir ma table, et moi aussi (il m'a donné les droits)

-- Question 4
ALTER TABLE mespays DISABLE CONSTRAINT fk_countries_capital; -- Il a privilège insuffisant, car je lui ai pas donnée les droits de modif

-- Question 5
GRANT insert ON mespays TO h_hartz; -- Il peut insérer la ligne de commande
-- On voit la ligne mais pas les infos, avec un <commit;> on voit les infos;
ALTER TABLE mespays ENABLE CONSTRAINT fk_countries_capital;

-- Question 6
GRANT update (code2) ON mespays TO h_hartz;
UPDATE h_hartz.mespays
SET code2 = 'RO'
WHERE country_id = 'ROM';

-- Question 7
GRANT delete ON mespays TO h_hartz;
DELETE FROM h_hartz.mespays
WHERE country_id = 'ROM';

-- Question 8
REVOKE select, insert, delete, update ON mespays FROM h_hartz;

-- Question 9
GRANT select ON mespays TO h_hartz WITH GRANT OPTION;

-- Question 10
SELECT privilege, grantor, grantee FROM USER_TAB_PRIVS WHERE LOWER(table_name)='mespays';

-- Question 11
SELECT table_name, grantor, privilege FROM USER_TAB_PRIVS_RECD;

-- Question 12
REVOKE select ON mespays FROM h_hartz;


-- Question 13
CREATE SYNONYM mesvilles_hh FOR h_hartz.mesvilles;

-- Question 14
GRANT select ON mesvilles TO h_hartz WITH GRANT OPTION;

-- Question 15
GRANT select ON meslangues TO PUBLIC;
REVOKE select ON meslangues FROM PUBLIC;

-- Question 16
CREATE TABLE monemp AS SELECT * FROM iin_bigemp WHERE empno<8000;

-- Question 17
CREATE VIEW intranet AS
SELECT empno, ename, job, sal
FROM monemp
WHERE deptno IN (10, 20, 30);

CREATE VIEW internet AS
SELECT COUNT(*) AS "Nombre d'employés", SUM(sal) AS "Masse salariale"
FROM monemp;