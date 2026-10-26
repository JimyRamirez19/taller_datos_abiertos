import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/dashboard/dashboard_screen.dart';
import '../views/listing/listing_screen.dart';
import '../views/detail/detail_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/listing/:category',
      builder: (context, state) {
        final category = state.pathParameters['category']!;

        return ListingScreen(category: category);
      },
    ),
    GoRoute(
      path: '/detail/:category/:id',
      builder: (context, state) {
        final category = state.pathParameters['category']!;
        final id = state.pathParameters['id']!;

        return DetailScreen(
          category: category,
          id: id,
        );
      },
    ),
  ],
);