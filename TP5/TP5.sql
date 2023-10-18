-- Question 1 
start script.sql;

-- Question 2
CREATE PROCEDURE augmentMontant(employe IN emp.empno%TYPE, montant IN emp.sal%TYPE)
IS
BEGIN
    UPDATE emp SET sal = sal + montant WHERE ename = employe;
    -- Fin de la transaction
    COMMIT;
END;
/

-- DROP PROCEDURE augmentMontant;

-- Question 3
EXECUTE augmentMontant('KING', 100);

-- Question 4

-- Question 5
GRANT EXECUTE ON augmentMontant TO h.hartz;

-- Question 6
CREATE PROCEDURE afficheSalEmp(employe IN emp.empno%TYPE)
IS
    salaire emp.sal%TYPE;
BEGIN
    SELECT sal INTO salaire FROM emp WHERE ename = employe;
END;
/

EXECUTE afficheSalEmp('KING');


-- Question 7
CREATE PROCEDURE annuaire
IS 
BEGIN
    FOR emp IN (SELECT ename, job, dname FROM emp JOIN dept ON emp.deptno = dept.deptno)
    LOOP 
        DBMS_OUTPUT.PUT_LINE(emp.ename || ' - ' || emp.job || ' - ' || emp.dname);
    END LOOP;
END;
/

EXECUTE annuaire;


-- Question 8
CREATE PROCEDURE augmentPourcent(employe IN emp.empno%TYPE, pourcent IN DECIMAL(5,2), nouvSal IN emp.sal%TYPE)
IS
BEGIN 
    -- Déclaration des variables
    DECLARE salaireActuel DECIMAL(10, 2);

    -- Obtenir le salaire actuel de l'employé
    SELECT sal INTO salaireActuel FROM emp WHERE empno = employe;

    -- Calculer le nouveau salaire avec l'augmentation en pourcentage
    SET nouvSal = salaireActuel + (salaireActuel * pourcent / 100);

    -- Mettre à jour le salaire de l'employé
    UPDATE emp SET sal = nouvSal WHERE empno = employe;
    
    -- Fin de la transaction
    COMMIT;
END;
/


-- Question 10
CREATE FUNCTION revenuAnnuel(employe IN emp.empno%TYPE) RETURNS DECIMAL(10, 2)
IS
BEGIN
    DECLARE salaire DECIMAL(8, 2);
    DECLARE commission DECIMAL(8, 2);
    
    -- Récupérer le salaire de l'employé
    SELECT sal INTO salaire FROM emp WHERE empno = employe;
    
    -- Récupérer la commission de l'employé
    SELECT comm INTO commission FROM emp WHERE empno = employe;
    
    -- Si la commission est nulle, retourner seulement le salaire annuel
    IF commission IS NULL THEN
        RETURN salaire * 12;
    ELSE
        -- Si la commission existe, ajouter la commission au salaire et retourner le total annuel
        RETURN (salaire + commission) * 12;
    END IF;
END;
/