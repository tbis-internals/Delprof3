# Delprof3 : Outil de suppression de profils utilisateurs

Un utilitaire PowerShell conçu pour aider les administrateurs et les utilisateurs à gérer les profils utilisateurs sur les systèmes Windows. Ce script liste tous les profils utilisateurs avec leur date de dernière utilisation, permet de sélectionner ceux à conserver, et facilite la suppression des autres profils ainsi que de leurs clés de registre associées.

## Fonctionnalités

- **Lister les profils utilisateurs :** Affiche rapidement tous les profils utilisateurs et leur date de dernier accès.
- **Sélection interactive :** Permet de sélectionner de manière interactive les profils à conserver, avec une sélection par défaut des profils système essentiels comme *Public*, *Default* et le profil actuellement connecté.
- **Nettoyage sécurisé :** Exclut automatiquement les profils *actuel*, *default* et *public* de la suppression pour éviter tout dommage système accidentel.
- **Nettoyage du registre :** Supprime les clés de registre associées aux profils supprimés pour garantir un système propre.

## Pour commencer

Pour utiliser **Delprof3**, suivez ces étapes :
1. **Téléchargez le dépôt**
2. **Naviguez dans le dossier :** Une fois dans le dossier, double-cliquez sur `runThis.bat`
3. **Sélectionnez les profils à conserver :** Suivez les instructions interactives pour choisir les profils supplémentaires à garder.
4. **Fin du processus :** Le script supprimera les profils non sélectionnés ainsi que leurs clés de registre, puis affichera la liste des profils restants.
