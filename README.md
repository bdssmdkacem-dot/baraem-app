# براعم (Baraem) — scaffold Flutter

Jeu éducatif freemium pour enfants 2-6 ans autour des valeurs islamiques :
أذكار (dhikr), قصص الأنبياء (histoires des prophètes), آداب (bonnes manières).

## ⚠️ Ce qui est fourni vs. ce qu'il te reste à faire

Cet environnement n'a pas le SDK Flutter/Android installé, donc ce zip contient
uniquement le **code Dart** (`lib/`), `pubspec.yaml`, la config CI et les dossiers
`assets/` vides — pas les projets natifs `android/` et `ios/` (générés par
`flutter create`, des centaines de fichiers gradle/xcode).

### Étapes pour intégrer

```bash
# 1. Crée un nouveau projet Flutter (génère android/ + ios/)
flutter create --org com.comptaflow --project-name baraem baraem_app
cd baraem_app

# 2. Remplace pubspec.yaml et lib/ par ceux de ce zip
rm -rf lib pubspec.yaml
cp -r /chemin/vers/baraem/lib .
cp /chemin/vers/baraem/pubspec.yaml .
cp -r /chemin/vers/baraem/assets .
cp /chemin/vers/baraem/analysis_options.yaml .
cp -r /chemin/vers/baraem/.github .

# 3. Installe les dépendances
flutter pub get

# 4. Lance
flutter run
```

## Contenu à compléter avant publication

- **`lib/data/adkar_data.dart`** — seulement 4 exemples. À compléter avec ta
  collection complète (fais relire par quelqu'un de qualifié avant publication).
- **`lib/data/stories_data.dart`** — 2 histoires d'exemple avec 1-2 pages
  chacune. Pareil, contenu à étoffer + faire relire.
- **`assets/audio/adkar/*.mp3`** et **`assets/audio/stories/*.mp3`** —
  fichiers audio à enregistrer (tu as déjà le pipeline audio d'Aqim,
  potentiellement réutilisable).
- **`assets/images/`** — illustrations des histoires/scénarios (actuellement
  des icônes placeholder dans l'UI).
- **Police** — le thème référence `BalooBhaijaan2` (Google Fonts, bon rendu
  arabe/enfantin). Télécharge les `.ttf` et place-les dans `assets/fonts/`,
  ou remplace par `google_fonts: GoogleFonts.balooBhaijaan2TextTheme()` en
  dynamique si tu préfères ne pas les embarquer.
- **IAP** — ✅ branché (`lib/providers/purchase_provider.dart` +
  `lib/widgets/premium_sheet.dart`). Un seul produit non-consommable
  `baraem_premium_unlock` qui débloque tout le contenu premium. Reste à faire :
  1. Dans Play Console > Monétisation > Produits > Produits gérés, crée un
     produit avec l'ID exact `baraem_premium_unlock` (actif, avec un prix).
  2. Ajoute des comptes testeurs de licence (Play Console > Testeurs) pour
     tester des achats sans être facturé.
  3. **Important avant la prod** : le déblocage actuel se fait uniquement
     sur la base du statut renvoyé localement par le store (voir commentaire
     dans `purchase_provider.dart`). Pour éviter le contournement, ajoute une
     validation serveur du reçu d'achat (`purchase.verificationData`) — par
     exemple une Supabase Edge Function qui appelle l'API Google Play
     Developer, vu que tu as déjà Supabase sur Ra9m/KinFace.
  4. `PremiumSheet` (bottom sheet réutilisable) est déclenchée depuis les 3
     écrans (`stories_screen`, `adkar_screen`, `adab_screen`) quand l'enfant
     touche un contenu verrouillé.
- **AdMob** — `google_mobile_ads` ajouté en dépendance si tu veux un bandeau
  pub sur la version gratuite (optionnel en freemium, à toi de voir si tu
  veux ads + IAP ou juste IAP).

## Architecture

- `providers/progress_provider.dart` — étoiles, streak quotidien (7 jours
  glissants), contenu débloqué. Persisté via `shared_preferences`.
  Streak logic : +1 si jour consécutif, reset si un jour est sauté —
  pas de notif culpabilisante, juste un renforcement positif visuel.
- `providers/audio_provider.dart` — wrapper simple `audioplayers`.
- 3 modules indépendants (`adkar_screen`, `stories_screen` + `story_detail_screen`,
  `adab_screen`), chacun avec logique de contenu premium (`isPremium` sur les
  modèles) vérifiée contre `progress.isPremium`.

## CI/CD

`.github/workflows/build.yml` suit le même pattern que tes autres apps
(keystore décodé depuis un secret base64). Ajoute dans les secrets du repo :
`KEYSTORE_BASE64`, `KEYSTORE_PASSWORD`, `KEY_ALIAS`, `KEY_PASSWORD`.
