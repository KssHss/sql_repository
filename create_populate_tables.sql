-- *************************************** Table authors ***************************************

CREATE TABLE authors
  (
  au_id    CHAR(3)     NOT NULL,
  au_fname VARCHAR(15) NOT NULL,
  au_lname VARCHAR(15) NOT NULL,
  phone    VARCHAR(12)         ,
  address  VARCHAR(20)         ,
  city     VARCHAR(15)         ,
  state    CHAR(2)             ,
  zip      CHAR(5)             ,
  CONSTRAINT pk_authors PRIMARY KEY (au_id)
  );
INSERT INTO authors VALUES('A01','Sarah','Buchman','718-496-7223','75 West 205 St','Bronx','NY','10468');
INSERT INTO authors VALUES('A02','Wendy','Heydemark','303-986-7020','2922 Baseline Rd','Boulder','CO','80303');
INSERT INTO authors VALUES('A03','Hallie','Hull','415-549-4278','3800 Waldo Ave, #14F','San Francisco','CA','94123');
INSERT INTO authors VALUES('A04','Klee','Hull','415-549-4278','3800 Waldo Ave, #14F','San Francisco','CA','94123');
INSERT INTO authors VALUES('A05','Christian','Kells','212-771-4680','114 Horatio St','New York','NY','10014');
INSERT INTO authors VALUES('A06','','Kellsey','650-836-7128','390 Serra Mall','Palo Alto','CA','94305');
INSERT INTO authors VALUES('A07','Paddy','O''Furniture','941-925-0752','1442 Main St','Sarasota','FL','34236');



-- *************************************** Table publishers ***************************************

CREATE TABLE publishers (
  pub_id   CHAR(3)     NOT NULL,
  pub_name VARCHAR(20) NOT NULL,
  city     VARCHAR(15) NOT NULL,
  state    CHAR(2)             ,
  country  VARCHAR(15) NOT NULL,
  CONSTRAINT pk_publishers PRIMARY KEY (pub_id)
  );
INSERT INTO publishers VALUES('P01','Abatis Publishers','New York','NY','USA');
INSERT INTO publishers VALUES('P02','Core Dump Books','San Francisco','CA','USA');
INSERT INTO publishers VALUES('P03','Schadenfreude Press','Hamburg',NULL,'Germany');
INSERT INTO publishers VALUES('P04','Tenterhooks Press','Berkeley','CA','USA');



-- *************************************** Table new_publishers ***************************************

CREATE TABLE new_publishers
  (
  pub_id   CHAR(3),
  pub_name VARCHAR(20),
  city     VARCHAR(15),
  state    CHAR(2)             ,
  country  VARCHAR(15),
  CONSTRAINT pk_new_publishers PRIMARY KEY (pub_id)
  );

INSERT INTO new_publishers VALUES('P11','Community Press','Los Angeles','CA','USA');
INSERT INTO new_publishers VALUES('P12','Wiley and Sons','Pittsburgh','PA','USA');
INSERT INTO new_publishers VALUES('P13','Verlang','Berlin',NULL,'Germany');
INSERT INTO new_publishers VALUES('P14','Springer','Berlin',NULL,'Germany');



-- *************************************** Table titles ***************************************

CREATE TABLE titles (
  title_id   CHAR(3),
  title_name VARCHAR(40),
  type       VARCHAR(10),
  pub_id     CHAR(3),
  pages      INTEGER,
  price      DECIMAL(5,2),
  sales      INTEGER,
  pubdate    DATE,
  contract   SMALLINT,
  CONSTRAINT pk_titles PRIMARY KEY (title_id)
  );
ALTER TABLE titles
  ADD CONSTRAINT fk_titles_pub_id
  FOREIGN KEY (pub_id)
  REFERENCES publishers(pub_id);

INSERT INTO titles VALUES('T01','1977!','history','P01',107,21.99,566, '2000-08-01',1);
INSERT INTO titles VALUES('T02','200 Years of German Humor','history','P03',14,19.95,9566,'1998-04-01',1);
INSERT INTO titles VALUES('T03','Ask Your System Administrator','computer','P02',1226,39.95,25667, '2000-09-01',1);
INSERT INTO titles VALUES('T04','But I Did It Unconsciously','psychology','P04',510,12.99,13001, '1999-05-31',1);
INSERT INTO titles VALUES('T05','Exchange of Platitudes','psychology','P04',201,6.95,201440, '2001-01-01',1);
INSERT INTO titles VALUES('T06','How About Never?','biography','P01',473,19.95,11320, '2000-07-31',1);
INSERT INTO titles VALUES('T07','I Blame My Mother','biography','P03',333,23.95,1500200, '1999-10-01',1);
INSERT INTO titles VALUES('T08','Just Wait Until After School','children','P04',86,10.00,4095, '2001-06-01',1);
INSERT INTO titles VALUES('T09','Kiss My Boo-Boo','children','P04',22,13.95,5000, '2002-05-31',1);
INSERT INTO titles VALUES('T10','Not Without My Faberge Egg','biography','P01',NULL,NULL,NULL,NULL,0);
INSERT INTO titles VALUES('T11','Perhaps It''s a Glandular Problem','psychology','P04',826,7.99,94123, '2000-11-30',1);
INSERT INTO titles VALUES('T12','Spontaneous, Not Annoying','biography','P01',507,12.99,100001, '2000-08-31',1);
INSERT INTO titles VALUES('T13','What Are The Civilian Applications?','history','P03',802,29.99,10467, '1999-05-31',1);



-- *************************************** Table title_authors ***************************************

CREATE TABLE title_authors (
  title_id      CHAR(3),
  au_id         CHAR(3),
  au_order      SMALLINT,
  royalty_share DECIMAL(5,2),
  CONSTRAINT pk_title_authors
    PRIMARY KEY (title_id, au_id),
  CONSTRAINT fk_title_authors_title_id
    FOREIGN KEY (title_id)
    REFERENCES titles(title_id),
  CONSTRAINT fk_title_authors_au_id
    FOREIGN KEY (au_id)
    REFERENCES authors(au_id) 
  );

INSERT INTO title_authors VALUES('T01','A01',1,1.0);
INSERT INTO title_authors VALUES('T02','A01',1,1.0);
INSERT INTO title_authors VALUES('T03','A05',1,1.0);
INSERT INTO title_authors VALUES('T04','A03',1,0.6);
INSERT INTO title_authors VALUES('T04','A04',2,0.4);
INSERT INTO title_authors VALUES('T05','A04',1,1.0);
INSERT INTO title_authors VALUES('T06','A02',1,1.0);
INSERT INTO title_authors VALUES('T07','A02',1,0.5);
INSERT INTO title_authors VALUES('T07','A04',2,0.5);
INSERT INTO title_authors VALUES('T08','A06',1,1.0);
INSERT INTO title_authors VALUES('T09','A06',1,1.0);
INSERT INTO title_authors VALUES('T10','A02',1,1.0);
INSERT INTO title_authors VALUES('T11','A03',2,0.3);
INSERT INTO title_authors VALUES('T11','A04',3,0.3);
INSERT INTO title_authors VALUES('T11','A06',1,0.4);
INSERT INTO title_authors VALUES('T12','A02',1,1.0);
INSERT INTO title_authors VALUES('T13','A01',1,1.0);


-- *************************************** Table royalties ***************************************

CREATE TABLE royalties (
  title_id     CHAR(3),
  advance      DECIMAL(9,2),
  royalty_rate DECIMAL(5,2),
  CONSTRAINT fk_royalties_title_id
    FOREIGN KEY (title_id)
    REFERENCES titles(title_id),
  CONSTRAINT pk_royalties PRIMARY KEY (title_id)
  );
INSERT INTO royalties VALUES('T01',10000,0.05);
INSERT INTO royalties VALUES('T02',1000,0.06);
INSERT INTO royalties VALUES('T03',15000,0.07);
INSERT INTO royalties VALUES('T04',20000,0.08);
INSERT INTO royalties VALUES('T05',100000,0.09);
INSERT INTO royalties VALUES('T06',20000,0.08);
INSERT INTO royalties VALUES('T07',1000000,0.11);
INSERT INTO royalties VALUES('T08',0,0.04);
INSERT INTO royalties VALUES('T09',0,0.05);
INSERT INTO royalties VALUES('T10',NULL,NULL);
INSERT INTO royalties VALUES('T11',100000,0.07);
INSERT INTO royalties VALUES('T12',50000,0.09);
INSERT INTO royalties VALUES('T13',20000,0.06);



-- *************************************** Table employees ***************************************

CREATE TABLE employees (
  emp_id   CHAR(3) PRIMARY KEY,
  emp_name VARCHAR(20),
  boss_id  CHAR(3)
  );
INSERT INTO employees VALUES('E01','Lord Copper',NULL);
INSERT INTO employees VALUES('E02','Jocelyn Hitchcock','E01');
INSERT INTO employees VALUES('E03','Mr. Salter','E01');
INSERT INTO employees VALUES('E04','William Boot','E03');
INSERT INTO employees VALUES('E05','Mr. Corker','E03');


-- *************************************** Table test_scores ***************************************

CREATE TABLE IF NOT EXISTS test_scores (
  name varchar(20),
  test varchar(20),
  score tinyint
);

INSERT INTO test_scores VALUES
  ("Steve", "SQL", 75),
  ("Robert", "SQL", 43),
  ("Tracy", "SQL", 56),
  ("Tatiana", "SQL", 87),
  ("Steve", "Tuning", 83),
  ("Robert", "Tuning", 31),
  ("Tracy", "Tuning", 88),
  ("Tatiana", "Tuning", 83);

-- *************************************** Table dept ***************************************

CREATE TABLE IF NOT EXISTS dept (
    deptno          DECIMAL(2) PRIMARY KEY,
    dname           VARCHAR(14),
    loc             VARCHAR(13)
);

INSERT INTO dept VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO dept VALUES (20,'RESEARCH','DALLAS');
INSERT INTO dept VALUES (30,'SALES','CHICAGO');
INSERT INTO dept VALUES (40,'OPERATIONS','BOSTON');



-- *************************************** Table emp ***************************************
CREATE TABLE emp (
    empno           DECIMAL(4),
    ename           VARCHAR(10),
    job             VARCHAR(9),
    mgr             DECIMAL(4),
    hiredate        DATE,
    sal             DECIMAL(7,2) CHECK (sal > 0),
    comm            DECIMAL(7,2),
    deptno          DECIMAL(2),
    CONSTRAINT pk_emp PRIMARY KEY (empno)
);

ALTER TABLE emp
  ADD CONSTRAINT fk_emp_ref_dept
  FOREIGN KEY (deptno)
  REFERENCES dept(deptno);

INSERT INTO emp VALUES
  (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
  (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
  (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
  (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
  (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400,30),
  (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
  (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
  (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000, NULL, 20),
  (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
  (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
  (7876, 'ADAMS', 'CLERK', 7788, '1987-07-13', 1100, NULL, 20),
  (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
  (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
  (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10) ; 



-- *************************************** Table jobhist ***************************************

CREATE TABLE jobhist (
    empno           DECIMAL(4),
    startdate       DATE,
    enddate         DATE,
    job             VARCHAR(9),
    sal             INT,
    comm            INT,
    deptno          DECIMAL(2),
    chgdesc         VARCHAR(80),
    CONSTRAINT pk_jobhist PRIMARY KEY (empno, startdate)
);

ALTER TABLE jobhist
  ADD CONSTRAINT fk_jobhist_ref_emp
  FOREIGN KEY (empno)
  REFERENCES emp(empno) ON DELETE CASCADE;
ALTER TABLE jobhist
  ADD CONSTRAINT fk_jobhist_ref_dept
  FOREIGN KEY (deptno)
  REFERENCES dept (deptno) ON DELETE SET NULL;
ALTER TABLE jobhist
  ADD CONSTRAINT jobhist_date_chk
  CHECK (startdate <= enddate);

INSERT INTO jobhist VALUES (7369,'1980-12-17',NULL,'CLERK',800,NULL,20, 'New Hire');
INSERT INTO jobhist VALUES (7499,'1981-02-20',NULL,'SALESMAN',1600,300,30, 'New Hire');
INSERT INTO jobhist VALUES (7521,'1981-02-22',NULL,'SALESMAN',1250,500,30, 'New Hire');
INSERT INTO jobhist VALUES (7566,'1981-04-02',NULL,'MANAGER',2975,NULL,20, 'New Hire');
INSERT INTO jobhist VALUES (7654,'1981-09-28',NULL,'SALESMAN',1250,1400,30, 'New Hire');
INSERT INTO jobhist VALUES (7698,'1981-05-01',NULL,'MANAGER',2850,NULL,30, 'New Hire');
INSERT INTO jobhist VALUES (7782,'1981-06-09',NULL,'MANAGER',2450,NULL,10, 'New Hire');
INSERT INTO jobhist VALUES (7788,'1987-04-19','1988-04-12','CLERK',1000,NULL,20, 'New Hire');
INSERT INTO jobhist VALUES (7788,'1988-04-13','1989-05-04','CLERK',1040,NULL,20, 'Raise');
INSERT INTO jobhist VALUES (7788,'1990-05-05',NULL,'ANALYST',3000,NULL,20, 'Promoted to Analyst');
INSERT INTO jobhist VALUES (7839,'1981-11-17',NULL,'PRESIDENT',5000,NULL,10, 'New Hire');
INSERT INTO jobhist VALUES (7844,'1981-09-08',NULL,'SALESMAN',1500,0,30, 'New Hire');
INSERT INTO jobhist VALUES (7876,'1987-05-23',NULL,'CLERK',1100,NULL,20, 'New Hire');
INSERT INTO jobhist VALUES (7900,'1981-12-03','1983-01-14','CLERK',950,NULL,10, 'New Hire');
INSERT INTO jobhist VALUES (7900,'1983-01-15',NULL,'CLERK',950,NULL,30, 'Changed to Dept 30');
INSERT INTO jobhist VALUES (7902,'1981-12-03',NULL,'ANALYST',3000,NULL,20, 'New Hire');
INSERT INTO jobhist VALUES (7934,'1982-01-23',NULL,'CLERK',1300,NULL,10, 'New Hire');

DROP TABLE IF EXISTS salgrade;
CREATE TABLE salgrade
        (grade INT PRIMARY KEY,
         losal BIGINT,
         hisal BIGINT);

INSERT INTO salgrade VALUES (1,  700, 1200);
INSERT INTO salgrade VALUES (2, 1201, 1400);
INSERT INTO salgrade VALUES (3, 1401, 2000);
INSERT INTO salgrade VALUES (4, 2001, 3000);
INSERT INTO salgrade VALUES (5, 3001, 9999);
