// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:thespot/ui/screens/auth/auth_screen.dart';
import 'package:thespot/ui/screens/reserve_or_query/reserve_or_query_screen.dart';

class TheSpotRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AUTH_ROUTE:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case RESERVE_OR_QUERY_ROUTE:
        return MaterialPageRoute(builder: (_) => const ReserveOrQueryScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static const AUTH_ROUTE = '/';
  static const RESERVE_OR_QUERY_ROUTE = '/main';
}