SELECT deptno, COUNT(empno) as nombre_employes, SUM(sal) as total_salaire
FROM iin_bigemp
GROUP BY deptno;
