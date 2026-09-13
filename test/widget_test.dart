import 'package:flutter_test/flutter_test.dart';
import 'package:rozana_rewards/main.dart';

void main() {
  testWidgets('Rozana Rewards loads', (WidgetTester tester) async {
    await tester.pumpWidget(const RozanaRewards());

    expect(find.text('Rozana Rewards'), findsOneWidget);
  });
}
