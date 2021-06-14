create table Persone(
	CF char(16) primary key,
	Cognome varchar(20),
	Nome varchar(20),
	Eta smallint
);	

create table Immobili(
	Codice varchar(20) primary key,
	Via varchar(20),
	NumeroCivico 
	Citta varchar(30),
	Valore Numeric
);

create table Proprieta(
	Persona char(16) references Persone(CF),
	Immobile varchar(20) references Immobili(Codice),
	Percentuale numeric,
	primary key(Persona, Immobile)
);



--trovare codice fiscale di paolo rossi
select CF 
from Persone
where Cognome = 'Rossi' AND Nome = 'Paolo';


--estraggo immobili posseduti da paolo rossi
select Immobile
from Proprieta
where Persona IN (	select CF			
					from Persone
					where Cognome = "Rossi" AND Nome "Paolo");

--diminuiure del 10% il valore degli immobili di paolo rossi
update Immobili
	set valore  = valore * 0.9 
	where Codice in (	select Immobile
						from Proprieta
						where Persona IN (	select CF
											from Persone
											where Cognome = 'Rossi' AND 'Paolo'));

--oppure

update Immobili
set valore = 0.9 * valore
where Codice in( select Immobile	
				 from Proprieta join Persone on Persona = CF
				 where Cognome = 'Rossi' and Nome = 'Paolo');	


--Aggiornare il db in seguito alla vendita delle proprieta di Paolo Rossi
--a Catania a favori di Neri Sara.
update proprieta
set persona = ( select cf 
				from persone
				where nome = 'Sara' AND cognome = 'Neri');
where (persona, immobile) in (
							select cf, codice
							from persona join proprieta on cf = persona
										 join immobili on immobile = codice
							where  cognome = 'Rossi' and nome = 'Paolo');

--trovo gli immobili di paolo rossi a catania
select proprieta
from persone join proprieta on cf = Persona
			 join immobili on immobile = codice
where nome = 'Paolo' and 'Cognome' = 'Rossi' and citta = 'Catania';


--mostrare la citta dove non ci sono immobili di valore < di 50000

select distinct citta
from immobili 
where valore < 50000

select distinct citta
from immobili 
where citta not in (select citta
					from immobili 
					where valore < 50000);

--oppure

select distinct citta
from immobili
except  select citta
		from immobili
		where valore < 50000;

--oppure 
select distinct citta
from immobili i
where not exists(	select *
					from immobili
					where i.citta = citta
					and valore < 50000); 


--mostrare l'eta delle persone che non posseggono immobili al 50%

--persone che non posseggono immobili al 50%
select distinct persona
from proprieta
where percentuale != 50;

select eta, cognome, nome
from persone 
where cf in (select distinct persona
			from proprieta
			where percentuale != 50);

--mostrare il codice fiscale della persona che possiede il maggior
--numero di immobili

select cf, count(*) as numImmobili
from persone join proprieta on persone.cf = proprieta.persona
group by cf;


select cf
from persone join proprieta on persone.cf = proprieta.persona

--esercizio 1
create table studenti(
	matricola numeric primary key,
	cognome varchar(30) not null,
	nome varchar(30) not null,
	eta smallint not null
);

create table esami(
	codicecorso smallint primary key,
	studente numeric references studenti(matricola)
		on update cascade
		on delete restrict,
	data date not null, 
	voto smallint not null
);
 


