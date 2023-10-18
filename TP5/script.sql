CREATE TABLE dept
(deptno number(2) NOT NULL, 
 dname varchar2(20) NOT NULL, 
 loc varchar2(20),
 CONSTRAINT pk_dept PRIMARY KEY (deptno)
);


CREATE TABLE emp
(empno number(5) NOT NULL, 
 ename varchar2(20) NOT NULL, 
 job varchar2(20),
 mgr number(5),
 hiredate date DEFAULT sysdate,
 sal number(8,2) NOT NULL,
 comm number(8), 
 deptno number(2),  
 CONSTRAINT c_emp_salaire CHECK(sal between 800 and 50000), 
 CONSTRAINT c_emp_commJob CHECK((comm is not null and initcap(job) = 'Salesman') or (comm is null and initcap(job) != 'Salesman')),
 CONSTRAINT u_emp_ename UNIQUE(ename), 
 CONSTRAINT pk_emp PRIMARY KEY (empno), 
 CONSTRAINT fk_emp_deptno FOREIGN KEY (deptno) REFERENCES dept ON DELETE CASCADE
) ;

INSERT INTO dept(deptno, dname, loc) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept(deptno, dname, loc) VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO dept(deptno, dname, loc) VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO dept(deptno, dname, loc) VALUES (40, 'OPERATIONS', 'BOSTON');


INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (9999, 'GAG', NULL, NULL, NULL, 3000, NULL, 10);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7839, 'KING',  'PRESIDENT', NULL, to_date('09-08-1981', 'dd-mm-yyyy'), 5000, NULL, 10);  
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7698, 'BLAKE', 'MANAGER', 7839, to_date('21-01-1981', 'dd-mm-yyyy'), 2850, NULL, 30);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7782, 'CLARK', 'MANAGER', 7839, to_date('01-03-1981', 'dd-mm-yyyy'), 2450, NULL, 10);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7566, 'JONES', 'MANAGER', 7839, to_date('23-12-1980', 'dd-mm-yyyy'), 2975, NULL, 20);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7654, 'MARTIN', 'SALESMAN', 7698, to_date('20-06-1981', 'dd-mm-yyyy'), 1250, 1400, 30);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7499, 'ALLEN', 'SALESMAN', 7698, to_date('12-11-1980', 'dd-mm-yyyy'), 1600, 300, 30);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7844, 'TURNER', 'SALESMAN', 7698, to_date('31-05-1981', 'dd-mm-yyyy'), 1500, 0, 30);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7900, 'JAMES', 'CLERK', 7698, to_date('25-08-1981', 'dd-mm-yyyy'), 950, NULL, 30);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7521, 'WARD', 'SALESMAN', 7698, to_date('14-11-1980', 'dd-mm-yyyy'), 1250, 500, 30);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7902, 'FORD', 'ANALYST', 7566, to_date('25-08-1981', 'dd-mm-yyyy'), 3000, NULL, 20);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7369, 'SMITH', 'CLERK', 7902, to_date('08-09-1980', 'dd-mm-yyyy'), 800, NULL, 20);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7788, 'SCOTT', 'ANALYST', 7566, to_date('31-08-1982', 'dd-mm-yyyy'), 3000, NULL, 20);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7876, 'ADAMS', 'CLERK', 7788, to_date('04-10-1982', 'dd-mm-yyyy'), 1100, NULL, 20);
INSERT INTO emp(EMPNO,  ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES (7934, 'MILLER', 'CLERK', 7782, to_date('15-10-1981', 'dd-mm-yyyy'), 1300, NULL, 10);
