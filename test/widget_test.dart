import 'package:flutter_test/flutter_test.dart';

import 'package:zen_plus/main.dart';

void main() {
  testWidgets('renders app shell', (WidgetTester tester) async {
    await tester.pumpWidget(const ZenPulseApp());
    expect(find.text('ZenPulse Premium'), findsOneWidget);
  });
}
