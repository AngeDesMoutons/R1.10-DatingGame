# Guide de l'équipe Simulator Dating

Bienvenue ! Ce guide explique comment on travaille à quatre sur le jeu sans se marcher dessus. Lis-le en entier une première fois, puis garde-le sous la main.

---

## 1. Comment ça marche, en résumé

```
Tu écris des fichiers .twee  →  tu testes sur ton PC avec Tweego
        ↓
Tu envoies ton travail sur GitHub (dans ta branche)
        ↓
Tu ouvres une Pull Request  →  quelqu'un relit  →  on fusionne dans main
        ↓
GitHub compile le jeu tout seul et le met en ligne (1 à 2 minutes)
```

- **On n'utilise pas l'éditeur visuel de Twine.** On écrit le jeu en texte (format Twee 3) dans VS Code.
- **Le format d'histoire est SugarCube 2.30.0.** Toute la syntaxe du jeu vient de lui.
- **La branche `main` est protégée.** On ne peut pas pousser directement dessus : tout passe par une Pull Request.
- **Le jeu en ligne est toujours la version de `main`.** Lien : *(à compléter : https://pseudo.github.io/depot/)*

---

## 2. Installation (une seule fois)

1. **Créer un compte GitHub** sur https://github.com et donner son pseudo à Angelo pour être invité au dépôt. Accepter ensuite l'invitation reçue par mail.
2. **Installer VS Code :** https://code.visualstudio.com
   - Extension à installer : « Twine (Twee 3) Language » (onglet Extensions, chercher « twee »).
3. **Installer Git :** https://git-scm.com/downloads (garder les options par défaut).
4. **Installer GitHub Desktop :** https://desktop.github.com. C'est l'interface graphique qu'on utilise pour Git, pas besoin du terminal pour ça.
5. **Installer Tweego :** https://www.motoslave.net/tweego/
   - Télécharger la version Windows, dézipper par exemple dans `C:\tweego`.
   - Ajouter ce dossier au PATH Windows (chercher « variables d'environnement » dans le menu Démarrer, puis *Path → Modifier → Nouveau → C:\tweego*).
   - Vérifier dans un terminal : `tweego --version`.

---

## 3. Récupérer le projet

1. Dans GitHub Desktop : *File → Clone repository*, choisir le dépôt du jeu, puis *Clone*.
2. Ouvrir le dossier dans VS Code (*Repository → Open in Visual Studio Code*).
3. Dans le terminal de VS Code (*Terminal → New Terminal*), créer le dossier de sortie une fois :
   ```
   mkdir dist
   ```

### Tester le jeu sur son PC

À chaque session de travail, lancer dans le terminal de VS Code :

```
$env:TWEEGO_PATH = "$PWD\storyformats"; tweego -o dist/index.html src --watch
```

Ouvrir ensuite `dist/index.html` dans le navigateur. À chaque sauvegarde, le jeu est recompilé : il suffit de rafraîchir la page. `CTRL+C` arrête la commande.

---

## 4. Organisation des fichiers

```
src/
├── 00_StoryData.twee      ← titre, IFID, format : NE PAS MODIFIER
├── 00_Special.twee        ← StoryInit (variables de départ), menus…
├── 00_Widgets.twee        ← widgets (macros maison) communs
├── styles/
│   └── main.css           ← le style de tout le jeu
├── scripts/
│   └── main.js            ← le JavaScript de tout le jeu
└── chapitres/
    ├── ch1_intro.twee
    └── …
storyformats/              ← SugarCube : ne pas toucher
.github/workflows/         ← publication automatique : ne pas toucher
```

Tweego assemble automatiquement **tous** les fichiers `.twee`, `.css` et `.js` du dossier `src`, sous-dossiers compris. On peut donc découper le jeu en autant de fichiers qu'on veut.

**Règle principale : chacun écrit dans ses propres fichiers.** Si deux personnes ne modifient jamais le même fichier, il n'y a jamais de conflit.

Les fichiers **communs** (`00_*.twee`, `main.css`, `main.js`) appartiennent à toute l'équipe. On prévient les autres (sur le groupe ou dans une Issue) avant de les modifier.

---

## 5. Conventions

### Noms des passages

Format : `Route_Chapitre_Description`, sans accents ni espaces.

- `Camille_Ch1_Cafe`
- `Sam_Ch2_Dispute`
- `Commun_Ch1_Arrivee` (passages partagés entre routes)

Un nom de passage doit être **unique dans tout le jeu**. Les passages qui servent de point de jonction entre deux personnes sont notés dans `docs/plan.md`.

### Noms des fichiers

`route_chapitre.twee`, par exemple `camille_ch1.twee`.

### Noms des branches

`prenom/ce-que-je-fais`, par exemple `lea/camille-ch1` ou `tom/menu-sauvegarde`.

### Messages de commit

Une phrase courte qui dit ce qui a changé : « Ajoute la scène du café de Camille », « Corrige le lien cassé vers Sam_Ch2 ».

---

## 6. Le circuit de travail (à suivre à chaque tâche)

1. **Prendre une tâche.** Dans l'onglet *Issues* du dépôt, s'assigner une issue (ou en créer une).
2. **Se mettre à jour.** Dans GitHub Desktop, sélectionner la branche `main`, puis *Fetch origin* et *Pull origin*.
3. **Créer sa branche.** *Current branch → New branch*, avec un nom comme `lea/camille-ch1`.
4. **Écrire.** Tester avec Tweego en même temps (section 3).
5. **Enregistrer son travail (commit).** Dans GitHub Desktop, cocher les fichiers, écrire un message et cliquer *Commit*. On peut faire plusieurs commits par tâche, c'est même conseillé.
6. **Envoyer (push).** *Publish branch* la première fois, *Push origin* ensuite.
7. **Ouvrir une Pull Request.** GitHub Desktop propose *Create Pull Request*. Décrire ce qu'on a fait et lier l'issue (écrire `Closes #12` dans la description).
8. **Relecture.** Un autre membre lit, teste et commente si besoin. On corrige dans la même branche (commit + push, la PR se met à jour toute seule).
9. **Fusion.** Une fois validée, on clique *Merge pull request*, puis *Delete branch*. Le jeu en ligne se met à jour.
10. **Revenir sur `main`.** Dans GitHub Desktop, revenir sur `main` et faire *Pull origin*. Prêt pour la tâche suivante.

**Une branche = une tâche, pas une branche par personne pour toujours.** Les petites branches qui vivent quelques jours se fusionnent facilement. Les grosses branches qui vivent des semaines finissent en conflits.

---

## 7. Écrire le jeu : les bases de SugarCube

### Un passage et des liens

```
:: Camille_Ch1_Cafe
Camille lève les yeux de son livre.

[[Lui dire bonjour|Camille_Ch1_Bonjour]]
[[Faire semblant de ne pas la voir|Camille_Ch1_Ignorer]]
```

### Variables (affinité, choix, nom du joueur…)

Les variables de départ se déclarent **une seule fois** dans `StoryInit` (fichier `00_Special.twee`) :

```
:: StoryInit
<<set $nomJoueur to "Alex">>
<<set $affinite to { camille: 0, sam: 0 }>>
```

Modifier une variable en cliquant sur un lien :

```
[[Lui offrir un café|Camille_Ch1_Bonjour][$affinite.camille += 1]]
```

Afficher une variable : `Bonjour $nomJoueur !`

### Conditions

```
<<if $affinite.camille gte 3>>
  Camille te sourit franchement.
<<else>>
  Camille te salue poliment.
<</if>>
```

### Réutiliser du contenu

- `<<include "Commun_Barre_Statut">>` insère le contenu d'un autre passage.
- `<<goto "Passage">>` envoie le joueur ailleurs sans qu'il clique.

### Widgets (macros maison)

Dans `00_Widgets.twee`, avec le tag `[widget]` :

```
:: Widgets [widget]
<<widget "parle">>
<div class="dialogue"><span class="perso">_args[0]</span> : _args[1]</div>
<</widget>>
```

Utilisation dans n'importe quel passage : `<<parle "Camille" "Tu viens souvent ici ?">>`

### Passages spéciaux utiles

`StoryInit` (au démarrage), `StoryCaption` (texte dans la barre latérale), `PassageHeader` / `PassageFooter` (affichés en haut ou en bas de chaque passage), `StoryMenu` (liens de la barre latérale). La liste complète est dans la documentation SugarCube (section *Special Passages*).

### Le CSS : le style de tout le jeu

Tout ce qui est dans `src/styles/*.css` s'applique à **toutes** les pages :

```css
body { background: #1d1a24; font-family: Georgia, serif; }
.dialogue { margin: 1em 0; }
.perso { font-weight: bold; color: #e88aa8; }
```

Style pour certaines scènes seulement : ajouter un tag au passage (`:: Camille_Ch1_Cafe [cafe]`) puis cibler ce tag en CSS :

```css
body[data-tags~="cafe"] { background: #3b2a1e; }
```

### Le JavaScript

Tout ce qui est dans `src/scripts/*.js` s'exécute au lancement du jeu. Pour partager des données, on les range dans l'objet `setup` :

```js
setup.persos = {
  camille: { nom: "Camille", couleur: "#e88aa8" },
  sam: { nom: "Sam", couleur: "#7fb3e8" }
};
```

Utilisable ensuite dans un passage : `<<print setup.persos.camille.nom>>`.

---

## 8. Règles d'or

1. Toujours faire *Pull origin* sur `main` avant de créer une branche.
2. Ne jamais modifier les fichiers des autres sans les prévenir.
3. Tester le jeu sur son PC avant d'ouvrir une Pull Request.
4. Des petits commits fréquents valent mieux qu'un énorme commit.
5. Un lien vers un passage qui n'existe pas encore ? Créer un passage vide avec ce nom et `TODO` dedans, pour que le jeu compile.
6. En cas de doute, demander avant de tout casser. Rien n'est grave avec Git : tout l'historique est conservé.

---

## 9. En cas de problème

| Message / symptôme | Solution |
|---|---|
| `Starting passage "Start" not found` | Le passage `:: Start` n'existe pas ou est mal écrit (majuscule, espace en trop). |
| `open dist/index.html: chemin introuvable` | Le dossier `dist` n'existe pas : `mkdir dist`. |
| `Story format … is not available` | La commande `$env:TWEEGO_PATH=…` n'a pas été lancée dans ce terminal (section 3). |
| Mon fichier est ignoré | Il s'appelle sûrement `xxx.twee.txt`. Créer les fichiers depuis VS Code. |
| Croix rouge dans l'onglet *Actions* | Cliquer dessus, lire l'erreur et prévenir l'équipe. Le jeu en ligne reste sur la dernière version qui marchait. |
| Conflit dans GitHub Desktop | Ne pas paniquer. Ouvrir le fichier dans VS Code et choisir *Accept Current / Incoming / Both*. Demander de l'aide si besoin. |

---

## 10. Ressources pour apprendre

### Git et GitHub

- **Oh My Git!** : un jeu pour apprendre Git en s'amusant (idéal pour commencer). https://ohmygit.org
- **Learn Git Branching** : exercices interactifs sur les branches, en français. https://learngitbranching.js.org/?locale=fr_FR
- **Documentation de GitHub Desktop**, en français. https://docs.github.com/fr/desktop
- **Les Pull Requests**, documentation GitHub. https://docs.github.com/fr/pull-requests
- **GitHub Skills** : petits cours pratiques directement sur GitHub. https://skills.github.com
- **Pro Git** : le livre de référence, gratuit et en français, pour aller plus loin. https://git-scm.com/book/fr/v2
- **Aide-mémoire Git** (PDF). https://education.github.com/git-cheat-sheet-education.pdf

### Twine, Twee et Tweego

- **Documentation de Tweego** (options, fichiers acceptés…). https://www.motoslave.net/tweego/docs/
- **Spécification Twee 3** (la syntaxe des fichiers `.twee`). https://github.com/iftechfoundation/twine-specs/blob/master/twee-3-specification.md
- **Twine Cookbook** : recettes concrètes (inventaire, timer, sauvegarde…) pour chaque format. https://twinery.org/cookbook/
- **Référence officielle de Twine.** https://twinery.org/reference/en/

### SugarCube (le plus important)

- **Documentation officielle de SugarCube 2.** C'est LA référence : macros, passages spéciaux, API JavaScript, CSS. https://www.motoslave.net/sugarcube/2/docs/
  - Attention : on utilise la 2.30.0. La doc indique pour chaque fonctionnalité la version où elle est apparue (« Since v2.xx »).
- **Macros personnalisées de ChapelR** (dialogues, sons, notifications… prêtes à copier). https://github.com/ChapelR/custom-macros-for-sugarcube-2

### HTML, CSS et JavaScript

- **MDN, CSS** (la référence du web, en français). https://developer.mozilla.org/fr/docs/Web/CSS
- **MDN, JavaScript.** https://developer.mozilla.org/fr/docs/Web/JavaScript
- **MDN, apprendre le développement web** (parcours débutant). https://developer.mozilla.org/fr/docs/Learn
- **Flexbox Froggy** : apprendre la mise en page Flexbox en jouant. https://flexboxfroggy.com/#fr
- **Grid Garden** : pareil pour CSS Grid. https://cssgridgarden.com/#fr
- **JavaScript.info**, un cours complet en français. https://fr.javascript.info

### Demander de l'aide

- **r/twinegames**, la communauté Reddit de Twine. https://www.reddit.com/r/twinegames/
- **Forum intfiction.org** (section Twine, très actif). https://intfiction.org
- **Le Discord officiel de Twine** (lien sur https://twinery.org).

### Écrire en Markdown (pour ce guide, le README, les Issues)

- https://www.markdownguide.org

---

## 11. Parcours conseillé pour démarrer

1. **Semaine 1, Git et le circuit de travail.** Jouer à Oh My Git! ou Learn Git Branching (1 à 2 h), installer les outils, puis faire une première Pull Request d'essai qui ajoute un passage de test.
2. **Semaine 2, Twee et SugarCube.** Lire dans la doc SugarCube les sections *Markup*, *Macros* (`set`, `if`, `link`, `include`) et *Special Passages*. Écrire une petite scène avec deux choix et une variable.
3. **Semaine 3, le style.** Faire Flexbox Froggy, modifier un peu `main.css` sur une branche d'essai, puis regarder le Twine Cookbook pour piocher des idées.
4. **Ensuite** : JavaScript et macros avancées pour ceux que ça intéresse. Tout le monde n'a pas besoin de coder, l'écriture compte autant !