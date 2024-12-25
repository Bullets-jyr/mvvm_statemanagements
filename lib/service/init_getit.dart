import 'package:get_it/get_it.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/service/api_service.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  // 이제 Get 인스턴스나 싱글톤을 초기화하려면 이 함수를 사용해야 합니다.
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<MoviesRepository>(() => MoviesRepository(getIt<ApiService>()));
}