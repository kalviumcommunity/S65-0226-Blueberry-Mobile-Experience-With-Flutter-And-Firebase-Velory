// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:velory/main.dart';

void main() {
  testWidgets('Velory responsive home renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VeloryApp());

    // Verify that the app bar contains 'Velory' title
    expect(find.text('Velory'), findsWidgets);

    // Verify that the welcome message is displayed
    expect(find.text('Welcome to Velory'), findsOneWidget);

    // Verify that feature cards are displayed
    expect(find.text('Smart Routes'), findsOneWidget);
    expect(find.text('Safe Passages'), findsOneWidget);
    expect(find.text('Analytics'), findsOneWidget);

    // Verify that action buttons are present
    expect(find.text('Start Journey'), findsOneWidget);
    expect(find.text('Learn More'), findsOneWidget);
  });
}
