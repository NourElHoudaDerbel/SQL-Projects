CREATE TABLE T (
  pieces VARCHAR(25),
  regions VARCHAR(25),
  quantites INT,
  );

INSERT INTO T (pieces, regions, quantites) VALUES 
   ('écrous', 'est', 50),
   ('écrous', 'ouest', 60),
   ('écrous', 'sud', 40),
   ('clous', 'est', 70),
   ('clous', 'nord', 40),
   ('vis', 'ouest', 50),
   ('vis', 'sud', 50),
   ('vis', 'nord', 60);


SELECT * FROM T;

select pieces, regions, sum(quantites) 
from T 
group by cube (pieces,regions) ;

select pieces, regions, sum(quantites) 
from T 
group by rollup (pieces,regions) ;

select pieces, regions, sum(quantites) 
from T 
group by GROUPING SETS (pieces,regions) ;


CREATE TABLE VENTES (
           nocli INT,
		   noprod INT,
		   nofour INT,
		   montant INT);

-- Insert sample data into the VENTES table
INSERT INTO VENTES (nocli, noprod, nofour, montant) VALUES (101, 2001, 301, 500);
INSERT INTO VENTES (nocli, noprod, nofour, montant) VALUES (102, 2002, 302, 750);
INSERT INTO VENTES (nocli, noprod, nofour, montant) VALUES (103, 2003, 303, 1200);
INSERT INTO VENTES (nocli, noprod, nofour, montant) VALUES (101, 2004, 301, 650);
INSERT INTO VENTES (nocli, noprod, nofour, montant) VALUES (104, 2001, 304, 400);
INSERT INTO VENTES (nocli, noprod, nofour, montant) VALUES (102, 2003, 302, 950);
INSERT INTO VENTES (nocli, noprod, nofour, montant) VALUES (105, 2005, 305, 1300);
INSERT INTO VENTES (nocli, noprod, nofour, montant) VALUES (106, 2006, 306, 800);
INSERT INTO VENTES (nocli, noprod, nofour, montant) VALUES (103, 2002, 303, 1100);
INSERT INTO VENTES (nocli, noprod, nofour, montant) VALUES (104, 2004, 301, 550);

SELECT nocli, noprod, SUM(montant)
FROM ventes
GROUP BY GROUPING SETS ((nocli),(noprod));


SELECT nocli, NULL AS 'noprod', SUM(montant) AS 'montant'
FROM ventes
GROUP BY nocli

UNION

SELECT NULL AS 'nocli', noprod, SUM(montant) AS 'montant'
FROM ventes
GROUP BY noprod;

SELECT nocli, noprod AS 'noprod', SUM(montant)
FROM ventes
GROUP BY ROLLUP(nocli,noprod);

SELECT nocli AS 'nocli', noprod AS 'noprod', SUM(montant) AS 'montant'
FROM ventes
GROUP BY nocli, noprod

UNION

SELECT nocli, NULL AS 'noprod', SUM(montant) AS 'montant'
FROM ventes
GROUP BY nocli

UNION

SELECT NULL AS 'nocli', NULL AS 'noprod', SUM(montant) AS 'montant'
FROM ventes;

SELECT nocli, noprod, nofour, SUM(montant)
FROM ventes
GROUP BY CUBE (nocli, noprod, nofour);




SELECT nocli, noprod, nofour, SUM(montant) AS 'montant'
FROM ventes
GROUP BY nocli, noprod, nofour

UNION

SELECT nocli, NULL AS 'noprod', nofour, SUM(montant) AS 'montant'
FROM ventes
GROUP BY nocli, nofour

UNION

SELECT nocli, noprod, NULL AS 'nofour', SUM(montant) AS 'montant'
FROM ventes
GROUP BY nocli, noprod

UNION

SELECT NULL AS 'nocli', noprod, nofour, SUM(montant) AS 'montant'
FROM ventes
GROUP BY noprod, nofour

UNION

SELECT nocli, NULL AS 'noprod', NULL AS 'nofour', SUM(montant) AS 'montant'
FROM ventes
GROUP BY nocli

UNION

SELECT NULL AS 'nocli', NULL AS 'noprod', nofour, SUM(montant) AS 'montant'
FROM ventes
GROUP BY nofour

UNION

SELECT NULL AS 'nocli', noprod, nofour, SUM(montant) AS 'montant'
FROM ventes
GROUP BY noprod, nofour

UNION

SELECT NULL AS 'nocli', NULL AS 'noprod', NULL AS 'nofour', SUM(montant) AS 'montant'
FROM ventes;


