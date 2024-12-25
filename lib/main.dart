import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_statemanagements/constants/my_theme_data.dart';
import 'package:mvvm_statemanagements/screens/favorite_screen.dart';
import 'package:mvvm_statemanagements/screens/movie_details.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/screens/splash_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';

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
    return MaterialApp(
      // 이 머터리얼 앱에 탐색 키를 추가할 수 있습니다.
      // 그리고 이 탐색 키를 추가하면 그로부터 컨텍스트를 얻을 수 있습니다.
      // 따라서 이 키에서 컨텍스트에 액세스할 수 있습니다.
      navigatorKey: getIt<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: MyThemeData.lightTheme,
      home: const MoviesScreen(),
      // home: const FavoritesScreen(),
      // home: const MovieDetailsScreen(),
      // home: const SplashScreen(),
    );
  }
}
