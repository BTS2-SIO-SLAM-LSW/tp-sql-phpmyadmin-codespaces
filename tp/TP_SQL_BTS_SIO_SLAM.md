# TP SQL — BTS SIO SLAM (phpMyAdmin)

> Base : **cours_sql_tp** (chargée automatiquement au démarrage Docker)

## Consignes de rendu
- Compléter les fichiers :
  - `LDD_reponses.sql`
  - `LMD_reponses.sql`
  - `LCD_reponses.sql`
- Chaque exercice : **commentaire + requête(s)**.
- Exécuter et vérifier les résultats dans phpMyAdmin.

---

# THÈME 1 — LDD (Structures)

## Résumé (à connaître)
Le **LDD** (Langage de Définition de Données) permet d’agir sur la **structure** :
- `CREATE DATABASE`, `DROP DATABASE`
- `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`, `RENAME`
- Contraintes : `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, `CHECK`
- Index : `CREATE INDEX`, `DROP INDEX`

## Exercices LDD (10)
1. Créer une base `tp_structures` puis l’utiliser.
2. Créer une table `Departement` (id PK AI, nom NOT NULL, budget DECIMAL, CHECK budget>0).
3. Créer une table `Employe` (id PK AI, nom NOT NULL, prenom, salaire, id_departement FK).
4. Modifier `Employe` pour rendre `salaire` NOT NULL avec DEFAULT 2000.00.
5. Ajouter un champ `email` UNIQUE dans `Employe`.
6. Créer un index sur `Employe(nom)`.
7. Renommer `Departement` en `Service`.
8. Modifier le type de `budget` en DECIMAL(12,2).
9. Supprimer la contrainte UNIQUE sur `email` (supprimer l’index UNIQUE correspondant).
10. Supprimer toutes les tables de `tp_structures` puis supprimer la base.

---

# THÈME 2 — LMD (Données)

## Résumé (à connaître)
Le **LMD** (Langage de Manipulation de Données) permet d’agir sur les **données** :
- `INSERT` (ajouter)
- `UPDATE` (modifier)
- `DELETE` (supprimer)
- `SELECT` (consulter)

Points d’attention :
- `UPDATE`/`DELETE` sans `WHERE` = impact sur toute la table.
- Agrégats (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) : pas dans `WHERE` → utiliser `HAVING` après `GROUP BY`.

## Exercices LMD (10) — base `cours_sql_tp`
1. Insérer un client : `Dupuis Léa, Lyon, 2001`.
2. Insérer un produit : `Webcam HD`, 350.00.
3. Enregistrer un achat : Léa achète 2 webcams (date du jour).
4. Augmenter de 10% le prix du produit `SSD 1To`.
5. Supprimer tous les achats avant le `2025-03-01`.
6. Afficher les clients nés après 1971 (nom, prénom, anneeN).
7. Afficher les produits entre 3000 et 7000 triés par prix décroissant.
8. Afficher le nombre de clients habitant à `El Jadida`.
9. Afficher le produit le plus cher.
10. Afficher les produits jamais vendus.

---

# THÈME 3 — LCD (Droits)

## Résumé (à connaître)
Le **LCD** (Langage de Contrôle de Données) gère les **droits d’accès** :
- `CREATE USER`, `DROP USER`
- `GRANT` (donner des droits)
- `REVOKE` (retirer des droits)

Bonnes pratiques :
- Principe du **moindre privilège**

## Exercices LCD (10)
> À faire en compte admin (`root`).

1. Créer l’utilisateur `lecteur` (mdp : `lecteur_pwd`).
2. Créer l’utilisateur `gestion` (mdp : `gestion_pwd`).
3. Donner à `lecteur` le droit `SELECT` sur toute la base `cours_sql_tp`.
4. Retirer à `lecteur` le droit `SELECT` sur la table `Pay`.
5. Donner à `gestion` : `SELECT, INSERT, UPDATE, DELETE` sur `Client`, `Produit`, `Achat`.
6. Retirer à `gestion` le droit `DELETE` sur `Client` uniquement.
7. Créer `dba_tp` (mdp : `dba_pwd`) et donner `ALL PRIVILEGES` sur `cours_sql_tp`.
8. Tester : `lecteur` ne doit pas pouvoir lire `Pay`.
9. Révoquer tous les droits de `gestion` sur `Achat`.
10. Supprimer `lecteur`, `gestion`, `dba_tp`.
