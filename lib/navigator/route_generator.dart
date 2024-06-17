import 'package:flutter/material.dart';
import 'package:flutter02/page/login_page.dart';
import 'package:flutter02/page/start/splash_screen%20_page.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
    case Routes.splashScreenPage:
    return MaterialPageRoute(builder: (_) => const SplashScreenPage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    // Add more cases for other routes
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}