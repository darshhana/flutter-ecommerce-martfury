#!/bin/bash

# MartFury Flutter E-commerce App Setup Script
# This script helps you set up the development environment

set -e

echo "🚀 Setting up MartFury Flutter E-commerce App..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Flutter is installed
check_flutter() {
    print_status "Checking Flutter installation..."
    
    if command -v flutter &> /dev/null; then
        FLUTTER_VERSION=$(flutter --version | head -n 1 | cut -d ' ' -f 2)
        print_success "Flutter is installed (version: $FLUTTER_VERSION)"
        
        # Check if version is compatible
        if [[ "$FLUTTER_VERSION" < "3.7.2" ]]; then
            print_warning "Flutter version $FLUTTER_VERSION is below the recommended 3.7.2"
            print_warning "Consider updating Flutter for the best experience"
        fi
    else
        print_error "Flutter is not installed!"
        print_status "Please install Flutter from: https://flutter.dev/docs/get-started/install"
        exit 1
    fi
}

# Check if Dart is installed
check_dart() {
    print_status "Checking Dart installation..."
    
    if command -v dart &> /dev/null; then
        DART_VERSION=$(dart --version | cut -d ' ' -f 4)
        print_success "Dart is installed (version: $DART_VERSION)"
    else
        print_warning "Dart is not found in PATH, but should be included with Flutter"
    fi
}

# Install dependencies
install_dependencies() {
    print_status "Installing Flutter dependencies..."
    
    if flutter pub get; then
        print_success "Dependencies installed successfully"
    else
        print_error "Failed to install dependencies"
        exit 1
    fi
}

# Setup environment file
setup_environment() {
    print_status "Setting up environment configuration..."
    
    if [ ! -f ".env" ]; then
        if [ -f "env.example" ]; then
            cp env.example .env
            print_success "Created .env file from template"
            print_warning "Please update .env file with your configuration"
        else
            print_warning "env.example file not found, creating basic .env file"
            cat > .env << EOF
# MartFury Flutter E-commerce App Configuration
APP_NAME=MartFury
APP_ENV=development
API_BASE_URL=https://your-botble-ecommerce-api.com
DEBUG_MODE=true
EOF
            print_success "Created basic .env file"
        fi
    else
        print_warning ".env file already exists, skipping creation"
    fi
}

# Check Flutter doctor
check_flutter_doctor() {
    print_status "Running Flutter doctor to check for issues..."
    
    if flutter doctor; then
        print_success "Flutter doctor completed"
    else
        print_warning "Flutter doctor found some issues"
        print_warning "Please resolve the issues before continuing"
    fi
}

# Run tests
run_tests() {
    print_status "Running tests..."
    
    if flutter test; then
        print_success "All tests passed"
    else
        print_warning "Some tests failed"
        print_warning "Please check the test output above"
    fi
}

# Analyze code
analyze_code() {
    print_status "Analyzing code..."
    
    if flutter analyze; then
        print_success "Code analysis completed successfully"
    else
        print_warning "Code analysis found some issues"
        print_warning "Please fix the issues before committing"
    fi
}

# Format code
format_code() {
    print_status "Formatting code..."
    
    if flutter format .; then
        print_success "Code formatted successfully"
    else
        print_warning "Code formatting failed"
    fi
}

# Main setup function
main() {
    echo "🛒 MartFury Flutter E-commerce App Setup"
    echo "========================================"
    echo ""
    
    # Check prerequisites
    check_flutter
    check_dart
    
    # Setup environment
    setup_environment
    
    # Install dependencies
    install_dependencies
    
    # Check Flutter doctor
    check_flutter_doctor
    
    # Format and analyze code
    format_code
    analyze_code
    
    # Run tests
    run_tests
    
    echo ""
    echo "🎉 Setup completed successfully!"
    echo ""
    echo "Next steps:"
    echo "1. Update .env file with your configuration"
    echo "2. Run 'flutter run' to start the app"
    echo "3. Check the documentation in docs/ folder"
    echo ""
    echo "Happy coding! 🚀"
}

# Run main function
main "$@"
