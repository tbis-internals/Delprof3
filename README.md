# Delprof3 : Outil de suppression de profils utilisateurs

Un script PowerShell destiné à aider les administrateurs à gérer les profils utilisateurs locaux sur les systèmes Windows. Il permet de lister les profils présents sur la machine, de supprimer un ou plusieurs profils spécifiques, et de nettoyer les clés de registre associées.

## Fonctionnalités

- 🔍 **Lister les profils** : Affiche tous les profils utilisateurs présents dans `C:\Users` avec leur date de dernière modification.
- 🗑️ **Supprimer des profils spécifiques** : Supprime les dossiers de profils sélectionnés ainsi que leurs entrées dans le registre.
- 🛡️ **Protection des profils essentiels** : Les profils `Default`, `Public` et celui de l'utilisateur actuellement connecté sont automatiquement exclus de la suppression.
- 📚 **Aide intégrée** : Affiche les options disponibles via le paramètre `-Help`.

## Utilisation

```powershell
.\Delprof3.ps1 -List
```
> Affiche la liste des profils utilisateurs.

```powershell
.\Delprof3.ps1 -Delete "utilisateur1","utilisateur2"
```
> Supprime les profils spécifiés (sauf ceux protégés).

```powershell
.\Delprof3.ps1 -Help
```
> Affiche l'aide et les options disponibles.
