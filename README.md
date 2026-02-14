# RideGuide UI

A Flutter-based mobile application designed to help commuters navigate the public transportation system in General Santos City, Philippines. RideGuide provides route planning, fare estimation, and real-time navigation for cabs, tricycles, and buses.

## About

RideGuide is a comprehensive transportation companion app specifically designed for General Santos City commuters. Whether you're a local resident or a visitor, RideGuide helps you:

- Plan your routes - Find the best public transportation routes to your destination
- Estimate fares - Know how much your trip will cost before you travel
- Navigate in real-time - Get turn-by-turn directions and updates during your journey
- Multi-modal transport - Support for cabs, tricycles, and buses

## Features

### Planned Features

- Interactive Route Planning - Calculate optimal routes across multiple transportation modes
- Fare Calculator - Accurate fare estimates for different vehicle types
- Real-time GPS Navigation - Live location tracking and route guidance
- Multi-modal Transport Support
  - Taxi/Cab routes and fares
  - Tricycle routes and fares
  - Bus routes and schedules
- Location Search - Find popular destinations and landmarks
- Saved Locations - Quick access to frequently visited places
- Offline Mode - Basic functionality without internet connection

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (3.10.8 or higher)
- Dart SDK (3.10.8 or higher)
- Android Studio or Visual Studio Code with Flutter extensions
- Xcode (for iOS development, macOS only)
- Git

### Installation

1. Clone the repository

```bash
git clone https://github.com/Group3-SIA2/RideGuide_UI.git
cd RideGuide_UI
```

2. Install dependencies

```bash
flutter pub get
```

3. Verify installation

```bash
flutter doctor
```

### Running the App

Run on emulator or connected device:

```bash
flutter run
```

Run in debug mode:

```bash
flutter run --debug
```

Run in release mode:

```bash
flutter run --release
```

## Project Structure

```
RideGuide_UI/
├── android/              # Android-specific configuration 
├── lib/                  # Main application code
│   └── main.dart        # Application entry point
├── test/                # Unit and widget tests
├── web/                 # Web platform support
├── windows/             # Windows platform support
├── pubspec.yaml         # Project dependencies and metadata
└── README.md           # Project documentation
```

## Technologies Used

- Framework: Flutter 3.10.8+
- Language: Dart 3.10.8+
- Platform Support: Android, Web, Windows

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

## Development

### Running Tests

```bash
flutter test
```

Run tests with coverage:

```bash
flutter test --coverage
```

### Code Analysis

Analyze code:

```bash
flutter analyze
```

Format code:

```bash
flutter format .
```

### Building for Production

Build Android APK:

```bash
flutter build apk --release
```

Build Android App Bundle:

```bash
flutter build appbundle --release
```

Build for iOS:

```bash
flutter build ios --release
```

## Contributing

We welcome contributions from the community. To contribute:

1. Fork the repository
2. Create a feature branch (git checkout -b feature/AmazingFeature)
3. Commit your changes (git commit -m 'Add some AmazingFeature')
4. Push to the branch (git push origin feature/AmazingFeature)
5. Open a Pull Request

### Development Guidelines

- Follow Flutter style guide
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed
- Ensure code passes flutter analyze before submitting

## License

This project is currently private. All rights reserved by Group3-SIA2.

## Team

Group 3 - SIA2

## Contact

For questions or suggestions, please open an issue in the GitHub repository.

## Roadmap

- Implement route planning algorithm
- Integrate mapping service (Google Maps/OpenStreetMap)
- Build fare calculation engine
- Implement real-time GPS tracking
- Add offline map support
- Create user authentication system
- Develop admin panel for route management
- Add multi-language support (English, Filipino, Cebuano)
