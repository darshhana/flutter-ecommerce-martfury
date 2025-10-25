# Contributing to MartFury Flutter E-commerce App

Thank you for your interest in contributing to MartFury! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues

Before creating an issue, please:
1. Check if the issue already exists
2. Use the issue templates provided
3. Include relevant information (OS, Flutter version, error logs)
4. Provide steps to reproduce the issue

### Suggesting Features

We welcome feature suggestions! Please:
1. Check if the feature has been requested before
2. Provide a clear description of the feature
3. Explain the use case and benefits
4. Consider implementation complexity

### Code Contributions

#### Getting Started

1. **Fork the repository**
   ```bash
   git clone https://github.com/yourusername/martfury-flutter.git
   cd martfury-flutter
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Set up development environment**
   ```bash
   flutter pub get
   flutter doctor
   ```

#### Development Guidelines

##### Code Style
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

##### Architecture
- Follow the existing project structure
- Use GetX for state management
- Implement proper error handling
- Add appropriate logging

##### Testing
- Write unit tests for new features
- Test on both Android and iOS
- Ensure existing tests still pass
- Add integration tests for critical flows

#### Pull Request Process

1. **Update your branch**
   ```bash
   git fetch origin
   git rebase origin/main
   ```

2. **Run tests and checks**
   ```bash
   flutter test
   flutter analyze
   flutter format .
   ```

3. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add new feature description"
   ```

4. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create a Pull Request**
   - Use the PR template
   - Provide a clear description
   - Link related issues
   - Add screenshots for UI changes

## 📋 Pull Request Guidelines

### Before Submitting

- [ ] Code follows project style guidelines
- [ ] All tests pass
- [ ] Code is properly documented
- [ ] No breaking changes (or clearly documented)
- [ ] Updated relevant documentation

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed

## Screenshots (if applicable)
Add screenshots for UI changes

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No new warnings
```

## 🏗️ Development Setup

### Prerequisites

- Flutter SDK 3.7.2+
- Dart SDK 3.0.0+
- Android Studio / VS Code
- Git

### Environment Setup

1. **Clone and setup**
   ```bash
   git clone https://github.com/yourusername/martfury-flutter.git
   cd martfury-flutter
   flutter pub get
   ```

2. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Project Structure

```
lib/
├── core/                 # Core app configuration
├── src/
│   ├── controller/       # Business logic (GetX)
│   ├── model/           # Data models
│   ├── service/         # API services
│   ├── theme/           # App theming
│   ├── utils/           # Utility functions
│   └── view/            # UI components
│       ├── screen/      # App screens
│       └── widget/     # Reusable widgets
test/                    # Test files
docs/                   # Documentation
```

## 🧪 Testing Guidelines

### Unit Tests
- Test business logic in controllers
- Test utility functions
- Mock external dependencies
- Aim for high test coverage

### Widget Tests
- Test UI components
- Test user interactions
- Test different states
- Use golden file tests for UI consistency

### Integration Tests
- Test complete user flows
- Test API integrations
- Test navigation flows
- Test error scenarios

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

## 📝 Documentation

### Code Documentation
- Document public APIs
- Add inline comments for complex logic
- Use meaningful variable names
- Follow Dart documentation conventions

### README Updates
- Update setup instructions
- Add new features to feature list
- Update screenshots
- Keep installation guide current

## 🐛 Bug Reports

When reporting bugs, please include:

1. **Environment Information**
   - OS and version
   - Flutter version (`flutter --version`)
   - Device/emulator details

2. **Steps to Reproduce**
   - Clear, numbered steps
   - Expected vs actual behavior
   - Screenshots or videos if helpful

3. **Error Information**
   - Full error messages
   - Stack traces
   - Log files if relevant

4. **Additional Context**
   - When the issue started
   - Workarounds if any
   - Related issues or PRs

## 🚀 Release Process

### Version Numbering
We follow [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Checklist
- [ ] All tests pass
- [ ] Documentation updated
- [ ] Version bumped
- [ ] Changelog updated
- [ ] Release notes prepared

## 📞 Getting Help

### Community Support
- **GitHub Discussions**: For questions and general discussion
- **GitHub Issues**: For bug reports and feature requests
- **Discord**: For real-time chat (if available)

### Documentation
- **Setup Guide**: [docs/installation.md](docs/installation.md)
- **API Documentation**: [docs/api-integration.md](docs/api-integration.md)
- **Troubleshooting**: [docs/troubleshooting.md](docs/troubleshooting.md)

## 📄 License

By contributing to MartFury, you agree that your contributions will be licensed under the MIT License.

## 🙏 Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- Project documentation

Thank you for contributing to MartFury! 🎉
