# Lost Item Recovery Network

The Lost Item Recovery Network addresses the common issue of losing and finding personal items by providing a centralized platform for users to report lost or found items.

## Installation

### Prerequisites

- Flutter SDK
- Firebase account (for authentication, Firestore, and storage)
- A working Dart environment
- Android Studio
- Visual Studio Code

### Steps

1. **Extract the file**: `lost_item_recovery_network.zip`
2. **Open the project in VSCode**
3. **Select an Android device**
4. **Install dependencies**:
    ```bash
    flutter pub get
    ```
5. **Run the application**:
    ```bash
    flutter run
    ```
6. **Build APK** (If you want to run the app on an Android phone, install the resulting app in `build\app\outputs\flutter-apk\app-release.apk` to your Android phone):
    ```bash
    flutter build apk --release
    ```

## Project Structure

- **lib**: Contains the main application code.
    - **constants/colors.dart**: Defines color constants used throughout the app.
    - **pages**: Contains the main pages of the application (`login_page.dart`, `sign_up.dart`, `home_page.dart`).
    - **screens**: Contains additional screens for specific functionalities (`chat_screen.dart`, `item_list_screen.dart`, `post_item_screen.dart`).
    - **services**: Contains the service classes for authentication, image upload, and chat message handling (`auth_service.dart`, `image_upload_service.dart`).
    - **utils**: Contains utility classes for custom colors and text styles.
    - **main.dart**: Entry point of the application.

## Usage

- **Login/Sign Up**: Users can sign up with their email or log in with existing credentials. Anonymous login is also supported.
- **Post Announcements**: Users can post announcements for lost or found items, including descriptions and images.
- **Direct Messaging**: Users can send messages to others who have posted announcements about lost or found items.

## Detailed Report

For a comprehensive report of the project, including design details, implementation, and evaluation, see the [Report.pdf](Report.pdf).
