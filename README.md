#  Product Catalog -- Flutter Mobile Application


<p align="center">
  <img src="screenshots/light_list.png" width="200"/>
  <img src="screenshots/light_grid.png" width="200"/>
  <img src="screenshots/light_detail.png" width="200"/>
  <img src="screenshots/dark_home.png" width="200"/>
</p>

<p align="center">
  <b>A modern, feature-rich product catalog application built with Flutter</b><br/>
  <i>Showcasing clean architecture, Material Design 3, and best practices</i>
</p>

---

## Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Project Structure](#-project-structure)

---

##  Overview

**Product Catalog** is a professional-grade Flutter mobile application that demonstrates modern UI/UX design patterns and best practices in mobile app development. Built as a demonstration of Flutter's capabilities, this app showcases a complete product browsing experience with advanced filtering, search functionality, and persistent user preferences.

### Purpose

This application serves as:

- Learning Resource: A comprehensive example of Flutter app architecture
- UI/UX Showcase: Implementation of Material Design 3 principles
- Code Reference: Clean, well-documented code following Flutter best practices

------------------------------------------------------------------------

##  Features

###  Intelligent Search
- Real-time search
- Multi-field (name + description)
- Case-insensitive
- One-tap clear

###  Advanced Filtering
- Category chips (multi-select)
- Price range slider
- Minimum rating filter
- Combined filtering support

###  Sorting
- Name (A–Z)
- Price (Low → High / High → Low)
- Rating (Highest first)
- Persistent preference

###  Favorites
- One-tap favorite toggle
- Persistent storage
- Favorites screen
- Badge counter
- Synced across views

###  Theme System
- Light mode
- Dark mode
- System default
- Saved preference

###  View Modes
- List view
- Grid view
- Persistent selection

###  Pull to Refresh
- Swipe refresh
- Loading indicator
- Simulated network delay

###  Animations
- Hero animations
- Smooth transitions

###  Empty States
- Informative UI
- Clear reset actions

------------------------------------------------------------------------

##  Requirements

### SDKs
| Tool | Minimum | Recommended |
|----|----|----|
| Flutter | 3.0.0 | 3.16+ |
| Dart | 2.19 | 3.2+ |
| Android Studio | 2021.1 | Latest |
| VS Code | 1.70 | Latest |

### Platforms
-  Android (API 21+)
-  iOS (11+)
-  Web
-  Windows / macOS / Linux

------------------------------------------------------------------------

##  Installation

``` bash
git clone https://github.com/Abdelrahman2610/product-catalog-app.git
cd product-catalog-app
flutter pub get
flutter run
```

------------------------------------------------------------------------

##  Project Structure

``` text
product_catalog_app/
│
├── lib/
│   ├── main.dart                          # Application entry point
│   │
│   ├── models/                            # Data models
│   │   ├── product.dart                   # Product model with properties
│   │   └── app_preferences.dart           # User preferences model
│   │
│   ├── screens/                           # UI screens
│   │   ├── home_screen.dart               # Main product list screen
│   │   ├── detail_screen.dart             # Product detail screen
│   │   └── favorites_screen.dart          # Favorites collection screen
│   │
│   ├── widgets/                           # Reusable UI components
│   │   ├── product_card.dart              # List view product card
│   │   ├── product_grid_item.dart         # Grid view product item
│   │   ├── search_bar_widget.dart         # Custom search bar
│   │   ├── filter_chip_widget.dart        # Category filter chip
│   │   ├── empty_state_widget.dart        # Empty state placeholder
│   │   ├── price_range_slider.dart        # Price filter slider
│   │   └── advanced_search_sheet.dart     # Advanced search modal
│   │
│   ├── services/                          # Business logic layer
│   │   └── preferences_service.dart       # Local storage service
│   │
│   ├── data/                              # Data layer
│   │   └── dummy_data.dart                # Hardcoded product data
│   │
│   └── theme/                             # Theming configuration
│       └── app_theme.dart                 # Light & dark themes
│
│
├── screenshots/                           # App screenshots 
│
├── android/                               # Android-specific code
├── ios/                                   # iOS-specific code
├── web/                                   # Web-specific code
├── macos/                                 # macOS-specific code
├── windows/                               # Windows-specific code
├── linux/                                 # Linux-specific code
│
├── pubspec.yaml                           # Project dependencies
├── analysis_options.yaml                  # Linting rules
└──  README.md                              # This file

```

------------------------------------------------------------------------

Made with ❤️ using Flutter
