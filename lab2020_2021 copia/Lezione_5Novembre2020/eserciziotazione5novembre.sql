CREATE TABLE Produttori(
	CodiceProduttore VARCHAR(6) PRIMARY KEY,
	Nome VARCHAR(20) NOT NULL,
	Nazione VARCHAR(20)
);

CREATE TABLE PrincipioAttivo(
	Id VARCHAR(6) PRIMARY KEY,
	Nome VARCHAR(20) NOT NULL,
	Categoria VARCHAR(20) NOT NULL
);

CREATE TABLE Integratori(
	Codice VARCHAR(6) PRIMARY KEY,
	Nome VARCHAR(20),
	PrincipioAttivo VARCHAR(6) REFERENCES PrincipioAttivo(id)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	Produttore VARCHAR(6) REFERENCES Produttori(CodiceProduttore)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	Prezzo NUMERIC


insert into PrincipioAttivo values('101','A','c1');
insert into PrincipioAttivo values('102','B','c1');
insert into PrincipioAttivo values('103','C','c1');
insert into PrincipioAttivo values('104','D','c2');
insert into PrincipioAttivo values('105','E','c3');
insert into PrincipioAttivo values('106','F','c3');

insert into Produttori values('1001','ProduttoreA','Italia');
insert into Produttori values('1002','ProduttoreB','Svizzera');
insert into Produttori values('1003','ProduttoreC','Francia');
insert into Produttori values('1004','ProduttoreD','Francia');
insert into Produttori values('1005','ProduttoreE','Italia');

insert into Integratori values('10001','IntegratoreA','101','1003',10);
insert into Integratori values('10002','IntegratoreB','102','1003',11);
insert into Integratori values('10003','IntegratoreC','103','1004',12);
insert into Integratori values('10004','IntegratoreD','103','1004',11);
insert into Integratori values('10005','IntegratoreE','101','1005',11);
insert into Integratori values('10006','IntegratoreF','101','1004',12);
insert into Integratori values('10007','IntegratoreG','101','1002',13);
insert into Integratori values('10008','IntegratoreH','104','1001',11);
insert into Integratori values('10009','IntegratoreI','105','1001',14);
insert into Integratori values('10010','IntegratoreL','105','1002',16);
insert into Integratori values('10011','IntegratoreM','106','1002',20);
insert into Integratori values('10012','IntegratoreN','104','1003',12);
insert into Integratori values('10013','IntegratoreO','102','1001',13);
insert into Integratori values('10014','IntegratoreP','102','1001',11);
insert into Integratori values('10015','IntegratoreQ','103','1001',10);
