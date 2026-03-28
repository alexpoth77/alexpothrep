use DB09;

--1)   *
SELECT 
    C.client_id AS Êùäéêüò, 
    C.afm AS ÁÖÌ, 
    C.client_name AS ¼íïìá, 
    C.adress AS Äéåýèõíóç, 
    T.phone AS ÔçëÝöùíï
FROM CLIENT C
LEFT JOIN TELEPHONES T ON C.client_id = T.client_id;


--2) *
SELECT 
    card_number , exchange_date
FROM EXCHANGE
WHERE exchange_date >= '2017-05-12' AND exchange_date <= '2017-05-18';


--3) *
SELECT C.client_id, C.client_name,C.surname, O.account_number
FROM CLIENT C, OPENS O
WHERE C.client_id = O.client_id


--4) *
SELECT DISTINCT C.client_name, C.surname,T.phone
FROM CLIENT C, TELEPHONES T, CREDIT_CARD CC, EXCHANGE E, SHOPS S
WHERE C.client_id = T.client_id
  AND C.client_id = CC.client_id
  AND CC.card_number = E.card_number
  AND E.shop_id = S.shop_id
  AND S.region_id = 291
  AND E.exchange_date >= '2017-06-01' 
  AND E.exchange_date <= '2017-06-30';


  --5)
  SELECT card_number
FROM CREDIT_CARD
WHERE last_date BETWEEN GETDATE() AND DATEADD(month, 1, GETDATE());







--6) *
UPDATE CREDIT_CARD
SET card_epitokio = card_epitokio - 1.0; -- Õðüèåóç: ôï åðéôüêéï åßíáé óå ðïóïóôéáßá ìïíÜäá


--7)
SELECT P.client_name, P.surname , P.afm
FROM CLIENT P, OPENS O, ACCOUNT A
WHERE P.client_id = O.client_id 
  AND O.account_number = A.account_number
GROUP BY P.client_id, P.client_name,P.surname, P.afm
HAVING SUM(A.account_balance) > 10000;



--8)
SELECT 
    MONTH(exchange_date) AS M,  SUM(exhange_amount) 
FROM EXCHANGE
WHERE YEAR(exchange_date) = 2017
GROUP BY MONTH(exchange_date)
ORDER BY M;



--9)
--ÅÑÙÔÇÌÁ @ ÃÉÁ CHATGPT
SELECT 
    P.client_name ,
	P.surname ,
    MONTH(E.exchange_date) AS ÌÞíáò, 
    SUM(E.exhange_amount) 
FROM CLIENT P, CREDIT_CARD K, EXCHANGE E
WHERE 
    P.client_id = K.client_id
    AND K.card_number = E.card_number
    AND YEAR(E.exchange_date) = 2017
GROUP BY P.client_id, P.surname, P.client_name , MONTH(E.exchange_date)
ORDER BY P.client_name,P.surname, ÌÞíáò;



--10)
SELECT CC.client_id
FROM CREDIT_CARD CC, EXCHANGE E
WHERE CC.card_number = E.card_number
  AND E.exhange_amount >= ALL (
      SELECT exhange_amount
      FROM EXCHANGE
  );

--11)

SELECT
P.client_name ,
P.surname  
FROM CLIENT P, CREDIT_CARD K, EXCHANGE E
WHERE 
    P.client_id = K.client_id
    AND K.card_number = E.card_number
    AND E.exchange_date >= '2017-06-01' AND E.exchange_date<= '2017-06-30'
GROUP BY P.client_id, P.client_name , P.surname
HAVING COUNT(E.exchange_number) > 5 AND AVG(E.exhange_amount) > 50;



--12)


SELECT P.client_name ,P.surname, (SUM(E.exhange_amount) * 100.0) / R.avg_income
FROM CLIENT P , REGION R , CREDIT_CARD K , EXCHANGE E 
WHERE P.region_id = R.region_id
AND P.client_id = K.client_id
AND K.card_number = E.card_number
AND YEAR(E.exchange_date)=2017
GROUP BY P.client_id, P.client_name, P.surname , R.avg_income;




--13) @CHAT
SELECT
    P.client_name , P.surname
FROM
    CLIENT P , CREDIT_CARD  CC , EXCHANGE E
WHERE
    P.client_id = CC.client_id AND CC.card_number = E.card_number AND 
    E.exchange_date >= '2017-06-01' AND E.exchange_date <= '2017-06-30'
GROUP BY
    P.client_id , P.client_name , P.surname
HAVING
    AVG(E.exhange_amount) > 3 * (
        SELECT
            AVG(exhange_amount)
        FROM
            EXCHANGE
        WHERE
            exchange_date >= '2017-06-01' AND exchange_date <= '2017-06-30' );


    --14) @chat

 -- View ãéá ôéò áãïñÝò ôïõ Éïõíßïõ 2016
 GO
CREATE VIEW V2016(client_id, total_amt) AS
SELECT C.client_id, SUM(E.exhange_amount)
FROM CLIENT C, CREDIT_CARD CC, EXCHANGE E
WHERE C.client_id = CC.client_id 
  AND CC.card_number = E.card_number
  AND E.exchange_date >= '2016-06-01' 
  AND E.exchange_date <= '2016-06-30'
GROUP BY C.client_id;
GO
--  View ãéá ôéò áãïñÝò ôïõ Éïõíßïõ 2017
GO
CREATE VIEW V2017(client_id, total_amt) AS
SELECT C.client_id, SUM(E.exhange_amount)
FROM CLIENT C, CREDIT_CARD CC, EXCHANGE E
WHERE C.client_id = CC.client_id 
  AND CC.card_number = E.card_number
  AND E.exchange_date >= '2017-06-01' 
  AND E.exchange_date <= '2017-06-30'
GROUP BY C.client_id;
GO

SELECT v17.client_id, v16.total_amt AS LastYear, v17.total_amt AS CurrentYear
FROM V2017 v17, V2016 v16
WHERE v17.client_id = v16.client_id 
  AND v17.total_amt >= (v16.total_amt * 1.5);   






--15)
GO
CREATE VIEW V_AvgBefore(client_id, m_ref, avg_before) AS
SELECT CC.client_id, MONTH(E1.exchange_date), AVG(E2.exhange_amount)
FROM CREDIT_CARD CC, EXCHANGE E1, EXCHANGE E2
WHERE CC.card_number = E1.card_number 
  AND CC.card_number = E2.card_number
  AND YEAR(E1.exchange_date) = 2017 
  AND YEAR(E2.exchange_date) = 2017
  AND MONTH(E2.exchange_date) < MONTH(E1.exchange_date)
GROUP BY CC.client_id, MONTH(E1.exchange_date);
GO

CREATE VIEW V_AvgAfter(client_id, m_ref, avg_after) AS
SELECT CC.client_id, MONTH(E1.exchange_date), AVG(E2.exhange_amount)
FROM CREDIT_CARD CC, EXCHANGE E1, EXCHANGE E2
WHERE CC.card_number = E1.card_number
  AND CC.card_number = E2.card_number
  AND YEAR(E1.exchange_date) = 2017 
  AND YEAR(E2.exchange_date) = 2017
  AND MONTH(E2.exchange_date) > MONTH(E1.exchange_date)
GROUP BY CC.client_id, MONTH(E1.exchange_date);
GO

SELECT  B.client_id, B.m_ref 
FROM V_AvgBefore B, V_AvgAfter A
WHERE B.client_id = A.client_id 
  AND B.m_ref = A.m_ref
  AND A.avg_after > B.avg_before;










--16)


--  View ãéá ôéò óõíïëéêÝò áãïñÝò áíÜ ðåëÜôç ôï 2017
GO

CREATE VIEW V_Purchases2017(client_id, total_purchases) AS
SELECT CC.client_id, SUM(E.exhange_amount)
FROM CREDIT_CARD CC, EXCHANGE E
WHERE CC.card_number = E.card_number
  AND YEAR(E.exchange_date) = 2017
GROUP BY CC.client_id;
GO
--  View ãéá ôéò óõíïëéêÝò ðëçñùìÝò áíÜ ðåëÜôç ôï 2017
CREATE VIEW V_Payments2017(client_id, total_payments) AS
SELECT P.client_id, SUM(P.payment_amount)
FROM PAYMENT P
WHERE YEAR(P.payment_date) = 2017
GROUP BY P.client_id;
GO

SELECT 
    PUR.client_id, 
    PUR.total_purchases, 
    PAY.total_payments
FROM V_Purchases2017 PUR, V_Payments2017 PAY
WHERE PUR.client_id = PAY.client_id
  AND PUR.total_purchases < PAY.total_payments;
