--esercizio 1
--definire le seguenti tabelle
/**
    table Autore(Nome, Cognome, DataNascita, Nazionalita)
    table Libro(TitoloLibtro, NomeAutore, CognomeAutore, Lingua)
**/

    CREATE TABLE AUTORE(
        Nome VARCHAR(30),
        Cognome VARCHAR(30),
        DataNascita DATE NOT NULL,
        Nazionalita VARCHAR(20) NOT NULL,
        PRIMARY KEY(Nome, Cognome) 
    );

    CREATE TABLE LIBRO(
        TitoloLibro VARCHAR(30) PRIMARY KEY,
        NomeAutore VARCHAR(30),
        CognomeAutore VARCHAR(30),
        Lingua VARCHAR(20) NOT NULL,
        FOREIGN KEY(NomeAutore, CognomeAutore) REFERENCES AUTORE 
            ON UPDATE CASCADE ON DELETE CASCADE
    );

--domande
/**
    1) è opportuno definire vincoli di integrita referenziale?
        1a) per ogni vincolo di integrità referenziale eventualmente definito
            identificare le politiche da adottare in seguito a cancellazione e
            modifica della relazione riferita
    2) cosa può accadere in seguito ai seguenti comandi di aggiornameto?
        -> DELETE FROM AUTORE WHERE Cognome = 'Rossi'
        -> INSERT INTO autore (nome, congnome, datanascita, nazionalita) 
                VALUES('italo,'calvino','1923-10-15','italiana')
        -> UPDATE AUTORE set Nome = 'Italo' WHERE Cognome = 'Calvino'
**/

--esercizio 2
--definire i comandi sql per
/**
    1)aggiungere la colonna Anno alla tabella libro
    2)specificare Italiano come valore di default di lingua
    3)aggiungere un vincolo che non permetta di specificare valori null per Anno
    4)Modificare lo schema di LIBRO eliminando la colonna Lingua
    5)Popolare le tabelle AUTORE e LIBRo
    6)Selezionare tutti i libri scritti da calvino ordinandoli per anno dal più recente
    7)selezionare tutti gli autori di nazionalita italiana
    8)Eliminare la tabella AUTORE e tutto il suo contenuto
**/

--aggiunge la colonna anno alla tabella libro
ALTER TABLE LIBRO 
    ADD anno NUMERIC(4);
--specificare italiano come valore di default di lingua
ALTER TABLE LIBRO
    ALTER COLUMN lingua SET DEFAULT 'Italiano';  --da errore ma è corretta
--aggiungere un vincolo che non permetta di specificare valori null per Anno
ALTER TABLE LIBRO
    ALTER COLUMN anno SET NOT NULL; --da errore ma è corretta vacca boia
--modificare lo schema di libro eliminando la colonna libro 
ALTER TABLE LIBRO
    DROP COLUMN anno;
--popolare le tabelle AUTORE e LIBRO
INSERT INTO AUTORE(nome, cognome, datanascita, nazionalita)
    VALUES('steven', 'erikson', '1959-10-07', 'canadese')
INSERT INTO LIBRO(titoloLibro, nomeAutore, cognomeAutore, lingua)
--selezionare tutti i libri scritti da calvino ordinandoli per anno dal più recente
SELECT titoloLibro 
FROM LIBRO
WHERE nomeAutore = 'Italo' AND cognomeAutore = 'Calvino'
ORDER BY anno
--selezionare tutti gli autori di nazionalita italiana
SELECT nomeAutore, cognomeAutore
FROM AUTORE
WHERE nazionalita = 'italiana';
--Eliminare la tabella AUTORE e tutto il suo contenuto 
DROP TABLE AUTORE CASCADE;

--esercizio 3
--si considerino le relazioni
/**
    table FONDISTA(Nome, Nazione, Eta)
    table GAREGGIA(NomeFondista, NomeGara, Piazzamento)
    table GARA(Nome, Luogo, Nazione, Lunghezza)
**/
CREATE TABLE FONDISTA(
    Nome VARCHAR(40) PRIMARY KEY,
    Nazione VARCHAR(30) NOT NULL,
    Eta NUMERIC(10),
);

CREATE TABLE GARA(
    Nome VARCHAR(40) PRIMARY KEY,
    Luogo VARCHAR(40) NOT NULL,
    Nazione VARCHAR(40) NOT NULL,
    Lunghezza NUMERIC(10) NOT NULL
);

CREATE TABLE GAREGGIA(
    NomeFondista VARCHAR(40) REFERENCES FONDISTA(Nome),
    NomeGara VARCHAR(40) REFERENCES GARA(Nome),
    Piazzamento NUMERIC(20) NOT NULL
);

--identificare gli eventuali vincoli di integrità referenziale e le politiche
    --da adottare per la cancellazione e modifica
--fornire la definizione SQL

--esercizio 4
/**
    Si supponga di colre rappresentare in una base di dati relazione le informazioni
    relative all'iscrizione di studenti ad appelli di esami universitari
**/
    --identificare le relazioni coinvolte caratterizzandone gli attributi
    --Identificare le chiavi di ogni relazione
    --identificare le eventuali chiavi esterne presenti nello schema indicando
        --per ognuna di esse la relazione referente e riferita
    --quali altri vincoli potrebbero essere definiti?
    --fornire la definizione SQL

--esercizio 5