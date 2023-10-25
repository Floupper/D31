-- Question 2
CREATE OR REPLACE TRIGGER TrigSupEmp
AFTER DELETE ON emp
FOR EACH ROW
BEGIN
    DECLARE numEmployes INT;
    DECLARE employesSansResponsable VARCHAR(255);
    DECLARE message VARCHAR(255);
    
    -- Afficher le message indiquant que l'employé a été supprimé
    SET message = CONCAT('Employé numéro ', OLD.empno, ' supprimé');
    
    -- Compter le nombre d'employés dont l'employé supprimé était le responsable hiérarchique
    SELECT COUNT(*) INTO numEmployes FROM emp WHERE mgr = OLD.empno;
    
    -- Si l'employé supprimé est responsable hiérarchique
    IF numEmployes > 0 THEN
        -- Récupérer les numéros des employés sans responsable
        SELECT GROUP_CONCAT(empno) INTO employesSansResponsable FROM emp WHERE mgr = OLD.empno;
        SET message = CONCAT(message, '. Les employés numéro(s) ', employesSansResponsable, ' se retrouvent sans responsable.');
    END IF;
    
    -- Afficher le message
    SELECT message AS Message;
END;
/

-- Question 3
CREATE OR REPLACE TRIGGER TrigQuotaSub
AFTER INSERT ON emp
FOR EACH ROW
DECLARE 
    numSubordonnes INT;
    responsable INT;
    message VARCHAR(255);
BEGIN     
    -- Récupérer l'ID du responsable de l'employé nouvellement inséré
    SELECT mgr INTO responsable FROM emp WHERE empno = NEW.mgr;
    
    -- Compter le nombre de subordonnés du responsable
    SELECT COUNT(*) INTO numSubordonnes FROM emp WHERE mgr = responsable;
    
    -- Si le responsable a plus de 4 subordonnés
    IF numSubordonnes > 4 THEN
        SET message = CONCAT('Alerte : Le responsable numéro ', responsable, ' encadre plus de 4 employés.');
        SELECT message AS Message;
    END IF;
END;
/

-- Question 5
CREATE TABLE log (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    table VARCHAR(255) NOT NULL,
    date DATETIME NOT NULL,
    username VARCHAR(50) NOT NULL,
    action VARCHAR(50) NOT NULL
);
