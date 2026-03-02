/* =========================================================
   JEU DE DONNÉES - Cours SQL (BTS SIO SLAM) - MySQL 8+
   Chargé automatiquement par docker-entrypoint-initdb.d
   Base : cours_sql_tp
   ========================================================= */

DROP DATABASE IF EXISTS cours_sql_tp;
CREATE DATABASE cours_sql_tp CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE cours_sql_tp;

/* 1) Personne / Adresse */
DROP TABLE IF EXISTS Personne;
DROP TABLE IF EXISTS Adresse;

CREATE TABLE Adresse (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  voie VARCHAR(120) NOT NULL,
  cp VARCHAR(10) NOT NULL,
  ville VARCHAR(80) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Personne (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  id_adresse INT UNSIGNED NULL,
  CONSTRAINT fk_personne_adresse
    FOREIGN KEY (id_adresse) REFERENCES Adresse(id)
    ON UPDATE RESTRICT
    ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO Adresse(voie, cp, ville) VALUES
('1, rue Ici', '75002', 'Paris'),
('12, rue Labas', '75015', 'Paris'),
('742 Evergreen Terrasse', '00000', 'Springfield'),
('Chemin perdu', '66000', 'Perpignan');

INSERT INTO Personne(nom, prenom, id_adresse) VALUES
('Durand','Marie',4),
('Simpson','Bart',3),
('Dubois','Jean',NULL),
('Simpson','Lisa',3),
('Durand','Paul',NULL);

/* 2) Gens */
DROP TABLE IF EXISTS Gens;

CREATE TABLE Gens (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  age INT UNSIGNED NOT NULL
) ENGINE=InnoDB;

INSERT INTO Gens(nom, prenom, age) VALUES
('Dupond','Pierre',24),
('Martin','Marc',48),
('Dupont','Jean',51),
('Martin','Paul',36),
('Dupond','Lionel',68),
('Chirac','Jacques',70);

/* 3) Client / Produit / Achat */
DROP TABLE IF EXISTS Achat;
DROP TABLE IF EXISTS Produit;
DROP TABLE IF EXISTS Client;

CREATE TABLE Client (
  IDC INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  ville VARCHAR(80) NOT NULL,
  anneeN YEAR NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Produit (
  IDP INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  description VARCHAR(120) NOT NULL,
  prix DECIMAL(10,2) NOT NULL,
  CHECK (prix >= 0)
) ENGINE=InnoDB;

CREATE TABLE Achat (
  IDA INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  RefC INT UNSIGNED NOT NULL,
  RefP INT UNSIGNED NOT NULL,
  quantite INT UNSIGNED NOT NULL,
  dateAchat DATE NOT NULL,
  CONSTRAINT fk_achat_client FOREIGN KEY (RefC) REFERENCES Client(IDC)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_achat_produit FOREIGN KEY (RefP) REFERENCES Produit(IDP)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CHECK (quantite > 0)
) ENGINE=InnoDB;

INSERT INTO Client(nom, prenom, ville, anneeN) VALUES
('Chaouki','Ahmed','Rabat',1980),
('El Amrani','Sara','Salé',1999),
('Martin','Nina','Paris',2002),
('Moussaoui','Karim','El Jadida',1970),
('Mouline','Imane','Rabat',1975);

INSERT INTO Produit(description, prix) VALUES
('PC Portable i5 16Go', 6500.00),
('Écran 24 pouces', 1500.00),
('Clavier mécanique', 650.00),
('Souris gaming', 420.00),
('SSD 1To', 1100.00),
('Câble HDMI', 90.00),
('Casque audio', 900.00);

INSERT INTO Achat(RefC, RefP, quantite, dateAchat) VALUES
(1,1,1,'2025-01-10'),
(1,5,2,'2025-02-05'),
(2,3,1,'2025-02-12'),
(2,6,3,'2025-03-01'),
(3,2,1,'2025-03-03'),
(4,4,2,'2025-03-15'),
(5,7,1,'2025-04-02'),
(5,2,2,'2025-04-03');

/* 4) Emp / Pay / Project / Works */
DROP TABLE IF EXISTS Works;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Emp;
DROP TABLE IF EXISTS Pay;

CREATE TABLE Pay (
  title VARCHAR(50) PRIMARY KEY,
  salary DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Emp (
  Eno VARCHAR(5) PRIMARY KEY,
  Ename VARCHAR(80) NOT NULL,
  Title VARCHAR(50) NOT NULL,
  City VARCHAR(80) NOT NULL,
  CONSTRAINT fk_emp_pay FOREIGN KEY (Title) REFERENCES Pay(title)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE Project (
  Pno VARCHAR(5) PRIMARY KEY,
  Pname VARCHAR(80) NOT NULL,
  Budget DECIMAL(12,2) NOT NULL,
  City VARCHAR(80) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Works (
  Eno VARCHAR(5) NOT NULL,
  Pno VARCHAR(5) NOT NULL,
  Resp VARCHAR(50) NOT NULL,
  Dur INT UNSIGNED NOT NULL,
  PRIMARY KEY (Eno, Pno),
  CONSTRAINT fk_works_emp FOREIGN KEY (Eno) REFERENCES Emp(Eno)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_works_project FOREIGN KEY (Pno) REFERENCES Project(Pno)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO Pay(title, salary) VALUES
('Dev', 3200.00),
('DBA', 4200.00),
('ChefProjet', 4800.00),
('Testeur', 3000.00);

INSERT INTO Emp(Eno, Ename, Title, City) VALUES
('E1','Alice Martin','Dev','Paris'),
('E2','Bruno Dupont','DBA','Paris'),
('E3','Carla Durand','Testeur','Lyon'),
('E4','David Morel','Dev','Lyon'),
('E5','Eva Simon','ChefProjet','Paris');

INSERT INTO Project(Pno, Pname, Budget, City) VALUES
('P1','Site e-commerce', 120000.00, 'Paris'),
('P2','Application mobile', 90000.00, 'Lyon'),
('P3','Datawarehouse', 200000.00, 'Paris'),
('P4','Outil interne RH', 45000.00, 'Saint-Etienne');

INSERT INTO Works(Eno, Pno, Resp, Dur) VALUES
('E1','P1','Dev Front',6),
('E2','P1','DB Admin',6),
('E4','P2','Dev Back',5),
('E3','P2','Tests',5),
('E5','P3','Pilotage',8),
('E2','P3','DB Design',8),
('E1','P4','Dev',2);

/* 5) Article / commande / ligne_commande */
DROP TABLE IF EXISTS ligne_commande;
DROP TABLE IF EXISTS commande;
DROP TABLE IF EXISTS Article;

CREATE TABLE Article (
  IdArticle INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  Designation VARCHAR(120) NOT NULL,
  Prix DECIMAL(10,2) NOT NULL,
  QteStock INT UNSIGNED NOT NULL,
  CHECK (Prix >= 0)
) ENGINE=InnoDB;

CREATE TABLE commande (
  IdCommande INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  IdClient INT UNSIGNED NOT NULL,
  DateComm DATE NOT NULL,
  CONSTRAINT fk_commande_client FOREIGN KEY (IdClient) REFERENCES Client(IDC)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE ligne_commande (
  IdCommande INT UNSIGNED NOT NULL,
  IdArticle INT UNSIGNED NOT NULL,
  QteComm INT UNSIGNED NOT NULL,
  PRIMARY KEY (IdCommande, IdArticle),
  CONSTRAINT fk_lc_cmd FOREIGN KEY (IdCommande) REFERENCES commande(IdCommande)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_lc_art FOREIGN KEY (IdArticle) REFERENCES Article(IdArticle)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CHECK (QteComm > 0)
) ENGINE=InnoDB;

INSERT INTO Article(Designation, Prix, QteStock) VALUES
('Switch 8 ports', 39.90, 20),
('Routeur WiFi', 59.90, 15),
('Clé USB 64Go', 12.50, 100),
('Imprimante', 129.00, 6),
('Onduleur', 89.00, 9);

INSERT INTO commande(IdClient, DateComm) VALUES
(1,'2025-04-10'),
(3,'2025-04-12'),
(5,'2025-04-20');

INSERT INTO ligne_commande(IdCommande, IdArticle, QteComm) VALUES
(1,1,2),
(1,3,5),
(2,2,1),
(2,4,1),
(3,5,2);
