-- Question 1 :
SELECT NOCLIENT, NOM, PRENOM, VILLE 
FROM IIN_CLIENTS 
WHERE UPPER(VILLE) LIKE ‘T%’ ;

-- Question 2 :
SELECT * 
FROM IIN_CMD 
WHERE DATECOMMANDE = TO_DATE(’05-2009’, ‘MM-YYYY’) 
ORDER BY DATECOMMANDE DESC, NOCLIENT;

-- Question 3 : 
SELECT COUNT(*) 
FROM IIN_CMD 
WHERE NOCLIENT
IN (SELECT NOCLIENT 
    FROM IIN_CLIENTS 
    WHERE UPPER(VILLE) = 'PARIS');

-- Question 4 :
SELECT c.nocmd, k.noclient, cl.nom, c.quantite FROM iin_cmd_lignes c
JOIN iin_livres l
ON c.nolivre = l.nolivre
JOIN iin_cmd k
ON c.nocmd = k.nocmd
JOIN iin_clients cl
ON cl.noclient = k.noclient
WHERE lower(l.titre) = 'le seigneur des anneaux'
ORDER BY c.nocmd desc, k.noclient desc;

-- Question 5 :
SELECT SUM(cml.quantite), clt.pays
FROM iin_cmd_lignes cml, iin_clients clt, iin_cmd cmd
WHERE cmd.nocmd = cml.nocmd
AND cmd.noclient = clt.noclient
AND TO_CHAR(datecommande, 'YYYY') = '2007'
GROUP BY clt.pays;

-- Question 6 :
SELECT clt.noclient, clt.noclient, SUM(cml.quantite)
FROM iin_cmd cmd
JOIN iin_cmd_lignes cml
ON cml.nocmd = cmd.nocmd
JOIN iin_clients clt 
ON clt.noclient = cmd.noclient
HAVING SUM(cml.quantite) > 3000
GROUP BY clt.nom, clt.noclient

-- Question 7 :
SELECT DISTINCT auteur
FROM iin_livres
WHERE auteur NOT IN (SELECT auteur
                     FROM iin_livres
                     WHERE LOWER(editeur) != 'pearson');
-- Question 7 : marche pas....
SELECT DISTINCT auteur
FROM iin_livres l1
WHERE not_exists(SELECT *
                 FROM iin_livres l2
                 WHERE LOWER(editeur) != 'pearson'
                 AND l2.auteur = l1.auteur);

-- Question 8 :
SELECT actor_id, last_name
FROM iin_actors
WHERE actor_id
IN (SELECT actor_id
    FROM iin_roles
    WHERE movie_id = (SELECT movie_id
                      FROM iin_movies
                      WHERE LOWER(name) = 'star wars'));