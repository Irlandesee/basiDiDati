#tables:
/*
*	STUDENTI(Matricola, Cognome, Nome, Eta)
*	ESAMI(CodiceCorso, Studente, Data, Voto)
*/

-- query 1
/* Trovare le coppie di studenti(mostrare le sole matricole)
per i quali uno dei due ha riportato un voto più alto di 
quello  riportato dall'altro in tutti gli esami 
superati da entrambi */

--?
SELECT
From Esami e1, Esami e2
WHERE e1.voto > (	Select Voto
					From Esami
					WHERE voto > 18
					AND (studente = e2.studente AND e1.codiceCorso = e2.codiceCorso));

--oppure query insiemistica
SELECT e1.codiceCorso, e1.studente as studenteMigliore,
		e2.studente as studentePeggiore, e1.voto, e2.voto
FROM Esami e1, Esami e2
WHERE e1.voto > ALL(SELECT e3.voto
					FROM Esami e3
					WHERE e3.voto > 18
						AND e3.studente = e2.studente
						AND e3.codiceCorso = e2.codiceCorso)


--query 2
/* Mostrare per ogni corso gli studenti che hanno provato 
l'esame più volte ma che alla fine sono stati promossi */

SELECT *
FROM Esami e1
WHERE e1.voto >= 18
	AND EXISTS(SELECT *
			   FROM Esami e2
			   WHERE e2.voto < 18 
			   AND e1.codiceCorso = e2.codiceCorso)

--query 3
/* Mostrare il corso con il maggior numero di bocciature */

--query 4
/* Mostrare i corsi con il minor numero di appelli*/

--query 5
/* Mostrare per ogni corso lo studente che ha 
	superato l'esame con il voto più alto*/

--originale
SELECT e1.studente, e1.voto, e1.data
FROM Esami e1
WHERE e1.voto >= 18
	AND NOT EXISTS(SELECT e2.voto
					FROM Esami e2
					WHERE e2.voto > e1.voto 
					AND e2.codiceCorso = e1.codiceCorso);
--opzionale
SELECT e1.studente, s.cognome, s.nome, e1.voto, e1.data
FROM Esami e1 JOIN Studenti s ON(e1.studente = s.matricola)
WHERE e1.voto >= 18
	AND NOT EXISTS(SELECT e2.voto
					FROM Esami e2
					WHERE e2.voto > e1.voto 
					AND e2.codiceCorso = e1.codiceCorso);

--oppure

SELECT e1.studente, e1.voto, e1.data
FROM Esami e1
WHERE  e1.voto >= 18 
		AND e1.voto >= ALL(SELECT e2.voto
							FROM Esami e2
							EHERE e2.voto >= 18);







