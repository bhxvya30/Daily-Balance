# Building Daily Balance in Android Studio

## Prerequisites
- Android Studio Hedgehog or later
- Flutter SDK 3.x installed and in PATH
- Android SDK installed (API 33+)
- USB Debugging enabled on your Android phone

## Steps

### 1. Clone the repo
   git clone https://github.com/YOUR_USERNAME/daily-balance.git
   cd daily-balance

### 2. Open in Android Studio
   File → Open → select the daily-balance folder
   Wait for Gradle sync to complete (2–5 minutes first time)

### 3. Install dependencies
   Open Terminal tab (bottom) → run:
   flutter pub get

### 4. Connect your phone
   Connect phone via USB
   Enable Developer Mode: Settings → About → tap Build Number 7 times
   Enable USB Debugging: Settings → Developer Options → USB Debugging ON
   Accept the "Allow USB Debugging" dialog on your phone

### 5. Select device
   In Android Studio toolbar: click device dropdown
   Select your phone (should appear with model name)

### 6. Run the app
   Click green Run button ▶ or press Shift+F10
   First build takes 3–5 minutes (Gradle compiling)
   Subsequent runs: 15–30 seconds

### 7. If flutter is not found
   Android Studio → Settings → Languages & Frameworks → Flutter
   Set Flutter SDK path to your flutter installation folder

## Troubleshooting

Problem: "SDK location not found"
Fix: Create android/local.properties with:
     sdk.dir=/Users/YOUR_NAME/Library/Android/sdk  (Mac)
     sdk.dir=C:\\Users\\YOUR_NAME\\AppData\\Local\\Android\\Sdk  (Windows)

Problem: "Minimum SDK version"
Fix: In android/app/build.gradle set: minSdkVersion 21

Problem: Fonts not loading
Fix: Run: flutter pub get → then flutter clean → flutter run

Problem: BackdropFilter showing black instead of blur
Fix: In android/app/src/main/AndroidManifest.xml add inside <application>:
     android:hardwareAccelerated="true"
