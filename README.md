# 💱 Currency Converter

A sleek and modern Flutter application that provides real-time currency conversion. Built with a focus on clean UI/UX, it fetches live exchange rates to ensure precision for global transactions.



## 🚀 Overview

This project was developed to provide a fast and intuitive way to convert between **Mozambican Metical (MZN)**, **US Dollar (USD)**, **Euro (EUR)**, and **South African Rand (ZAR)**. The app features a reactive interface where updating one field instantly calculates the values for all others.

## ✨ Key Features

* **Live Data:** Integration with [ExchangeRate-API](https://www.exchangerate-api.com/) for up-to-the-minute accuracy.
* **Reactive UI:** Instant calculations as you type (no "Convert" button needed).
* **Smart Input:** Advanced parsing logic that handles both commas and periods as decimal separators.
* **Dark Mode Aesthetic:** A clean, high-contrast dark theme using Google's Montserrat typography.
* **Keyboard Management:** Automatic focus handling and specialized numeric inputs for a better mobile experience.

## 🛠️ Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** [Dart](https://dart.dev/)
* **Fonts:** [Google Fonts (Montserrat)](https://pub.dev/packages/google_fonts)
* **Network:** [HTTP Package](https://pub.dev/packages/http) for API consumption.
* **State Management:** Core Flutter StatefulWidgets for real-time reactivity.

## ⚙️ Logic & Math

The application uses **USD** as the base currency from the API. The conversion logic follows the principle:
1.  **To USD:** `Input / Base Rate`
2.  **Cross-Currency:** `(Input / Source Rate) * Target Rate`



## 📦 How to Run

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/anwar-machado/Currency-Converter.git](https://github.com/anwar-machado/Currency-Converter.git)
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the application:**
    ```bash
    flutter run
    ```

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---
**Developed by [Anwar Machado](https://github.com/anwar-machado)**
