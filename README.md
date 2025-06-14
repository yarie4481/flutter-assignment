# Flutter Feature Demo App

A showcase application demonstrating core Flutter capabilities and advanced features.

## ✨ Key Features

### Authentication

- Secure login flow with form validation
- Provider-based state management
- Session persistence

### UI Components

- Custom animated progress bar with dynamic colors
- Responsive layout for all screen sizes
- Smoothly animated navigation drawer

### Data Management

- **To-Do System**:
  - Add/edit/delete tasks
  - SQLite local storage
  - Swipe-to-delete gesture
- **API Integration**:
  - Fetch remote JSON data
  - Offline caching
  - Pull-to-refresh

## 🛠 Installation

1. Ensure Flutter SDK is installed
2. Clone repository:
   ```bash
   git clone https://github.com/yarie4481/flutter-assignment.git
   Install dependencies:
   ```

bash
cd flutter_feature_demo
flutter pub get
Run the app:

bash
flutter run
🚀 How to Use
Authentication Flow
Launch app to see login screen

Enter credentials (any non-empty values work)

Access authenticated features

Main Functionality
Home:

Interact with custom progress bar

Try string reversal utility

To-Do:

Add tasks via input field

Toggle completion status

Swipe left to delete

API Demo:

View fetched posts

Works offline with cached data

Refresh button for updates

🧰 Technical Implementation
Architecture
Clean component separation

Provider state management

Platform-aware design

Performance
Efficient widget rebuilding

Lazy-loaded lists

Smooth 60fps animations

Dependencies
Package Version Purpose
provider ^6.0.5 State management
sqflite ^2.3.0 Local database
http ^0.13.5 API requests
shared_preferences ^2.2.2 Local caching
📝 Notes
Tested on Flutter 3.13.0+

Supports Android/iOS

MIT Licensed

For development help, see Flutter's online documentation.

text

This version:

1. Uses clear markdown formatting
2. Has proper spacing and section breaks
3. Maintains consistent heading levels
4. Includes functional code blocks
5. Presents information in a professional, product-oriented way
6. Is ready for immediate use in your repository
