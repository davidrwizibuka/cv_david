# CV Flutter de David

<img width="818" height="505" alt="Capture d&#39;écran 2026-11-19 151215" src="https://github.com/user-attachments/assets/540e3e1b-fd7b-4388-8759-b84aed68ee9d" />
<img width="799" height="500" alt="Capture d&#39;écran 2026-11-19 151159" src="https://github.com/user-attachments/assets/4c0d769b-91a0-43ab-91ad-93dd3b811c23" />
<img width="886" height="500" alt="Capture d&#39;écran 2026-11-19 151136" src="https://github.com/user-attachments/assets/a5c3dcec-0a15-49bb-bc4c-a115d9442ec6" />
<img width="829" height="500" alt="Capture d&#39;écran 2026-11-19 145959" src="https://github.com/user-attachments/assets/e4f53e6e-c54a-48d2-80b1-33bcd031e1b4" />

Application Flutter du TP2 : connexion vérifiée par l'API REST et gestion dynamique des membres de famille enregistrés dans MySQL.

## Démarrer l'API locale

1. Placer le dépôt de l'API de l'enseignant dans `C:\xampp\htdocs\api-test`.
2. Démarrer Apache et MySQL avec XAMPP.
3. Créer la base `api` dans phpMyAdmin et importer `api.sql` (tables `account`, `famille_membre` et `tbl_etudiant`).
4. Configurer le fichier `.env` de l'API avec `DB_HOST=127.0.0.1`, `DB_PORT=3306`, `DB_DATABASE=api`, `DB_USERNAME=root` et le mot de passe MySQL local (vide sur la configuration décrite dans l'historique).
5. Vérifier `http://localhost:8080/api-test/public/famille-membres`.

La base URL par défaut de l'application est `http://localhost:8080/api-test/public`, car Apache utilise le port 8080 sur cette machine.

## Lancer l'application

```sh
flutter pub get
flutter run -d windows
```

Pour un émulateur Android, `localhost` désigne l'émulateur. Utiliser l'adresse spéciale `10.0.2.2` pour atteindre le serveur XAMPP du PC :

```sh
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080/api-test/public
```

Sur un téléphone physique, remplacer `10.0.2.2` par l'adresse IP locale du PC et autoriser Apache dans le pare-feu. Le téléphone et le PC doivent être sur le même réseau. Si Apache est configuré sur le port 80, retirer `:8080` de l'URL.

## Fonctionnalités du TP2

- Connexion avec email et mot de passe vérifiés par `POST /accounts/login`.
- Chargement des membres par `GET /famille-membres`.
- Ajout par `POST`, modification par `PUT` et suppression par `DELETE` sur `/famille-membres`.
- Actualisation après chaque opération pour afficher les données conservées par MySQL.

L'API fournie vérifie les identifiants au login, mais ses routes membres ne sont pas protégées par une session ou un jeton. Les opérations CRUD utilisent donc directement les routes REST décrites par l'API.



VOILA Le lien de video de mon tp monsieur https://youtu.be/LjtGLaHVJyI

