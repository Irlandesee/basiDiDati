CREATE TABLE STUDENTI(
	Matricola NUMERIC PRIMARY KEY,
	Cognome VARCHAR(20) NOT NULL,
	Nome VARCHAR(20) NOT NULL,
	Eta SMALLINT NOT NULL

);

CREATE TABLE ESAMI(
	CodiceCorso NUMERIC NOT NULL,
	Studente NUMERIC NOT NULL REFERENCES STUDENTI(Matricola)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION, #clausule di sicurezza -> se vengono applicate modifiche errate
						#queste clausule blocheranno modifiche 
	Data DATE NOT NULL,
	voto NUMERIC NOT NULL,
	PRIMARY KEY(CodiceCorso, Studente, Data)
);


SELECT *
FROM Studenti JOIN ESAMI
	ON STUDENTI.matricola = Esami.Studente
WHERE ESAMI.voto < 18

select matricola, cognome, nome
from Studenti join Esami 
	on Studenti.matricola = Esami.studente
where Esami.voto < 18
GROUP BY(matricola, cognome, nome)

select matricola, cognome, nome, count(*) as numBucciature
from Studenti join Esami 
	on Studenti.matricola = Esami.studente
where Esami.voto < 18
GROUP BY(matricola, cognome, nome)
ORDER BY cognome, nome