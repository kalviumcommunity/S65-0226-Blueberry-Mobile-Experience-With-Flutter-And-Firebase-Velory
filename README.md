# SafeRoute - Smart Mobile Experience

SafeRoute is an intelligent mobile application built with Flutter and Firebase that provides users with safer journey planning and navigation capabilities. This cross-platform app focuses on delivering a seamless user experience while ensuring safety-first route recommendations.

## 🎯 Project Overview

SafeRoute aims to revolutionize the way people navigate by combining real-time data, smart algorithms, and user-centric design to provide the safest and most efficient routes for daily commutes and travel.

## 📁 Project Structure

Our Flutter project follows a modular architecture to ensure scalability and maintainability:

```
lib/
├── main.dart          # Entry point of the application
├── screens/           # Individual UI screens (e.g., WelcomeScreen, HomeScreen)
│   └── welcome_screen.dart
├── widgets/           # Reusable UI components (e.g., CustomButton, SafetyCard)
├── models/            # Data structures and entity classes
├── services/          # Business logic, API calls, and Firebase integrations
```

### Directory Explanations:

- **`main.dart`**: The application's entry point that initializes the app and sets up the root widget tree.
  
- **`screens/`**: Contains full-page UI screens. Each screen represents a distinct view in the app (e.g., welcome, home, profile). This separation enables easy navigation management and code organization.

- **`widgets/`**: Houses reusable UI components that can be used across multiple screens. This promotes DRY (Don't Repeat Yourself) principles and ensures consistent design.

- **`models/`**: Defines data structures and business entities (e.g., User, Route, Location). These classes represent the core data types used throughout the app.

- **`services/`**: Contains business logic layer including Firebase operations, API integrations, authentication services, and data processing. This layer separates concerns and makes testing easier.

### Naming Conventions:

- **Files**: snake_case (e.g., `welcome_screen.dart`, `user_profile.dart`)
- **Classes**: PascalCase (e.g., `WelcomeScreen`, `UserProfile`)
- **Variables/Functions**: camelCase (e.g., `userName`, `calculateDistance()`)
- **Constants**: SCREAMING_SNAKE_CASE (e.g., `MAX_RETRY_COUNT`)
- **Private members**: Prefix with underscore (e.g., `_privateMethod()`, `_counterValue`)

## 🚀 Setup Instructions

### Prerequisites

1. **Install Flutter SDK**:
   - Download Flutter from [flutter.dev](https://flutter.dev)
   - Extract and add Flutter to your system PATH
   - Verify installation:
     ```bash
     flutter doctor
     ```

2. **Install an IDE**:
   - Android Studio with Flutter & Dart plugins
   - OR VS Code with Flutter & Dart extensions

3. **Setup Android Emulator or Physical Device**:
   - Android: Setup Android Emulator via Android Studio
   - iOS: Install Xcode (Mac only) and setup iOS Simulator

### Running the Project

1. **Clone the repository**:
   ```bash
   git clone https://github.com/kalviumcommunity/S65-0226-Blueberry-Mobile-Experience-With-Flutter-And-Firebase-Velory.git
   cd saferoute
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

4. **For specific device**:
   ```bash
   flutter devices  # List available devices
   flutter run -d <device-id>
   ```

## 📱 Demo

### Welcome Screen
The app features a custom welcome screen with:
- Interactive state management (toggle between welcome and navigation mode)
- Smooth color transitions
- Stateful widgets demonstrating Flutter's reactive UI
- Material Design principles

![App Screenshot - Coming Soon]

*Screenshot will be added after successful app run on emulator/device*

## 💡 What We Learned

### Flutter & Dart Fundamentals:
- **Widget Tree Architecture**: Understanding how Flutter builds UIs as a composition of widgets, making it highly modular and reusable.
- **State Management**: Implemented `StatefulWidget` to manage dynamic UI changes, learning how `setState()` triggers rebuild cycles.
- **Material Design**: Applied Flutter's rich widget catalog to create beautiful, responsive UIs following Material Design guidelines.
- **Dart Syntax**: Gained proficiency in Dart's object-oriented features, including classes, constructors, named parameters, and null safety.

### Project Organization:
The structured folder hierarchy will be crucial as the project scales:
- **Separation of Concerns**: Each directory has a specific responsibility, making code easier to locate and maintain.
- **Reusability**: The widgets/ folder will house components used across multiple screens, reducing code duplication.
- **Testability**: The modular structure makes unit testing and widget testing more straightforward.
- **Collaboration**: Clear organization helps team members understand the codebase quickly.

### Future Benefits:
This foundation prepares us for:
- Integrating Firebase for authentication and real-time data
- Building complex multi-screen navigation flows
- Creating custom reusable widgets for consistent UI/UX
- Implementing state management solutions (Provider, Bloc, Riverpod)
- Writing maintainable, scalable code that can grow with our feature set

## 🛠️ Technologies Used

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Material Design**: Design system for beautiful UIs

## 📝 Development Notes

- Using Material 3 design system for modern UI components
- Debug banner disabled for cleaner presentation
- Following Flutter best practices for widget composition
- Implementing responsive design patterns

## 🔗 Repository

GitHub: [S65-0226-Blueberry-Mobile-Experience](https://github.com/kalviumcommunity/S65-0226-Blueberry-Mobile-Experience-With-Flutter-And-Firebase-Velory)

---
