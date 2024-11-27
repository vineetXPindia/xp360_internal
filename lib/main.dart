import 'package:flutter/material.dart';
import 'package:xp_internal/screens/home/home.dart';

import 'package:xp_internal/screens/login/login_page.dart';
import 'package:xp_internal/screens/orders/book_new_order.dart';
import 'package:xp_internal/screens/orders/manage_orders.dart';
import 'package:xp_internal/screens/orders/orders.dart';
import 'package:xp_internal/screens/profile/profile_page.dart';
import 'package:xp_internal/screens/tracking/order_tracking.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XP Internal',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
