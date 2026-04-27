
# 🚀 Flutter Clean Architecture Template

A scalable and production-ready **Flutter** starter template built with **Clean Architecture** principles. This template provides a solid foundation for building maintainable, testable, and high-quality mobile applications.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=Dart&logoColor=white)
## ✨ Features

- **Clean Architecture** with clear separation of concerns (Presentation, Domain, Data layers)
- **Feature-first** modular structure for better scalability
- State Management ready (Provider / Riverpod)
- API integration using **Dio**
- Local storage support (**Hive**)
- Comprehensive core services (API, Local Storage, Notifications, Analytics)
- Reusable widgets and common utilities
- Proper error handling and network abstraction
- Dependency Injection setup
- Consistent and professional folder structure

---

## 🏗️ Project Structure

```bash
lib/
├── app/
│   ├── config/
│   ├── routes/
│   ├── themes/
│   └── widgets/
├── core/
│   ├── constant/
│   ├── di/                     # Dependency Injection
│   ├── network/
│   └── services/
│       ├── analytics_service/
│       ├── api_services/
│       ├── local_storage_service/
│       └── notification_service/
├── features/
│   └── home/
│       ├── data/
│       │   ├── model/
│       │   └── repositories/
│       ├── domain/
│       │   └── repositories/
│       └── presentation/
│           ├── view/
│           └── viewmodel/
└── utils/
```

### Layer Breakdown

- **app/** → Global app configurations, routing, themes, and shared widgets
- **core/** → Reusable core logic and services used throughout the application
- **features/** → All business features (each feature is self-contained with its own data, domain, and presentation layers)
- **utils/** → Helper functions and general utilities

---

## ⚙️ Tech Stack

- **Flutter** & **Dart**
- **Clean Architecture**
- **Provider / Riverpod** (State Management)
- **Dio** (HTTP Client)
- **Hive** (Local Database)
- **GetIt** / Manual DI (via `core/di`)

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Asif-Rezan/flutter_project_template.git
cd flutter_project_template
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

---

## 📋 How to Add a New Feature

1. Create a new folder under `lib/features/` (e.g., `auth`, `product`, `profile`)
2. Follow the same three-layer structure:
   ```
   feature_name/
   ├── data/          # Models, data sources, repositories implementation
   ├── domain/        # Entities, abstract repositories, use cases
   └── presentation/  # Views, ViewModels, widgets
   ```

---

## 🎯 Why Use This Template?

- Saves significant setup time for new Flutter projects
- Enforces clean code and best practices from day one
- Highly scalable for both small and large applications
- Easy to maintain and onboard new developers
- Strong focus on testability and separation of concerns

---

## 📌 Best Practices Included

- Feature-first architecture
- Strict layer separation
- Single Responsibility Principle
- Consistent naming conventions
- Reusable and testable components

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is open source and available under the **MIT License**.

---

**Built with ❤️ for the Flutter community**

---

You can now replace the entire content of your current `README.md` with the above.

### Suggested Next Steps:

Would you like me to also provide:
- A better project description for the GitHub repo settings?
- Badges or a nice cover image suggestion?
- A sample `pubspec.yaml` improvements?
- Or a professional commit message for updating the README?

Just say the word!