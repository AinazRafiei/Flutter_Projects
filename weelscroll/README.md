# Wheel Scroll Time Picker – Flutter

A simple and clean Flutter app that demonstrates a **scrollable time picker** using `ListWheelScrollView`.  
Users can scroll through hours, minutes, and AM/PM to select a time.

<p align="center">
  <img src="https://github.com/user-attachments/assets/74d47b89-f866-4fb3-b4c0-bd3f6ded187b" width="300"/>
</p>

---

## Features

- Scroll through **Hours (0-12)** using a ListWheel
- Scroll through **Minutes (0-59)** with two-digit formatting
- Switch between **AM** and **PM**
- Smooth scrolling with `FixedExtentScrollPhysics`
- Custom designed widgets for hours, minutes, and AM/PM
- Dark-themed minimalistic UI

---

## Getting Started

To run the project locally:

```bash
git clone https://github.com/AinazRafiei/Flutter_Projects.git
cd Flutter_Projects/weelscroll
flutter pub get
flutter run

weelscroll/
├── lib/
│   ├── am_pm.dart
│   ├── homepage.dart
│   ├── hours.dart
│   ├── minutes.dart
│   ├── tile.dart
│   └── main.dart
├── pubspec.yaml
├── README.md
