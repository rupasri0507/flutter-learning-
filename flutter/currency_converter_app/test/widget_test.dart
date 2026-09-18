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
  testWidgets('USD amount is converted to words in the result field',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final usdField = find.byType(TextField).first;
    final inrField = find.byType(TextField).last;

    await tester.enterText(usdField, '100');
    await tester.pump();

    expect((tester.widget<TextField>(inrField).controller?.text ?? ''), 'one hundred');
  });
}
