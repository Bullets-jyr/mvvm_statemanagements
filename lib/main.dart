import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_statemanagements/constants/my_theme_data.dart';
import 'package:mvvm_statemanagements/screens/favorites_screen.dart';
import 'package:mvvm_statemanagements/screens/movie_details.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/screens/splash_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/favorites_provider.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/view_models/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator(); // Initialize GetIt
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((_) async {
    await dotenv.load(fileName: "assets/.env");
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
          // create: (_) => ThemeProvider()..loadTheme(),
        ),
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(),
        ),
      ],
      child: Consumer(builder: (context, ThemeProvider themeProvider, child) {
        return MaterialApp(
          navigatorKey: getIt<NavigationService>().navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Movies App',
          theme: themeProvider.themeData, //MyThemeData.darkTheme,
          home: const SplashScreen(),
          // const SplashScreen(), //const MovieDetailsScreen(), //const FavoritesScreen(), //const MoviesScreen(),
        );
      }),
    );
  }
}
