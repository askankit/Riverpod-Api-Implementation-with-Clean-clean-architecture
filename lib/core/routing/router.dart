// Provider to get the router instance
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_application/feature/home_view/presentation/pages/all_notes.dart';

import '../../feature/home_view/presentation/pages/get_photos_view.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authStateNotifier = ValueNotifier(const AsyncValue.loading());
  ref.onDispose(authStateNotifier.dispose);
  final router = GoRouter(
    debugLogDiagnostics: true,
    observers:  [],
    initialLocation: Routes.allScreen,
    routes: [
      GoRoute(
        path: Routes.allScreen,
        builder: (_, __) => const AllListScreen(),
      ),
      GoRoute(
        path: Routes.photos,
        builder: (_, __) => const PhotosView(),
      ),
    ],
    refreshListenable: authStateNotifier,
    redirect: (_, state) {
      return null;
    },
  );
  ref.onDispose(router.dispose);
  return router;
});