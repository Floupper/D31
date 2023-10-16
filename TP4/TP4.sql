-- Question 1.b
SELECT empno
FROM iin_bigemp
WHERE empno < 100000;

-- Question 1.c
SELECT empno
FROM iin_bigemp
WHERE empno BETWEEN 100000 and 200000;

-- Question 1.d
SELECT empno
FROM iin_bigemp
WHERE empno IN (100000, 200000, 300000);

-- Question 1.e
SELECT empno
FROM iin_bigemp
WHERE MOD(empno, 2) = 0;

-- Question 1.f
SELECT ename
FROM iin_bigemp
WHERE INITCAP(ename) LIKE 'S%';

-- Question 1.g
SELECT empno
FROM iin_bigemp
WHERE empno > 100000
AND INITCAP(ename) LIKE 'S%';

-- Question 1.h
SELECT empno
FROM iin_bigemp
WHERE UPPER(job) IN ('ANALYST, CLERK');

-- Question 2.a
SELECT deptno
FROM iin_bigdept
WHERE UPPER(loc) LIKE 'D%';

-- Question 2.b
SELECT deptno, dname
FROM iin_bigdept
WHERE UPPER(loc) LIKE 'D%';

-- Question 2.c
SELECT deptno
FROM iin_bigdept
WHERE UPPER(loc) LIKE '%A%';

-- Question 2.d
SELECT deptno
FROM iin_bigdept
WHERE UPPER(loc) LIKE '%S';

-- Question 2.e
SELECT deptno
FROM iin_bigdept
WHERE deptno > 98;

-- Question 2.f
SELECT dname
FROM iin_bigdept
WHERE INITCAP(loc) LIKE 'D%';

SELECT dname, loc
FROM iin_bigdept
GROUP BY loc;