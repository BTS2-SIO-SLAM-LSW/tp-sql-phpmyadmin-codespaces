# TP SQL — MySQL + phpMyAdmin

Dans ce TP, vous allez :

-   Démarrer une base de données MySQL
-   Lancer phpMyAdmin
-   Accéder à phpMyAdmin via l'URL du Codespace
-   Vous connecter à la base de données

------------------------------------------------------------------------

# Ouvrir le terminal

Dans votre Codespace :

   Cliquer sur Menu **Terminal → New Terminal**

------------------------------------------------------------------------

# Vérifier que vous êtes dans le bon dossier

Tapez :

``` bash
pwd
```

Vous devez être dans :

    /workspaces/tp-sql-phpmyadmin-codespaces

Sinon :

``` bash
cd /workspaces/tp-sql-phpmyadmin-codespaces
```

------------------------------------------------------------------------

# Démarrer les conteneurs Docker

Tapez :

``` bash
docker compose up -d
```

⏳ Attendez que les images se téléchargent (première fois seulement).

------------------------------------------------------------------------

# Vérifier que les services fonctionnent

Tapez :

``` bash
docker compose ps
```

Vous devez voir :

-   mysql_db → Up\
-   phpmyadmin → Up

Si ce n'est pas le cas :

``` bash
docker compose logs
```

------------------------------------------------------------------------

# 5Accéder à phpMyAdmin

## Méthode recommandée

1.  Cliquez sur l'onglet **PORTS**
2.  Repérez le port **8080**
3.  Cliquez sur **Open in Browser**

------------------------------------------------------------------------

## Méthode via URL

Si votre URL Codespace est du type :

    https://urban-space-xylophone-jjwpwqg9g7753pvxr.github.dev

Ajoutez :

    -8080

Ce qui donne une URL du type :

    https://urban-space-xylophone-jjwpwqg9g7753pvxr-8080.github.dev

⚠️ Toujours ajouter le numéro de port.

------------------------------------------------------------------------

## Identifiants

- Serveur : db
- Utilisateur : root
- Mot de passe : root
- Base : cours_sql_tp

---

## Utilisation en local

```bash
docker compose up -d
```

Accès : http://localhost:8080




# TP SQL --- Étude de Cas : Gestion d'une Entreprise Informatique

## Contexte professionnel

Vous êtes développeur au sein d'une entreprise informatique nommée
**TechDistrib**. L'entreprise vend des produits (ordinateurs,
périphériques, logiciels) à des clients. Elle souhaite mettre en place
une base de données relationnelle pour gérer :

-   Les clients
-   Les produits
-   Les commandes
-   Les lignes de commande

Votre mission est de concevoir et manipuler cette base en respectant les
règles du modèle relationnel vues en cours.

------------------------------------------------------------------------

# THÈME 1 --- LDD (Langage de Définition de Données)

## Partie A --- Création de la structure (15 exercices)

1.  Créer une base de données nommée `techdistrib`.
2.  Utiliser cette base.
3.  Créer une table `Client` avec :\
    `id_client` (INT UNSIGNED, clé primaire, auto_increment)\
    `nom` (VARCHAR 50, NOT NULL)\
    `prenom` (VARCHAR 50, NOT NULL)\
    `ville` (VARCHAR 50)\
    `annee_naissance` (YEAR)
4.  Créer une table `Produit` avec :\
    `id_produit` (INT UNSIGNED, clé primaire, auto_increment)\
    `description` (VARCHAR 100)\
    `prix` (DECIMAL 10,2 NOT NULL)\
    `stock` (INT UNSIGNED DEFAULT 0)
5.  Créer une table `Commande` avec :\
    `id_commande` (INT UNSIGNED, clé primaire, auto_increment)\
    `date_commande` (DATE NOT NULL)\
    `id_client` (INT UNSIGNED)
6.  Ajouter une contrainte FOREIGN KEY entre `Commande.id_client` et
    `Client.id_client`.
7.  Ajouter `ON DELETE CASCADE` à cette clé étrangère.
8.  Créer une table `LigneCommande` avec :\
    `id_ligne` (INT UNSIGNED, clé primaire, auto_increment)\
    `id_commande` (INT UNSIGNED)\
    `id_produit` (INT UNSIGNED)\
    `quantite` (INT UNSIGNED NOT NULL CHECK (quantite \> 0))
9.  Ajouter les clés étrangères nécessaires.
10. Ajouter une contrainte UNIQUE sur (id_commande, id_produit).
11. Ajouter un index sur `Client.nom`.
12. Modifier la table `Produit` pour ajouter une colonne `categorie`
    ENUM("PC","Accessoire","Logiciel").
13. Modifier la colonne `description` pour la passer à VARCHAR(150).
14. Renommer la table `Commande` en `Commandes`.
15. Supprimer une table test appelée `Temporaire`.

------------------------------------------------------------------------

# THÈME 2 --- LMD (INSERT / UPDATE / DELETE)

## Partie B --- Manipulation des données (15 exercices)

1.  Insérer 5 clients.
2.  Insérer 5 produits.
3.  Insérer 3 commandes.
4.  Insérer des lignes de commande.
5.  Mettre à jour le stock après une commande.
6.  Modifier le prix d'un produit.
7.  Augmenter tous les prix de 5%.
8.  Supprimer un client (observer effet CASCADE).
9.  Supprimer une commande précise.
10. Supprimer les produits dont le stock est nul.
11. Mettre à jour la ville d'un client.
12. Ajouter une commande avec plusieurs lignes.
13. Tester une insertion invalide (clé étrangère inexistante).
14. Mettre à jour une quantité via calcul (quantite = quantite + 1).
15. Expliquer la différence entre DELETE et TRUNCATE.

------------------------------------------------------------------------

# THÈME 3 --- SELECT & Jointures

## Partie C --- Exploitation des données (15 exercices)

1.  Afficher tous les clients.
2.  Afficher uniquement nom et ville.
3.  Lister les produits dont le prix \> 1000.
4.  Trier les produits par prix décroissant.
5.  Limiter aux 3 produits les plus chers.
6.  Compter le nombre de clients par ville (GROUP BY).
7.  Afficher les villes ayant plus de 1 client (HAVING).
8.  Calculer le prix moyen des produits.
9.  Afficher le produit le plus cher.
10. Faire une jointure Client / Commandes.
11. Faire une jointure Client / Commandes / LigneCommande.
12. Afficher le total dépensé par client.
13. Utiliser LEFT JOIN pour afficher tous les clients même sans
    commande.
14. Afficher les produits jamais commandés.
15. Utiliser un alias dans une requête.

------------------------------------------------------------------------

# THÈME 4 --- Sous-requêtes

1.  Produits dont le prix est supérieur au prix moyen.
2.  Clients ayant passé au moins une commande (EXISTS).
3.  Produits jamais commandés (NOT IN).
4.  Commandes contenant un produit spécifique.
5.  Clients ayant dépensé plus que la moyenne des clients.
6.  Produit dont le stock est inférieur à la moyenne.
7.  Utiliser ALL.
8.  Utiliser ANY.
9.  Sous-requête dans FROM.
10. Sous-requête corrélée.
11. Utiliser MAX dans une sous-requête.
12. Utiliser MIN dans une sous-requête.
13. Sous-requête dans UPDATE.
14. Sous-requête dans DELETE.
15. Comparer JOIN vs sous-requête.

------------------------------------------------------------------------

# THÈME 5 --- Vues

1.  Créer une vue `ClientsActifs`.
2.  Créer une vue des produits chers (\>1000).
3.  Interroger une vue.
4.  Supprimer une vue.
5.  Créer une vue avec jointure.
6.  Créer une vue avec GROUP BY.
7.  Tester confidentialité via vue.
8.  Ajouter CHECK OPTION.
9.  Créer vue restreinte aux colonnes.
10. Créer vue restreinte aux lignes.
11. Tester mise à jour via vue.
12. Vue avec alias.
13. Observer reconstruction dynamique.
14. Comparer table réelle vs vue.
15. Expliquer intérêt des vues en sécurité.

------------------------------------------------------------------------

# THÈME 6 --- Index & Optimisation

1.  Créer un index sur Produit.prix.
2.  Créer un index composite.
3.  Supprimer un index.
4.  Tester recherche avec index.
5.  Tester recherche sans index.
6.  Créer index UNIQUE.
7.  Observer impact sur INSERT.
8.  Observer impact sur UPDATE.
9.  Observer impact sur DELETE.
10. Optimiser une table.
11. Expliquer PRIMARY KEY comme index.
12. Tester index NULL.
13. Tester performance avec ORDER BY.
14. Analyser requête avec EXPLAIN.
15. Expliquer coût mémoire des index.

------------------------------------------------------------------------a

# 🎓 Objectif final

À la fin du TP, vous devez être capable de :

-   Concevoir une base relationnelle cohérente
-   Appliquer les contraintes d'intégrité
-   Écrire des requêtes complexes avec jointures et sous-requêtes
-   Optimiser les performances
-   Utiliser les vues pour sécuriser l'accès aux données

