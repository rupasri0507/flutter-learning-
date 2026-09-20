// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:currency_converter_app/main.dart';

void main() {
  testWidgets('entering INR converts to USD', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final inrField = find.byKey(const ValueKey('inr_amount'));
    final usdField = find.byKey(const ValueKey('usd_amount'));

    await tester.enterText(inrField, '83');
    await tester.pump();

    expect((tester.widget<TextField>(usdField).controller?.text ?? ''), '1.00');
  });

  testWidgets('entering USD converts to INR', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final usdField = find.byKey(const ValueKey('usd_amount'));
    final inrField = find.byKey(const ValueKey('inr_amount'));

    await tester.enterText(usdField, '10');
    await tester.pump();

    expect(
      (tester.widget<TextField>(inrField).controller?.text ?? ''),
      '830.00',
    );
  });
}
