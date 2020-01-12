# BDD_SQL-MTNAH
Exercice MCD, MRD et script dans le cadre du cours BDD_SQL du MTNAH-ENC

## Consignes
------------

*Le directeur du CNSM souhaite mettre en place une application de suivi des étudiants du département « musique classique ».*

On a besoin de conserver les informations concernant :

• les étudiants : leur classe (1 à 5 : 1ère année, 2e année, etc.), instrument (guitare, piano, violon...), les enseignements suivis (solfège, composition...), etc. ;

• les professeurs : enseignements dispensés, etc. ;

• les salles de cours : nom, capacité, etc.

### Les données à stocker :

• Un professeur a un nom, un prénom, une date de naissance, dispense un ou plusieurs enseignements.

• Un étudiant a un nom, un prénom, une date de naissance, un seul instrument et suit plusieurs enseignements. Il appartient à une seule classe (1 à 5).

• Les étudiants obtiennent une note coefficientée pour chaque enseignement suivi.

• Les cours se déroulent à une date, dans une certaine salle.

• Une salle a un nom et un nombre maximum de place.

1. Concevoir et documenter le MCD avec Mocodo (http://mocodo.wingi.net/), ou yEd (https://www.yworks.com/products/yed) ou draw.io (https://www.draw.io/).

2. Produire le diagramme du MRD avec MySQL Workbench (https://www.mysql.com/fr/products/workbench/) et exporter le script SQL de génération de la base.

### Rendu :
- Diagramme MCD (.png) avec un petit paragraphe justifiant vos choix.
- Diagramme MRD (.png)
- Script SQL (.sql)

## Réalisation
--------------
#### Description du MCD :

[voir image](MCD_CNSM.png)

#### Les six entités présentées dans ce schéma sont les suivantes :

- "Etudiants" [STUDENTS] qui reçoit comme attributs : ID, Nom, Prénom, Date de naissance)
- "Classe" [CLASS_DEGREE] qui reçoit comme attributs : ID, le niveau d'étude (de 1 à 5)
- "Instruments" [INSTRUMENTS] qui reçoit comme attributs : ID, Type de l'instrument (noté Label)
- "Salles de cours" [CLASSROOMS] qui reçoit comme attributs : ID, Nom, Capacité d'acceuil maximum
- "Cours" [COURSES] qui reçoit comme attributs : ID, Nom (Label), Coefficient, date du cours
- "Enseignants" [TEACHERS] qui reçoit comme attributs : ID, Nom, Prénom, Date de naissance

#### A propos des associations :

- TEACHERS >< COURSES (Teach)

un enseignant enseigne un à plusieurs cours

un cours est enseigné par un et un seul enseignant

 - CLASSROOMS >< COURSES (Take_place)

un cours a lieu dans une et une seule salle de cours

une salle de cours peut donner lieu à un à plusieurs cours

- INSTRUMENTS >< STUDENTS (Play)

un étudiant peut jouer un et un seul instrument

un instrument peut être joué par un ou plusieurs étudiants

- CLASS_DEGREE >< STUDENTS (Is_part_of)

un étudiant fait parti d'une et une seule classe

une classe peut recenser un ou plusieurs étudiants

- STUDENTS >< COURSES (Follow)

un étudiant suit un ou plusieurs cours pour lesquels il reçoit une note

un cours peut être suivi par un ou plusieurs élèves qui reçoivent une note


#### Notes et diffcultés :

- La problématique principale se situe au niveau de l'association note entre étudiants et discipline. En effet, on considère ici qu'un étudiant suit effectivement et valide un cours par l'obtention d'une note (contrainte obligatoire). Pour nous aider dans l'établissement de cette association "suivre un cours" entre l'étudiant et la discipline on peut résumer l'association par une phrase contextuelle du type : "A l'issue d'un examen ou d'un contrôle surprise, la note de X/20 ou le score A,B,C...(Score, attribut et condition de "suivre un cours" ou "Follow") a été obtenue par un étudiant (Students) dans une matière (Courses) enseignée (Teach) par un enseignant(Teacher)".

- Créer des entités "Class_degree" et "Instruments", permettra, suivant les objectifs poursuivis et d'un point de vue applicatif, de lancer des requêtes de recherche sur des étudiants par instruments ou par promotions. 
