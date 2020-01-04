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

#### Les entités présentées dans ce schéma sont les suivantes : 

- Etudiants [STUDENTS] qui reçoit comme attributs : ID, Nom, Prénom, Date de naissance)
- Classes [CLASS_DEGREE] qui reçoit comme attributs : ID, Année d'étude
- Les instruments [INSTRUMENTS] qui reçoit comme attributs : ID, Type de l'instrument (noté Label)
- Les salles de cours [CLASSROOMS] qui reçoit comme attributs : ID, Nom, Capacité d'acceuil maximum
- Le cours [COURSES] qui reçoit comme attributs : ID, Nom (Label), Coefficient, Jour de la semaine et une heure
- Enseignants [TEACHERS] qui reçoit comme attributs : ID, Nom, Prénom, Date de naissance

#### A propos des les associations : 

- Enseignants >< Cours (Teach)

un enseignant enseigne un à plusieurs cours
un cours est enseigné par un et un seul enseignant

 - Salle de cours >< Cours (Take_place)
 
un cours a lieu dans une et une seule salle de cours
une salle de cours peut donner lieu à un à plusieurs cours

- Instruments >< Etudiants (Play)

un étudiant peut jouer un et un seul instrument
un instrument peut être joué par un ou plusieurs étudiants

- Classes >< Etudiants (Is-part-of)

un étudiant fait parti d'une et une seule classe
une classe peut recenser un ou plusieurs étudiants 

- Etudiants >< Cours (Follow)

un étudiant suit un ou plusieurs cours 
un cours peut être suivi par un ou plusieurs élèves

- Etudiants >< Cours (Pass-an-exam)

Un étudiant passe un examen pour lequel il reçoit une note (Score) dans un ou plusieurs cours
Un cours peut donner lieu à un ou plusieurs contrôles qui donne lieu à une note pour un à plusieurs étudiants

#### Notes et diffcultés :

Pour nous aider dans l'établissement de l'association "passer un examen" entre l'étudiant et la discipline
on peut résumer l'association par une phrase contextuelle du type : "A l'issue d'un examen ou d'un contrôle surprise, 
la note de X/20 ou le score A,B,C...(Score, attribut de l'association pass-an-exam) a été obtenue par un étudiant (Students) dans une matière (Courses) enseigné (Teach) par un enseignant(Teacher)"
dès lors l'association passer un examen se fait entre l'étudiant et le cours enseigné par un enseignant, et non pas un enseignant qui attribut une note à l'étudiant.



