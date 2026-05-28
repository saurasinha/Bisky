import 'package:barabar/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App shows home screen title', (WidgetTester tester) async {
    await tester.pumpWidget(const BiskyApp());

    expect(find.text('BISKY'), findsOneWidget);
    expect(find.text('Split smartly with your inner circle'), findsOneWidget);
  });
}
