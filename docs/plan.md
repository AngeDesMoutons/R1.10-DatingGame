# Simulator Dating : le plan

Jeu de drague parodique en anglais, fait avec Tweego et SugarCube 2.30.0.
Une partie dure 5 minutes max. On choisit facile ou difficile, donc on joue au moins 2 fois.

## Déroulement

1. **Intro** : prénom du joueur, prénom de la fille, difficulté (+ option "No take-backs" qui enlève le retour en arrière).
2. **DMs sur Instagramme** : 3 messages à envoyer, puis on choisit le lieu du date.
   - Restaurant ou Parc : elle accepte (ou elle ghoste si l'Intérêt est sous 30).
   - Banque : game over direct.
3. **Trajet** : courir, bus, ou couper par la place (game over : le pavé).
4. **Le date** : Restaurant ou Parc, 3 ou 4 choix, puis le moment final (bisou, poignée de main ou rencontrer ta mère).

## Les 2 modes

- 🐶 **Easy, Golden Retriever Mode** : elle adore tout, écrit EN MAJUSCULES, fait du triple texting toute seule.
- 🧊 **Hard, Left On Read Mode** : froide, répond "k", "?", laisse en Vu. Il faut être aussi froid qu'elle.

## Les jauges

- **Interest** ($interet) : commence à 0. Au bisou : 100 = fin parfaite, 60 à 99 = friendzone, moins de 60 = elle esquive.
- **Cringe** ($genance) : commence à 0. À 100, le clic suivant envoie au poste de police (c'est dans scripts/main.js).

## Les fins (14)

| Fin | Comment |
|---|---|
| IT'S A MATCH | bisou avec 100 d'Interest |
| FRIENDZONED | bisou entre 60 et 99 |
| DODGED | bisou sous 60 |
| CONNECTED | poignée de main |
| ADOPTED | l'inviter à rencontrer ta mère |
| GHOSTED | pas assez d'Interest en DM, ou triple texting en difficile |
| ARRESTED | Cringe à 100 |
| DECLINED | date à la banque |
| CRUSHED | couper par la place |
| FLAMBÉ | resto : plonger sous la table pour la fourchette |
| DISHWASHER | resto : payer avec des tickets resto périmés |
| STUCK | resto : fuir par la fenêtre des toilettes |
| HOLE IN ONE | parc : s'allonger dans l'herbe (c'est un golf) |
| HONKED | parc : défier l'oie |

## Les fichiers

- `00_Special.twee` : les variables (StoryInit) et les jauges (StoryCaption)
- `chapitres/intro.twee` : début du jeu
- `chapitres/dm.twee` : les DMs (un passage par réponse)
- `chapitres/trajet.twee` : le trajet
- `chapitres/date_restaurant.twee` et `chapitres/date_parc.twee` : les dates et leurs fins
- `chapitres/fins.twee` : les autres fins
- `styles/main.css` et `scripts/main.js`

Attention : les retours à la ligne ne s'affichent pas, il faut mettre le texte dans des `<p>`.

## À faire plus tard

- [ ] Les easter eggs sur les prénoms (dont "Dem") et la blague de la banque
- [ ] Une image drôle pour la photo de profil
- [ ] Remplacer les `[Image of: ...]` par les vraies images, ajouter les sons
- [ ] Un compteur de fins débloquées (avec memorize)
