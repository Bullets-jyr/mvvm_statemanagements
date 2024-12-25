import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_constants.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/widgets/cached_image_widget.dart';
import 'package:mvvm_statemanagements/widgets/movies/favorite_btn_widget.dart';
import 'package:mvvm_statemanagements/widgets/movies/genres_list_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movieModel;

  const MovieDetailsScreen({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: movieModel.id,
              child: SizedBox(
                height: size.height * 0.45,
                width: double.infinity,
                child: CachedImageWidget(
                  imgUrl:
                      "https://image.tmdb.org/t/p/w500/${movieModel.backdropPath}",
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상단 여백
                  SizedBox(
                    height: size.height * 0.4,
                    // child: Container(color: Colors.red,),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 25),
                                Text(
                                  movieModel.title,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    // color: Theme.of(context).textSelectionColor,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text("${movieModel.voteAverage.toStringAsFixed(1)}/10"),
                                    const Spacer(),
                                    Text(
                                      movieModel.releaseDate,
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                GenresListWidget(
                                  movieModel: movieModel,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  movieModel.overview,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FavoriteBtnWidget(
                              movieModel: movieModel,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const BackButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
