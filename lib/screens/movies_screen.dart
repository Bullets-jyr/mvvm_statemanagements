import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/screens/favorite_screen.dart';
import 'package:mvvm_statemanagements/service/api_service.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  // var movieName = 'Fight club';
  final List<MovieModel> _movies = [];
  int _currentPage = 1;
  bool _isFetching = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMovies();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // 이제 최대로 최적화하려면 이미 가져오는 항목을 더 이상 가져오지 않아도 됩니다.
    // 가져오지 않는지 확인하고 싶습니다.
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetching) {
      _fetchMovies();
    }
  }

  Future<void> _fetchMovies() async {
    if (_isFetching) return;
    // 따라서 이 설정된 상태는 값을 변경하고 UI를 다시 빌드하여 새 값 화면에 나타납니다.
    setState(() {
      _isFetching = true;
    });
    // 이것이 내가 서비스 내에서 try catch 블록을 사용하지 않는다고 말한 이유입니다.
    try {
      final List<MovieModel> movies =
          await getIt<MoviesRepository>().fetchMovies(page: _currentPage);
      setState(() {
        _movies.addAll(movies);
        _currentPage++;
      });
    } catch (error) {
      getIt<NavigationService>()
          .showSnackBar("An Error has been occured $error");
    } finally {
      // 이제 finally 및 finally 블록에서 setState 상태를 다시 호출하고
      // 가져오기를 설정하고 싶습니다.
      setState(() {
        _isFetching = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const FavoritesScreen(),
              //   ),
              // );
              // Navigate to the fav screen
              getIt<NavigationService>().navigate(
                const FavoritesScreen(),
              );
              // getIt<NavigationService>().showDialog(
              //   const MoviesWidget(),
              // );
              // getIt<NavigationService>().showSnackBar();
            },
            icon: const Icon(
              MyAppIcons.favoriteRounded,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () async {
              // movieName = 'the gentleman';
              // log('movieName == $movieName');
              // log('This function has been called');
              // final List<MovieModel> movies = await getIt<ApiService>().fetchMovies();
              // log('movies $movies');
              // final List<MoviesGenre> genres = await getIt<ApiService>().fetchGenres();
              // final List<MoviesGenre> genres = await getIt<MoviesRepository>().fetchGenres();
              // log('Genres are $genres');
            },
            icon: const Icon(
              MyAppIcons.darkMode,
            ),
          ),
          // Text(movieName),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        // 그리고 실제로 원 진행률 표시기를 표시하려는 경우에도 마찬가지입니다.
        // 그래서 우리는 여기서 작은 점검을 해야 합니다.
        // 가져오는 중인지 확인하기 위해 할 수 있는 작업입니다.
        // 이 경우에는 더하기 1을 추가하고 그렇지 않은 경우에는 0을 추가합니다.
        itemCount: _movies.length + (_isFetching ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _movies.length) {
            return MoviesWidget(
              movieModel: _movies[index],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
