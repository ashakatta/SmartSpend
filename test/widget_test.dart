import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:smartspend/main.dart';
import 'package:smartspend/providers/expense_provider.dart';

void main() {
  testWidgets('SmartSpend app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ExpenseProvider(),
        child: const SmartSpendApp(),
      ),
    );

    expect(find.text('SmartSpend'), findsOneWidget);
  });
}