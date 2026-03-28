USE DB09;



--DROP TABLE  PAYMENT;
--DROP TABLE  EXCHANGE;
--DROP TABLE   SHOPS;
--DROP TABLE   CREDIT_CARD;
--DROP TABLE   tamieytirioy;
--DROP TABLE  OPSEOS;
--DROP TABLE   OPENS;
--DROP TABLE   ACCOUNT;
--DROP TABLE TELEPHONES;
--DROP TABLE  CLIENT;
--DROP TABLE   REGION;







CREATE TABLE REGION (

region_id INT NOT NULL PRIMARY KEY ,
region_name VARCHAR(20) ,
population INT ,
avg_income DECIMAL(10,2) 

)





CREATE TABLE CLIENT (

client_id INT NOT NULL PRIMARY KEY ,
client_name VARCHAR(100) ,
surname VARCHAR(100) ,
afm VARCHAR(30) ,
adress VARCHAR(200) ,
region_id INT FOREIGN KEY REFERENCES REGION 

)

CREATE TABLE TELEPHONES (
    phone VARCHAR(20),
    client_id INT FOREIGN KEY REFERENCES CLIENT(client_id),
    PRIMARY KEY (phone, client_id)
);



CREATE TABLE ACCOUNT (

account_number INT NOT NULL PRIMARY KEY , 
account_balance DECIMAL(10,2) ,
client_id INT  FOREIGN KEY REFERENCES CLIENT 


)

CREATE TABLE OPENS (
    account_number INT FOREIGN KEY REFERENCES ACCOUNT(account_number),
    client_id INT FOREIGN KEY REFERENCES CLIENT(client_id),
    PRIMARY KEY (account_number, client_id)
);


CREATE TABLE OPSEOS (

account_number INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES ACCOUNT,
poso_uperanalipsis DECIMAL(10,2)  
 

)



CREATE TABLE tamieytirioy (

account_number INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES ACCOUNT,
epitokio DECIMAL(10,2) 


)






CREATE TABLE CREDIT_CARD (

card_number BIGINT NOT NULL PRIMARY KEY ,
limit DECIMAL(10,2) ,
card_balance DECIMAL(10,2) ,
card_epitokio DECIMAL(10,2) ,
first_date DATE ,
last_date DATE ,
client_id INT FOREIGN KEY REFERENCES CLIENT ,
account_number INT FOREIGN KEY REFERENCES ACCOUNT 

)





CREATE TABLE SHOPS (

shop_id INT NOT NULL PRIMARY KEY ,
shop_name VARCHAR(100) ,
shops_service INT,
region_id INT FOREIGN KEY REFERENCES REGION

)





CREATE TABLE EXCHANGE (

exchange_number INT NOT NULL PRIMARY KEY ,
exhange_amount DECIMAL(10,2) ,
exchange_time TIME ,
exchange_date DATE ,
exchange_bankCode INT ,
shop_id INT ,
card_number BIGINT NOT NULL, 
FOREIGN KEY( card_number  ) REFERENCES CREDIT_CARD ,
FOREIGN KEY ( shop_id) REFERENCES SHOPS

)




CREATE TABLE PAYMENT (

payment_id INT  ,
payment_amount DECIMAL(10,2) ,
payment_date DATE ,
client_id INT NOT NULL,
PRIMARY KEY (payment_id , client_id ) ,
FOREIGN KEY ( client_id ) REFERENCES CLIENT ,



)