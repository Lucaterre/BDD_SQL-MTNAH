PRAGMA encoding = 'UTF-8';

-- base SQLite du CNSM, Lucas TERRIEL, M2TNAH ENC, Janvier 2020 

-- Remarques préliminaires :

-- 1: on considère que les étudiants et les professeurs on fourni l'entièreté de leurs informations lors des formalités d'inscription au conservatoire et lors de l'embauche (attributs NOT NULL) 
-- 2: On part du principe que les professeurs, les étudiants, et les enseignements(Unité Enseignement) possèdent des identifiants uniques dès le départ qui sont très peu succeptibles de changer dans le temps (inscrit dans un répertoire national par exemple)
-- 3: pour faire suite au 2: en revanche de nouveaux instruments peuvent être enseignés d'année en année et les salles de cours peuvent évolués en fonction des batiments occupés (exemple, travaux dans une salle innaccessible pour une période) et reçoivent des ID chargés par le système lui-même, soit la valeur AUTOINCREMENT
-- NULL : absence de données, la donnée n'existe pas
-- NOT NULL : la donnée est renseigné 


CREATE TABLE professeur (                   -- Table professeur --        
  id INTEGER PRIMARY KEY,                   -- ! identifiant des professeurs : n° professeur qui peut contenir seulement des nombres 
  nom TEXT NOT NULL,                        -- ! nom 
  prenom TEXT NOT NULL,                     -- ! prénom        
  date_naissance TEXT NOT NULL              -- ! date de naissance, AAAA-MM-JJ
);

-- les professeurs enseigne des UE, professeur >< enseignement 
CREATE TABLE enseigne (                     
  profid INTEGER NOT NULL REFERENCES professeur(id),
  enseignementid INTEGER NOT NULL REFERENCES enseignement(id),
  PRIMARY KEY (professeur(id), enseignement(id))
  
);

CREATE TABLE instrument (                   -- Table instrument -- 
  id INTEGER PRIMARY KEY AUTOINCREMENT,     -- ! instrument(id)
  instrument TEXT NOT NULL                  -- ! type d'instrument 
);
-- les enseignements ont lieu dans des salles de cours à une date donnée, enseignement >< salle 
CREATE TABLE cours (
  salleid INTEGER NOT NULL REFERENCES salle(id),
  enseignementid INTEGER NOT NULL REFERENCES enseignement(id),
  date_cours TEXT NOT NULL                  -- date du cours, AAAA-MM-JJ
);

CREATE TABLE enseignement (                 -- Table enseignement -- 
  id INTEGER PRIMARY KEY,                   -- ! numéro de l'UE
  intitule TEXT NOT NULL,                   -- ! intitulé du cours                 
  coeff INTEGER NOT NULL                    -- ! coefficient pour l'UE
);

CREATE TABLE salle (                        -- Table salle --                     
  id INTEGER PRIMARY KEY AUTOINCREMENT,     -- ! salle(id) : on part du principe qu'il s'agit d'une suite de nombres sans caractères
  nom_salle TEXT NOT NULL,                  -- ! nom de la salle                       
  capacite INTEGER NOT NULL                 -- ! capacité maximum d'acceuil des étudiants dans les salles de cours
);
-- les étudiants étudie des UE, etudiant >< enseignement 
CREATE TABLE etudie (
  etudiantid INTEGER NOT NULL REFERENCES etudiant(id),
  enseignementid INTEGER NOT NULL REFERENCES enseignement(id),
  note INTEGER NULL CHECK (note <= 20)                     -- ? note obligatoire reçu par l'étudiant dans l'UE suvie (note de 0 à 20), cependant la note n'est pas remplie immédiatement
);

CREATE TABLE etudiant (                     -- Table étudiant
  id INTEGER PRIMARY KEY,                   -- ! identifiant des étudiants : n° étudiant qui peut contenir suelement des nombres
  nom TEXT NOT NULL,                        -- ! nom 
  prenom TEXT NOT NULL,                     -- ! prénom
  date_naissance TEXT NOT NULL,             -- ! date de naissance, AAAA-MM-JJ
  classe INTEGER NOT NULL CHECK (classe >= 1 AND classe <= 5),           -- ! niveau de la classe (promotion de 1ere à 5eme année)
  instrumentid INTEGER NOT NULL REFERENCES instrument(id)                -- ! référence de l'instrument joué par l'étudiant
);