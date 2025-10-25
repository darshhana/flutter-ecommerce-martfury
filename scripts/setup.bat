@echo off
REM MartFury Flutter E-commerce App Setup Script for Windows
REM This script helps you set up the development environment

echo 🚀 Setting up MartFury Flutter E-commerce App...

REM Check if Flutter is installed
echo [INFO] Checking Flutter installation...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter is not installed!
    echo [INFO] Please install Flutter from: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)
echo [SUCCESS] Flutter is installed

REM Check if Dart is installed
echo [INFO] Checking Dart installation...
dart --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Dart is not found in PATH, but should be included with Flutter
) else (
    echo [SUCCESS] Dart is installed
)

REM Setup environment file
echo [INFO] Setting up environment configuration...
if not exist ".env" (
    if exist "env.example" (
        copy env.example .env >nul
        echo [SUCCESS] Created .env file from template
        echo [WARNING] Please update .env file with your configuration
    ) else (
        echo [WARNING] env.example file not found, creating basic .env file
        (
            echo # MartFury Flutter E-commerce App Configuration
            echo APP_NAME=MartFury
            echo APP_ENV=development
            echo API_BASE_URL=https://your-botble-ecommerce-api.com
            echo DEBUG_MODE=true
        ) > .env
        echo [SUCCESS] Created basic .env file
    )
) else (
    echo [WARNING] .env file already exists, skipping creation
)

REM Install dependencies
echo [INFO] Installing Flutter dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)
echo [SUCCESS] Dependencies installed successfully

REM Check Flutter doctor
echo [INFO] Running Flutter doctor to check for issues...
flutter doctor
if %errorlevel% neq 0 (
    echo [WARNING] Flutter doctor found some issues
    echo [WARNING] Please resolve the issues before continuing
)

REM Format code
echo [INFO] Formatting code...
flutter format .
if %errorlevel% neq 0 (
    echo [WARNING] Code formatting failed
) else (
    echo [SUCCESS] Code formatted successfully
)

REM Analyze code
echo [INFO] Analyzing code...
flutter analyze
if %errorlevel% neq 0 (
    echo [WARNING] Code analysis found some issues
    echo [WARNING] Please fix the issues before committing
) else (
    echo [SUCCESS] Code analysis completed successfully
)

REM Run tests
echo [INFO] Running tests...
flutter test
if %errorlevel% neq 0 (
    echo [WARNING] Some tests failed
    echo [WARNING] Please check the test output above
) else (
    echo [SUCCESS] All tests passed
)

echo.
echo 🎉 Setup completed successfully!
echo.
echo Next steps:
echo 1. Update .env file with your configuration
echo 2. Run 'flutter run' to start the app
echo 3. Check the documentation in docs/ folder
echo.
echo Happy coding! 🚀
pause
