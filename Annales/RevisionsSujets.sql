-- Question 1
-- Requête 1:
-- Requête : SELECT noclient, lower(nom) FROM clients WHERE noclient BETWEEN 6000 AND 7000;
-- Utilisation d'index : Oui
-- Index utilisé : idx_client_noclient_lnom_lpays
-- Explication : L'index idx_client_noclient_lnom_lpays est utilisé pour effectuer une recherche par plage sur la colonne noclient. Cela permet d'optimiser la recherche des clients dont le numéro se situe entre 6000 et 7000.

-- Requête 2:
-- Requête : SELECT noclient FROM clients WHERE noclient > 8000;
-- Utilisation d'index : Oui
-- Index utilisé : PK_client (clé primaire)
-- Explication : L'index de clé primaire PK_client est utilisé pour effectuer une recherche rapide des clients dont le numéro est supérieur à 8000. Cette approche est efficace car la clé primaire garantit l'unicité des valeurs et permet un accès direct aux enregistrements.

-- Requête 3:
-- Requête : SELECT noclient, tel FROM clients WHERE noclient > 8000;
-- Utilisation d'index : Non
-- Explication : Dans ce cas, il n'y a pas d'index spécifique utilisé. La requête effectue un parcours complet de la table (TABLE ACCESS FULL) pour récupérer les numéros de client et les numéros de téléphone des clients dont le numéro est supérieur à 8000. Cette approche peut être moins efficace en termes de performances, car elle nécessite de parcourir tous les enregistrements de la table.


-- Question 2
CREATE OR REPLACE PROCEDURE AjoutLigneCMD(numCMD INT, numLivre INT, qte INT, reduc DECIMAL(5, 2), total DECIMAL(10, 2))
AS
BEGIN
    SET total = (qte * (100 - reduc) / 100);

    INSERT INTO cmd_lignes(nocmd, nolivre, quantite, remise, montant) VALUES (numCMD, numLivre, qte, reduc, total);

    DBMS_OUTPUT.PUT_LINE('Ligne de commande ajoutée.');
    DBMS_OUTPUT.PUT_LINE('Montant total de la ligne : ' || total || ' euros.');
END;
/

-- Question 3
CREATE OR REPLACE PROCEDURE FactureCmd(numCmd) 
AS
    numCommande INT;
    numClient INT;
    noLivre INT;
    quantite INT;
    remise DECIMAL(5, 2);
    prixUnitaire DECIMAL(10, 2);
    totalLigne DECIMAL(10, 2);
BEGIN 
    SELECT nocmd, noclient INTO numCommande, num_client
    FROM cmd
    WHERE numCommande = numCmd;

    DBMS_OUTPUT.PUT_LINE('Facture commande numéro ' || numCommande);
    DBMS_OUTPUT.PUT_LINE('Numéro client : ' || numClient);

    FOR ligne IN (SELECT nolivre, quantite, remise FROM cmd_lignes WHERE nocmd = numCmd) LOOP
        noLivre := ligne.nolivre;
        quantite := ligne.quantite;
        remise := ligne.remise;
        
        SELECT prix INTO prixUnitaire FROM livres WHERE nolivre = noLivre;

        totalLigne := (prixUnitaire * quantite) * (1 - (remise / 100));

        DBMS_OUTPUT.PUT_LINE("Article : " || noLivre || " - Quantité : " || quantite || " - Remise : " || remise || " - Total ligne = " || totalLigne);
        
    END LOOP;
END;
/


-- Question 4
GRANT EXECUTE ON FactureCmd TO dupont;


-- Question 5
CREATE OR REPLACE FUNCTION CoutComm(numCmd INT) RETURN DECIMAL(10, 2) AS
    total DECIMAL(10, 2);
BEGIN
    SELECT montant INTO total FROM cmd_lignes WHERE nocmd = numCmd;

    RETURN total;
END;
/


-- Question 6
CREATE OR REPLACE TRIGGER TrigHistoPrixLivre
AFTER UPDATE OF prix ON historique_prix
FOR EACH ROW
DECLARE
    prix DECIMAL(10, 2);
    dateUpdate DATE;
BEGIN 
    SELECT :OLD.prix INTO prix FROM historique_prix;
    SELECT sysdate INTO dateUpdate FROM dual;
END;
/


-- Question 7
SELECT l.nolivre, l.titre, MAX(total)
FROM FROM livres l
JOIN cmd_lignes cmd
ON l.nolivre = cmd.nolivre
WHERE  IN (
    SELECT l.nolivre, l.titre, SUM(cmd.quantite) AS total
    FROM livres l
    JOIN cmd_lignes cmd
    ON l.nolivre = cmd.nolivre
    WHERE EXCTRACT(MONTH FROM sysdate) = EXTRACT(MONTH FROM cmd.datecommande)
    GROUP BY l.nolivre, l.titre
    ORDER BY total DESC);