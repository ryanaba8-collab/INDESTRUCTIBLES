# INDESTRUCTIBLES - Backend Gestion Emploi du Temps

Ce projet est le backend de notre application de gestion d’emploi du temps pour une entreprise scolaire.

## Technologies utilisées

- Node.js
- Express.js
- Prisma
- PostgreSQL
- pgAdmin 4

---

## 1. Récupérer le projet

Chaque collaborateur doit cloner le projet :

```bash
git clone https://github.com/ryanaba8-collab/INDESTRUCTIBLES.git

Puis entrer dans le dossier :
cd INDESTRUCTIBLES

2. Installer les dépendances
npm install

3. Créer la base de données

Dans pgAdmin 4 :

Ouvrir pgAdmin
Aller dans Databases
Clic droit → Create > Database
Nom de la base :gestion_emploie_temps2
Cliquer sur Save

4. Importer la base de données

Dans le projet, il y a un fichier SQL :database/init.sql
Pour l’importer :

Dans pgAdmin, sélectionner la base gestion_emploie_temps2
Clic droit → Query Tool
Ouvrir le fichier database/init.sql
Exécuter le script avec le bouton ▶
Cela va créer les tables et insérer les données de base.

5. Configurer le fichier .env
Créer un fichier .env à la racine du projet.
Copier le contenu de .env.example :DATABASE_URL="postgresql://postgres:motdepasse@localhost:5432/gestion_emploie_temps2"
PORT=5000
Puis remplacer motdepasse par votre vrai mot de passe PostgreSQL.

6. Générer Prisma
Après avoir configuré la base et le .env, lancer :npx prisma db pull
puis npx prisma generate
7. Lancer le serveur
npm run dev
