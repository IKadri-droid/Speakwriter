# SpeakWritter

SpeakWritter est un bloc-notes de dictée vocale qui tourne **entièrement en local** dans votre navigateur. Cliquez sur le micro, parlez : le texte s'écrit en temps réel, avec ponctuation vocale et plusieurs thèmes.

Aucun serveur, aucun compte, aucune donnée envoyée ailleurs que vers le moteur de reconnaissance vocale de votre navigateur (Chrome / Edge).

## Fonctionnalités

- **Dictée en temps réel** — le texte apparaît au fur et à mesure que vous parlez (résultats intermédiaires affichés en italique sous le bloc-notes).
- **Ponctuation vocale** — dites "virgule", "point", "à la ligne", "nouveau paragraphe", "point d'interrogation", "deux points", "ouvrez parenthèse"... et SpeakWritter insère le bon symbole, avec la bonne casse et le bon espacement.
- **Démarrage automatique** — l'écoute démarre toute seule à l'ouverture de l'application (activable/désactivable dans les réglages).
- **6 thèmes complets** — chaque thème change toute l'interface (pas seulement le fond) : Clair, Sombre, Bois, Sakura, Matte, Suisse.
- **Fenêtre native** — lancée via Chrome/Edge en mode `--app`, sans barre d'adresse ni onglets, comme une vraie application de bureau.
- **Sauvegarde automatique** — le texte est conservé entre les sessions (stockage local du navigateur).
- **Export** — copier dans le presse-papiers ou enregistrer en `.txt` en un clic.
- **Dictionnaire personnel** — apprenez à SpeakWritter vos propres corrections (ex: mélange français/anglais comme "commit", "push", "repository"). Stocké uniquement dans le navigateur local, jamais dans ce dépôt.

## Installation

Prérequis : Windows + Google Chrome (ou Microsoft Edge).

1. Cloner ou télécharger ce dépôt.
2. Double-cliquer sur `Lancer SpeakWritter.bat`.

Pour un raccourci sur le bureau avec l'icône de l'application :

```powershell
./scripts/create-shortcut.ps1
```

## Utilisation

| Action | Comment |
|---|---|
| Démarrer / arrêter l'écoute | Cliquer sur le bouton micro (ou appuyer sur **Espace**) |
| Changer de thème | Menu ⚙️ (réglages) → Thème |
| Activer/désactiver la ponctuation vocale | Menu ⚙️ → Ponctuation vocale |
| Copier le texte | Icône presse-papiers |
| Enregistrer en `.txt` | Icône disquette |
| Effacer | Icône corbeille |

### Commandes de ponctuation vocale

`virgule` · `point` · `point d'interrogation` · `point d'exclamation` · `deux points` · `point virgule` · `points de suspension` · `à la ligne` · `nouveau paragraphe` · `ouvrez/fermez parenthèse` · `guillemets ouvrants/fermants` · `tiret`

## Dictionnaire personnel

Dans le menu ⚙️ → Dictionnaire personnel, ajoutez des paires "mot entendu → mot corrigé". À chaque dictée, SpeakWritter remplace automatiquement ces mots avant de les écrire. Utile pour les mélanges français/anglais récurrents (ex: `pouche` → `push`, `reposte` → `repository`).

Ces corrections sont **100% locales** : stockées dans le `localStorage` de votre navigateur, elles ne quittent jamais votre machine et ne font partie d'aucun fichier de ce dépôt.

## Autorisation du micro

La première fois, Chrome/Edge demande l'autorisation d'accès au micro — c'est normal et ne se reproduit plus ensuite (le navigateur retient l'autorisation pour cette page).

## Structure du projet

```
speakwrite/
├── speakwrite.html          # L'application (HTML/CSS/JS, un seul fichier)
├── Lancer SpeakWritter.bat  # Lanceur Windows (ouvre l'app en mode natif)
├── logo.ico                 # Icône de l'application
├── scripts/
│   ├── generate-logo.ps1    # Régénère logo.ico
│   └── create-shortcut.ps1  # Crée le raccourci sur le bureau
└── README.md
```

## Technique

- Reconnaissance vocale : [Web Speech API](https://developer.mozilla.org/fr/docs/Web/API/Web_Speech_API) (moteur du navigateur, aucun serveur externe propre à l'app).
- Aucune dépendance, aucun build : un fichier HTML autonome.
- Icône générée via `System.Drawing` (.NET) en PowerShell.

## Licence

Projet personnel, libre d'utilisation.
