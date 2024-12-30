import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_provider.dart';
import 'package:mvvm_statemanagements/widgets/my_error_widget.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  Future<void> _loadInitialData(WidgetRef ref) async {
    await Future.microtask(() async {
      await ref.read(moviesProvider.notifier).getMovies();
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await Provider.of<MoviesProvider>(context, listen: false).getMovies();
    // });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If you do this, you will have an infinite loop with the Future builder
    // This will cause rebuild for future builder and it will keep updating the state
    // final moviesStateProvider = ref.watch(moviesProvider);
    // log("moviesStateProvider genres length ${moviesStateProvider.genresList.length}");
    return Scaffold(
      body: FutureBuilder(
        future: _loadInitialData(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          } else if (snapshot.hasError) {
            if (ref.watch(moviesProvider).genresList.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                getIt<NavigationService>().navigateReplace(
                  const MoviesScreen(),
                );
              });
            }
            return MyErrorWidget(
              errorText: snapshot.error.toString(),
              retryFunction: () async {
                await _loadInitialData(ref);
              },
            );
          } else {
            log("moviesStateProvider genres length ${ref.watch(moviesProvider).genresList.length}");

            WidgetsBinding.instance.addPostFrameCallback((_) {
              getIt<NavigationService>().navigateReplace(
                const MoviesScreen(),
              );
            });

            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
