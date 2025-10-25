# 🛒 MartFury Flutter E-commerce App

<div align="center">
  <img src="./art/1.png" alt="MartFury Flutter App" width="300"/>
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.7.2+-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.0.0+-0175C2?style=for-the-badge&logo=dart)](https://dart.dev)
  [![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
  [![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)](https://flutter.dev)
</div>

## 📱 About MartFury

MartFury is a comprehensive Flutter e-commerce mobile application designed to work seamlessly with Botble E-commerce backend systems. This professional-grade mobile app provides a complete shopping experience with modern UI/UX, multi-language support, and robust backend integration.

### 🎯 Key Features

#### 🛍️ **Shopping Experience**
- **Product Catalog**: Browse products by categories, brands, and collections
- **Advanced Search**: Smart search with filters and sorting options
- **Product Details**: Rich product pages with images, descriptions, and reviews
- **Shopping Cart**: Add/remove items, quantity management, and cart persistence
- **Wishlist**: Save favorite products for later purchase
- **Recently Viewed**: Track and display recently viewed products

#### 👤 **User Management**
- **Authentication**: Email/password, social login (Google, Facebook, Apple)
- **User Profiles**: Manage personal information and preferences
- **Address Management**: Multiple shipping and billing addresses
- **Order History**: Complete order tracking and management
- **Password Recovery**: Secure password reset functionality

#### 🌍 **Internationalization**
- **Multi-language**: Support for 8+ languages (English, Vietnamese, Arabic, Spanish, French, Hindi, Bengali, Indonesian)
- **RTL Support**: Full right-to-left language support
- **Multi-currency**: Dynamic currency switching
- **Localization**: Region-specific formatting and content

#### 🔧 **Technical Features**
- **State Management**: GetX for reactive state management
- **API Integration**: RESTful API with Botble E-commerce backend
- **Push Notifications**: Firebase Cloud Messaging (FCM) support
- **Offline Support**: Cached data and offline capabilities
- **Dark Mode**: System and manual theme switching
- **Responsive Design**: Optimized for various screen sizes

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK**: 3.7.2 or higher
- **Dart SDK**: 3.0.0 or higher
- **Android Studio** or **VS Code** with Flutter extensions
- **Botble E-commerce Backend** (API endpoint required)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/martfury-flutter.git
   cd martfury-flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment**
   ```bash
   # Copy the environment template
   cp .env.example .env
   
   # Edit .env with your configuration
   API_BASE_URL=https://your-botble-api.com
   APP_NAME=MartFury
   APP_ENV=development
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## 🏗️ Project Architecture

```
lib/
├── core/                    # Core app configuration
├── main.dart               # Application entry point
└── src/
    ├── controller/         # Business logic controllers (GetX)
    ├── model/             # Data models and entities
    ├── service/           # API services and data providers
    ├── theme/             # App theming and styling
    ├── utils/             # Utility functions and helpers
    └── view/              # UI components
        ├── screen/        # App screens and pages
        └── widget/         # Reusable UI widgets
```

### 🎨 **Architecture Patterns**
- **Clean Architecture**: Separation of concerns with clear layers
- **GetX State Management**: Reactive programming with minimal boilerplate
- **Service Layer**: Centralized API communication and data handling
- **Widget Composition**: Reusable and maintainable UI components

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
# API Configuration
API_BASE_URL=https://your-botble-ecommerce-api.com
APP_NAME=MartFury
APP_ENV=development

# Firebase Configuration (Optional)
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key

# Social Login (Optional)
GOOGLE_CLIENT_ID=your-google-client-id
FACEBOOK_APP_ID=your-facebook-app-id
APPLE_CLIENT_ID=your-apple-client-id
```

### Backend Integration

This app integrates with [Botble E-commerce API](https://ecommerce-api.botble.com/docs) and requires:

- **RESTful API**: Botble backend with API enabled
- **Authentication**: JWT token-based authentication
- **CORS**: Proper CORS configuration for mobile requests
- **SSL**: HTTPS endpoint for secure communication

## 🎨 Customization

### Theming
- **Colors**: Modify `lib/src/theme/app_colors.dart`
- **Fonts**: Update `lib/src/theme/app_fonts.dart`
- **Theme**: Customize `lib/src/theme/app_theme.dart`

### Branding
- **App Name**: Update in `pubspec.yaml` and environment variables
- **Logo**: Replace `assets/images/icon.png` and `assets/images/logo.png`
- **Splash Screen**: Customize in `lib/src/view/screen/splash_screen.dart`

### Localization
- **Languages**: Add new language files in `assets/translations/`
- **RTL Support**: Configure in `lib/src/service/language_service.dart`

## 🧪 Testing

### Run Tests
```bash
# Run all tests
flutter test

# Run specific test files
flutter test test/widget_test.dart
flutter test test/dark_mode_test.dart
```

### Test Coverage
```bash
# Generate test coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📦 Building for Production

### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS
```bash
# Build for iOS
flutter build ios --release

# Build IPA for App Store
flutter build ipa --release
```

## 🚀 Deployment

### Google Play Store
1. Build release APK/AAB
2. Create app listing in Google Play Console
3. Upload signed build
4. Configure store listing and pricing

### Apple App Store
1. Build release IPA
2. Upload to App Store Connect
3. Configure app information and metadata
4. Submit for review

## 📊 Performance

### Optimization Features
- **Image Caching**: Efficient image loading and caching
- **Lazy Loading**: On-demand data loading
- **Memory Management**: Optimized widget lifecycle
- **Network Optimization**: Request batching and caching

### Monitoring
- **Crash Reporting**: Firebase Crashlytics integration
- **Analytics**: Firebase Analytics for user behavior
- **Performance**: Flutter performance monitoring

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new features
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

### Documentation
- **Setup Guide**: [docs/installation.md](docs/installation.md)
- **Configuration**: [docs/configuration.md](docs/configuration.md)
- **API Integration**: [docs/api-integration.md](docs/api-integration.md)
- **Troubleshooting**: [docs/troubleshooting.md](docs/troubleshooting.md)

### Community
- **Issues**: [GitHub Issues](https://github.com/yourusername/martfury-flutter/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/martfury-flutter/discussions)
- **Wiki**: [Project Wiki](https://github.com/yourusername/martfury-flutter/wiki)

## 🔗 Related Projects

- **Backend System**: [MartFury Laravel E-commerce](https://codecanyon.net/item/martfury-multipurpose-laravel-ecommerce-system/29925223)
- **API Documentation**: [Botble E-commerce API](https://ecommerce-api.botble.com/docs)
- **Botble Platform**: [Botble CMS](https://botble.com)

## 📈 Roadmap

### Upcoming Features
- [ ] **Advanced Analytics**: Enhanced user behavior tracking
- [ ] **Push Notifications**: Real-time order updates
- [ ] **Offline Mode**: Complete offline shopping experience
- [ ] **AR Features**: Augmented reality product visualization
- [ ] **Voice Search**: Voice-activated product search

### Version History
- **v1.1.1**: Current stable release
- **v1.0.0**: Initial release with core features

---

<div align="center">
  <p>Built with ❤️ using Flutter</p>
  <p>© 2024 MartFury Flutter E-commerce App. All rights reserved.</p>
</div>