# SmartSpend – Expense Tracker

## About the Project
SmartSpend is a Flutter-based expense tracking application designed to help users manage their daily expenses, monitor spending habits, and understand their financial activities.

## Features
- Add new expenses with title, amount, category, date, and note.
- View all transactions.
- Edit existing expenses.
- Delete expenses.
- View detailed expense information.
- Track total expenses.
- View category-wise spending summaries.
- Calculate category-wise spending percentages.
- Store expense data locally.
- Data persistence using SharedPreferences.
- Form validation.
- Loading, error, and empty states.

## Technologies Used
- Flutter
- Dart
- Android Studio
- Provider
- SharedPreferences

## Project Structure
```text
lib/
├── models/
│   └── expense.dart
├── providers/
│   └── expense_provider.dart
├── screens/
│   ├── category_summary_screen.dart
│   ├── edit_expense_screen.dart
│   ├── expense_details_screen.dart
│   └── transactions_screen.dart
└── main.dart

assets/
└── images/
    └── app_icon.png

test/
└── widget_test.dart
```

## Installation and Setup

1. Clone the repository:
```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

2. Open the project folder:
```bash
cd smartspend
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the application:
```bash
flutter run
```

## Testing

Run the widget tests using:

```bash
flutter test
```

Check code quality using:

```bash
flutter analyze
```

## Future Enhancements
- Monthly expense reports.
- Budget planning.
- Graphical spending analytics.
- Export expense reports.

## Author
Developed as an academic project using Flutter and Dart.

## License
This project is available for educational purposes.
