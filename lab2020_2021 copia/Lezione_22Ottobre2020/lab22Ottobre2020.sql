CREATE TABLE ATTORI(
    CodAttore NUMERIC PRIMARY KEY,
    Nome VARCHAR(40) NOT NULL
);

CREATE TABLE FILM(
    CodFilm NUMERIC PRIMARY KEY,
    Titolo VARCHAR(40) NOT NULL,
    AnnoProduzione NUMERIC NOT NULL,
    Nazione VARCHAR(40) NOT NULL,
    Regista VARCHAR(40) NOT NULL,
    Genere VARCHAR(40)  NOT NULL
);

CREATE TABLE RECITA(
    CodAttore NUMERIC REFERENCES ATTORI(CodAttore),
    CodFilm NUMERIC REFERENCES FILM(CodFilm),
    PRIMARY KEY(CodAttore, CodFilm)
);

CREATE TABLE SALE(
    CodSala NUMERIC PRIMARY KEY,
    NomeSala VARCHAR(40) DEFAULT 'Sala 1',
    NomeCinema VARCHAR(40) NOT NULL,
    Citta VARCHAR(40) NOT NULL
);

CREATE TABLE PROIEZIONI( 
    CodProiezione NUMERIC PRIMARY KEY,
    CodFilm NUMERIC REFERENCES FILM(CodFilm)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CodSala NUMERIC REFERENCES SALE(CodSala)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    DataProiezione DATE NOT NULL 
);


--1.    il nome di tutte le sale di tutti i cinema di varese
SELECT NomeSala
FROM sale
WHERE citta = 'Varese';

--2.    il titolo dei film di sergio leone prodotti dopo il 1960
--      ordinate per anno di produzione
select titolo
from film 
where regista = 'Sergio Leone' and AnnoProduzione >= 1960
order by AnnoProduzione;


--3.    L'elenco dei film diretti da Sergio Leone prodotti tra il 
--      1965 e il 1970, formattati come "Titolo(Nazione, Anno)",
--      e ordinate per anno di produzione dal più recente al meno recente
select format('%s (%s, %s)', titolo, nazione, annoproduzione)
from film
where regista = 'Sergio Leone' 
    and AnnoProduzione BETWEEN 1965 AND 1970
ORDER BY AnnoProduzione DESC;

--4.    Il titolo dei film western prodotti dopo il 1962 interpretati da
--      CLint Eastwood

select distinct titolo
from film, recita
where genere = 'Western' and annoproduzione >= 1962
    and recita.codattore = (select CodAttore
                            from attori
                            where nome = 'Clint Eastwood');

--5.    Il titolo ed il genere dei film proiettati il giorno 6/1/2016

--6.    Il titolo dei film proiettati il giorno 7/1/2016 nei cinema di Gallarate

--7.    L'elenco degli attori che hanno lavorato nei film di leone ordinato alfabeticamente

--8.    I nomi dei cinema di Varese in cui il 6/1/2016 è stato proiettato un film con
--      Clint Eastwood

--9.    Per ogni film in cui recita Clint Eastwood, il titolo del film e il nome
--      del regista

--10.   Per ogni film che è stato proiettato a Varese nel gennaio del 2016,
--      il titolo del film e il nome della sala


