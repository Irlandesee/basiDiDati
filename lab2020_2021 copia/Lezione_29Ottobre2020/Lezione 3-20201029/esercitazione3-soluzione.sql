------------
Esercizio 1

create table Studenti (
matricola numeric primary key,
cognome varchar(20) not null,
nome varchar(20) not null,
etˆ numeric not null
);

create table Esami (
codiceCorso numeric,
studente numeric references Studenti(matricola),
data date,
voto numeric not null,
primary key (codiceCorso, studente, data));


//selezionare gli studenti che hanno una media > 27 indicando per ciascuno il numero di esami superati e la relativa media
//NB. solo gli esami superati fanno media
select matricola, cognome, nome, count(*) as numEsami, avg(voto) as media
from studenti join esami on matricola=studente
where voto>18
group by matricola, cognome, nome 
having avg(voto)>27

//Selezionare gli studenti che sono stati bocciati almeno una volta indicando il numero di bocciature 
select matricola, cognome, nome, count(*) as bocciature
from studenti join esami on matricola=studente
where voto<18
group by matricola, cognome, nome
order by cognome, nome, matricola

//Selezionare gli studenti che hanno superato almeno 2 corsi
select matricola, cognome, nome
from esami e1 join esami e2 on e2.studente=e1.studente and e1.voto>=18 and e2.voto>=18 and e1.codiceCorso<>e2.codiceCorso
join studenti on e1.studente=matricola
group by matricola, cognome, nome
order by cognome, nome, matricola

//Per ogni esame mostrare il numero di studenti che hanno superato l'esame indicando il voto medio
select codiceCorso, count(*) as numPromossi, avg(voto) as media
from esami
where voto>18
group by codiceCorso

//Selezionare gli studenti che non sono stati mai bocciati
select matricola,cognome, nome
from studenti
except
select matricola, cognome, nome
from studenti join esami on matricola=studente
where voto<18

//Selezionare gli studenti che provando a sostenere almeno una volta un esame non sono stati mai bocciati
select matricola, cognome, nome
from studenti
except
(  select matricola, cognome, nome
   from studenti join esami on matricola=studente 
   where voto<18 
   union
   select matricola, cognome, nome
   from studenti left outer join esami on matricola=studente 
   where voto is null
)

//Selezionare gli studenti che hanno passato base di dati e programmazione ma non sistemi operativi
select matricola, cognome, nome
from studenti join esami on matricola=studente 
where voto>=18 and codicecorso=1
intersect
select matricola, cognome, nome
from studenti join esami on matricola=studente 
where voto>=18 and codicecorso=2
except
select matricola, cognome, nome
from studenti join esami on matricola=studente 
where voto<18 and codicecorso=3

//Selezionare lo studente che ha subito il maggior numero di bocciature 
select matricola, cognome, nome, count(*) as bocciature
from studenti join esami on matricola=studente
where voto<18
group by matricola, cognome, nome
having count(*)>= all(
  select count(*) as bocciature
  from studenti join esami on matricola=studente
  where voto<18
  group by matricola, cognome, nome
)


------------
Esercizio 2

//selezionare il nome delle bevande, dei frutti e delle verdure di cui sono state vendute almeno 20 unità
select nome
from Prodotti join Vendite on Sigla=SiglaProd
where categoria = 'Bevanda'
group by nome
having sum(quantità)>20
union
select nome
from Prodotti join Vendite on Sigla=SiglaProd
where categoria = 'Verdura'
group by nome
having sum(quantità)>20
union
select nome
from Prodotti join Vendite on Sigla=SiglaProd
where categoria = 'Frutta'
group by nome
having sum(quantità)>20

//selezionare il nome dei prodotti di cui sono state vendute meno di 30 unità sia il 19 che il 20 ottobre 2017
select nome
from Prodotti join Vendite on Sigla=SiglaProd
where data='2017-10-18'
group by nome
having sum(quantità)<30
intersect
select nome
from Prodotti join Vendite on Sigla=SiglaProd
where data='2017-10-19'
group by nome
having sum(quantità)<30

//selezionare le date in cui sono state vendute almeno 10 unità di frutta e di verdura ma non è stato venduto formaggio
select data
from Prodotti join Vendite on Sigla=SiglaProd
where categoria='Verdura'
group by data, categoria
having sum(quantità)>=10
intersect
select data
from Prodotti join Vendite on Sigla=SiglaProd
where categoria='Frutta'
group by data, categoria
having sum(quantità)>=10
except
select data
from Prodotti join Vendite on Sigla=SiglaProd
where categoria='Formaggio'
group by data, categoria
having sum(quantità)>0

--------------------
Esercizio 3

create table Persone(
  CF char(16) primary key,
  Cognome varchar(20),
  Nome varchar(20),
  Età smallint
);

create table Immobili(
  Codice char(10) primary key,
  Via varchar(20),
  NumeroCivico varchar(5),
  Città varchar(20),
  Valore numeric
);

create table Proprietà(
  Persona char(16) references Persone(CF),
  Immobile char(10)references Immobili(Codice),
  Percentuale numeric,
  primary key (Persona,Immobile)
);

//Mostrare la città in cui non ci sono immobili di valore inferiore ai 50.000 euro 
select distinct Città from Immobili where Città not in (select Città from Immobili where Valore < 50000)

//Mostrare l'età delle persone che non posseggono immobili al 50%.
select distinct CF, Età
from Persone join Proprietà on CF=Persona
where CF not in (
  select CF 
  from Persone join Proprietà on CF=Persona
  where Percentuale = 50
)

//Mostrare il codice fiscale della persona che possiede il maggior numero di immobili
select Persona p, count(*) as num
  from Proprietà
  group by Persona
  having count(*) >= all(
    select count(*)
    from Proprietà
    group by Persona
)


