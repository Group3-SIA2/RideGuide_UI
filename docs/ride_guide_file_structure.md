# RideGuide — File Structure Documentation

**App Name:** RideGuide  
**Tagline:** Your Journey, Our Guide  
**Version:** 1.0.0+1  
**Framework:** Flutter (Dart)  
**Date:** February 22, 2026

---

## lib directory

```
lib/
├── main.dart
├── resources/
│   ├── app_colors.dart
│   ├── app_routes.dart
│   ├── app_strings.dart
│   └── app_styles.dart
└── views/
    ├── splash_screen.dart
    └── walkthrough.dart
```

---

### main.dart
Entry point of the application. Initializes the `MaterialApp`, sets the app theme using `AppColors.primaryColor` as the seed color, applies the `Inter` font family, and registers named routes via `AppRoutes`.

---

### resources/

Holds all shared/global constants and utility classes used across the app.

| File | Description |
|------|-------------|
| `app_colors.dart` | Defines the app's color palette. Contains `primaryColor` (`#248AFF`) and `primaryColorLight` (`#BDDCFF`). |
| `app_routes.dart` | Centralizes all named navigation routes. Defines `splash` (`/`) and `walkthrough` (`/walkthrough`). |
| `app_strings.dart` | Stores all static text strings. Contains `appName` ("RideGuide") and `subName` ("Your Journey, Our Guide"). |
| `app_styles.dart` | Provides reusable `TextStyle` helpers. Contains `titleX()` for bold headings and `subText()` for regular body text, both accepting custom `size` and `color` parameters. |

---

### views/

Contains all UI screens of the application.

| File | Description |
|------|-------------|
| `splash_screen.dart` | The first screen shown on app launch. Displays the RideGuide SVG logo (`rideguide_design.svg`), the app name, and the tagline centered on a blue background. Automatically navigates to the Walkthrough screen after 4 seconds using `Future.delayed`. |
| `walkthrough.dart` | The onboarding/walkthrough screen. Currently a placeholder (`Container`). Intended to guide new users through the app's features. |

---

## assets directory

```
assets/
├── fonts/
│   ├── Inter-Regular.ttf
│   └── Inter-Bold.ttf
└── images/
    ├── rideguide_logo.png
    ├── rideguide_logo.svg
    └── rideguide_design.svg
```

| Asset | Description |
|-------|-------------|
| `Inter-Regular.ttf` | Primary font — regular weight. |
| `Inter-Bold.ttf` | Primary font — bold weight (700). |
| `rideguide_logo.png` | Original RideGuide logo in PNG format. |
| `rideguide_logo.svg` | RideGuide logo in SVG format. |
| `rideguide_design.svg` | RideGuide logo SVG with transparent background, used on the Splash Screen. |

---

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | SDK | Core Flutter framework |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |
| `flutter_svg` | ^2.0.10+1 | Renders SVG image assets |
| `flutter_lints` | ^6.0.0 | Recommended lint rules (dev) |

---

## Navigation Flow

```
App Launch
    └── SplashScreen (/)
            └── after 4 seconds
                    └── WalkthroughScreen (/walkthrough)
```

