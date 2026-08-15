# SpeakWritter

SpeakWritter est un bloc-notes de dictée vocale qui tourne **entièrement en local** dans votre navigateur. Cliquez sur le micro, parlez : le texte s'écrit en temps réel, avec ponctuation vocale et plusieurs thèmes.

Aucun compte, aucune donnée envoyée ailleurs que vers le moteur de reconnaissance vocale intégré à votre navigateur. Un petit serveur local (voir [Technique](#technique)) sert juste le fichier de l'app depuis votre machine — rien ne sort de votre ordinateur.

## Compatibilité navigateur

SpeakWritter fonctionne sur **tout navigateur basé sur Chromium** : Google Chrome, Microsoft Edge, Brave, Vivaldi, Opera... Le lanceur essaie ces navigateurs automatiquement dans cet ordre.

**Firefox et Safari ne sont pas supportés** — ce n'est pas une limitation de l'application : ces navigateurs n'implémentent pas la partie reconnaissance continue (`SpeechRecognition`) de la Web Speech API. Aucune modification côté application ne peut contourner ça tant que ces navigateurs n'ajoutent pas cette fonctionnalité.

## Fonctionnalités

- **Dictée en temps réel** — le texte apparaît au fur et à mesure que vous parlez (résultats intermédiaires affichés en italique sous le bloc-notes).
- **Ponctuation vocale** — dites "virgule", "point", "à la ligne", "nouveau paragraphe", "point d'interrogation", "deux points", "ouvrez parenthèse"... et SpeakWritter insère le bon symbole, avec la bonne casse et le bon espacement.
- **Démarrage automatique** — l'écoute démarre toute seule à l'ouverture de l'application (activable/désactivable dans les réglages).
- **6 thèmes complets** — chaque thème change toute l'interface (pas seulement le fond) : Clair, Sombre, Bois, Sakura, Matte, Suisse.
- **Fenêtre native** — lancée en mode `--app` (Chrome, Edge, Brave, Vivaldi ou Opera), sans barre d'adresse ni onglets, comme une vraie application de bureau.
- **Sauvegarde automatique** — le texte est conservé entre les sessions (stockage local du navigateur).
- **Export** — copier dans le presse-papiers ou enregistrer en `.txt` en un clic.
- **Dictionnaire technique intégré** — corrige automatiquement la casse des termes techniques courants dictés en franglais (ex: "github" → "GitHub", "javascript" → "JavaScript"). Désactivable dans les réglages.
- **Dictionnaire personnel** — apprenez à SpeakWritter vos propres corrections en plus (ex: "pouche" → "push"). Stocké uniquement dans le navigateur local, jamais dans ce dépôt.

## Installation

Prérequis : Windows, Python (déjà installé sur la plupart des machines ; sert uniquement à faire tourner le petit serveur local), et un navigateur basé sur Chromium (Chrome, Edge, Brave, Vivaldi, Opera).

1. Cloner ou télécharger ce dépôt.
2. Double-cliquer sur `Lancer SpeakWritter.bat`.

Le lanceur démarre un petit serveur local (`http://127.0.0.1:8743`) puis ouvre l'app dans une fenêtre native. Voir [Autorisation du micro](#autorisation-du-micro) pour pourquoi ce serveur existe.

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

## Dictionnaire technique intégré

Une liste de termes techniques courants (Git, GitHub, JavaScript, Docker, API, HTML...) livrée avec l'app et appliquée automatiquement pour corriger leur casse quand la reconnaissance vocale les retranscrit tout en minuscules. Désactivable via ⚙️ → "Corrections techniques auto". Cette liste fait partie du code de l'app et est partagée dans ce dépôt (contrairement au dictionnaire personnel ci-dessous).

## Dictionnaire personnel

Dans le menu ⚙️ → Dictionnaire personnel, ajoutez des paires "mot entendu → mot corrigé". À chaque dictée, SpeakWritter remplace automatiquement ces mots avant de les écrire (après le dictionnaire technique intégré, donc vos corrections personnelles ont toujours le dernier mot). Utile pour vos propres mélanges français/anglais récurrents (ex: `pouche` → `push`, `reposte` → `repository`).

Ces corrections sont **100% locales** : stockées dans le `localStorage` de votre navigateur, elles ne quittent jamais votre machine et ne font partie d'aucun fichier de ce dépôt.

## Autorisation du micro

La première fois, votre navigateur demande l'autorisation d'accès au micro — c'est normal. Elle ne redemande plus ensuite : l'app tourne sur `http://127.0.0.1:8743` (un vrai serveur local, pas un fichier ouvert directement), et les navigateurs basés sur Chromium retiennent fiablement les autorisations données sur ce type d'origine — contrairement aux pages ouvertes en `file://`, où l'autorisation pouvait ne pas être mémorisée d'une session à l'autre.

## Structure du projet

```
speakwrite/
├── speakwrite.html          # L'application (HTML/CSS/JS, un seul fichier)
├── Lancer SpeakWritter.bat  # Lanceur Windows (démarre le serveur local + ouvre l'app en mode natif)
├── logo.ico                 # Icône de l'application
├── scripts/
│   ├── serve.py              # Petit serveur HTTP local (127.0.0.1)
│   ├── generate-logo.ps1     # Régénère logo.ico
│   └── create-shortcut.ps1   # Crée le raccourci sur le bureau
└── README.md
```

## Technique

- Reconnaissance vocale : [Web Speech API](https://developer.mozilla.org/fr/docs/Web/API/Web_Speech_API) (moteur du navigateur).
- Serveur local minimal en Python (`http.server` de la bibliothèque standard, zéro dépendance) pour servir l'app sur `http://127.0.0.1:8743` plutôt qu'en `file://`.
- Aucun build, aucune dépendance JS : un fichier HTML autonome.
- Icône générée via `System.Drawing` (.NET) en PowerShell.

## Licence

Ce projet est sous licence [MIT](LICENSE).
