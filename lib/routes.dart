import 'package:flutter_todo_phoenix/main.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> _routes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const InitScreen(),
  ),
]; // ] + userRoutes;

final GoRouter router = GoRouter(
  routes: _routes,
  // debugLogDiagnostics: true,
);
