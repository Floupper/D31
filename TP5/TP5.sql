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

-- Question 12
CREATE FUNCTION revenuAnnuelPromoAnc(employe IN emp.empno%TYPE) RETURNS DECIMAL(10, 2)
IS 
BEGIN
    DECLARE salaire DECIMAL(8, 2);
    DECLARE exp DECIMAL(8, 2);

    SELECT sal INTO salaire FROM emp WHERE empno = employe;
    SELECT (extract(year from SYSDATE) - extract(year from hiredate)) INTO exp FROM emp WHERE empno = employe;

    IF exp < 10 THEN
        RETURN salaire * 12 + salaire;
    ELSE
        RETURN salaire * 12 * (1 + exp / 100);
    END IF;
END;
/

-- Question 13
CREATE OR REPLACE PACKAGE GestionFinanciere AS
    PROCEDURE augmentMontant(employe IN emp.empno%TYPE, montant IN emp.sal%TYPE) RETURN DECIMAL(10, 2);
    PROCEDURE afficheSalEmp(employe IN emp.empno%TYPE) RETURN DECIMAL(10, 2);
    PROCEDURE annuaire RETURN VARCHAR2;
    PROCEDURE augmentPourcent(employe IN emp.empno%TYPE, pourcent IN DECIMAL(5,2), nouvSal IN emp.sal%TYPE) RETURN DECIMAL(10, 2);
    FUNCTION revenuAnnuel(employe IN emp.empno%TYPE) RETURN DECIMAL(10, 2);
    FUNCTION revenuAnnuelPromoAnc(employe IN emp.empno%TYPE) RETURN DECIMAL(10, 2);
END GestionFinanciere;
/

-- Question 14
CREATE OR REPLACE PACKAGE BODY GestionFinanciere AS
    CREATE PROCEDURE augmentMontant(employe IN emp.empno%TYPE, montant IN emp.sal%TYPE)
    IS
    BEGIN
        UPDATE emp SET sal = sal + montant WHERE ename = employe;
        -- Fin de la transaction
        COMMIT;
    END;

    CREATE PROCEDURE afficheSalEmp(employe IN emp.empno%TYPE)
    IS
        salaire emp.sal%TYPE;
    BEGIN
        SELECT sal INTO salaire FROM emp WHERE ename = employe;
    END;

    CREATE PROCEDURE annuaire
    IS 
    BEGIN
        FOR emp IN (SELECT ename, job, dname FROM emp JOIN dept ON emp.deptno = dept.deptno)
        LOOP 
            DBMS_OUTPUT.PUT_LINE(emp.ename || ' - ' || emp.job || ' - ' || emp.dname);
        END LOOP;
    END;

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

    CREATE FUNCTION revenuAnnuelPromoAnc(employe IN emp.empno%TYPE) RETURNS DECIMAL(10, 2)
    IS 
    BEGIN
        DECLARE salaire DECIMAL(8, 2);
        DECLARE exp DECIMAL(8, 2);

        SELECT sal INTO salaire FROM emp WHERE empno = employe;
        SELECT (extract(year from SYSDATE) - extract(year from hiredate)) INTO exp FROM emp WHERE empno = employe;

        IF exp < 10 THEN
            RETURN salaire * 12 + salaire;
        ELSE
            RETURN salaire * 12 * (1 + exp / 100);
        END IF;
    END;

    CREATE FUNCTION revenuAnnuelPromoAnc(employe IN emp.empno%TYPE) RETURNS DECIMAL(10, 2)
    IS 
    BEGIN
        DECLARE salaire DECIMAL(8, 2);
        DECLARE exp DECIMAL(8, 2);

        SELECT sal INTO salaire FROM emp WHERE empno = employe;
        SELECT (extract(year from SYSDATE) - extract(year from hiredate)) INTO exp FROM emp WHERE empno = employe;

        IF exp < 10 THEN
            RETURN salaire * 12 + salaire;
        ELSE
            RETURN salaire * 12 * (1 + exp / 100);
        END IF;
    END;
END GestionFinanciere;
/

-- Question 16
CREATE TABLE mes_augmentations(
    empno NUMBER(5) NOT NULL,
    date_aug DATE NOT NULL,
    montant_aug NUMBER(6, 2) NOT NULL
);

-- Question 17
CREATE TRIGGER updateAugmentations
AFTER UPDATE ON emp
FOR EACH ROW
BEGIN
    -- Vérifier si l'employé a reçu une augmentation
    IF NEW.sal > OLD.sal THEN
        -- Insérer l'information dans la table mes_augmentations
        INSERT INTO mes_augmentations (empno, pourcentage, nouveau_salaire, date_augmentation)
        VALUES (NEW.empno, ((NEW.sal - OLD.sal) / OLD.sal) * 100, NEW.sal, NOW());
    END IF;
END:
/