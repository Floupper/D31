-- Question 1
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;

-- Question 2
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) = (SELECT MAX(SUM(sal))
                   FROM emp
                   GROUP BY deptno);

-- Question 3
SELECT TO_CHAR(hiredate, 'month'), COUNT(*)
FROM emp
WHERE extract(year from hiredate) = 1981
GROUP BY TO_CHAR(hiredate, 'month');

-- Question 4
SELECT mgr, COUNT(*)
FROM emp
GROUP BY mgr;

-- Question 5
SELECT INITCAP(job), COUNT(*)
FROM emp
WHERE deptno = 20
GROUP BY INITCAP(job)
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM emp
                   WHERE deptno = 20
                   GROUP BY INITCAP(job));

-- Question 6
SELECT initcap(d.loc), count(*)
FROM emp e JOIN dept d ON e.deptno=d.deptno
WHERE extract(year FROM hiredate)=1981
GROUP BY initcap(d.loc)
HAVING count(*)=(SELECT max(count(*))
                 FROM emp e JOIN dept d ON e.deptno=d.deptno
                 WHERE extract(year FROM hiredate)=1981
                 GROUP BY initcap(d.loc));

-- Question 7
SELECT initcap(d.loc), count(e.empno)
FROM emp e RIGHT JOIN dept d ON e.deptno=d.deptno
GROUP BY initcap(d.loc)
HAVING count(e.empno)=(SELECT min(count(e.empno))
                       FROM emp e RIGHT JOIN dept d ON e.deptno=d.deptno
                       GROUP BY initcap(d.loc));