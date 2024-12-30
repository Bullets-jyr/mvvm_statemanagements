// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../models/movies_model.dart';
// import '../../repository/movies_repo.dart';
// import '../../service/init_getit.dart';
// import 'movies_state.dart';
//
// final moviesProvider = StateNotifierProvider<MoviesProvider, MoviesState>(
//   (_) => MoviesProvider(),
// );
//
// class MoviesProvider extends StateNotifier<MoviesState> {
//   MoviesProvider() : super(MoviesState());
//
//   final MoviesRepository _moviesRepository = getIt<MoviesRepository>();
//   Future<void> getMovies() async {
//     state = state.copyWith(isLoading: true);
//     try {
//       if (state.genresList.isEmpty) {
//         final genresList = await _moviesRepository.fetchGenres();
//         state = state.copyWith(genresList: genresList);
//       }
//       List<MovieModel> movies =
//           await _moviesRepository.fetchMovies(page: state.currentPage);
//       state = state.copyWith(
//         moviesList: [...state.moviesList, ...movies],
//         currentPage: state.currentPage + 1,
//         fetchMoviesError: '',
//         isLoading: false,
//       );
//     } catch (e) {
//       state = state.copyWith(fetchMoviesError: e.toString(), isLoading: false);
//       rethrow;
//     }
//   }
// }