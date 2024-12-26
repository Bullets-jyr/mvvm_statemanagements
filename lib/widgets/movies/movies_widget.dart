import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_constants.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/screens/movie_details.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/cached_image_widget.dart';
import 'package:mvvm_statemanagements/widgets/movies/favorite_btn_widget.dart';
import 'package:mvvm_statemanagements/widgets/movies/genres_list_widget.dart';
import 'package:provider/provider.dart';

class MoviesWidget extends StatelessWidget {
  // final MovieModel movieModel;

  const MoviesWidget({
    super.key,
    // required this.movieModel
  });

  @override
  Widget build(BuildContext context) {
    final moviesModelProvider = Provider.of<MovieModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            getIt<NavigationService>().navigate(
              ChangeNotifierProvider.value(
                value: moviesModelProvider,
                child: const MovieDetailsScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: moviesModelProvider.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedImageWidget(
                        imgUrl:
                            "https://image.tmdb.org/t/p/w500/${moviesModelProvider.backdropPath}",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          moviesModelProvider.originalTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${moviesModelProvider.voteAverage.toStringAsFixed(1)}/10",
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        GenresListWidget(
                          movieModel: moviesModelProvider,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              MyAppIcons.watchLaterOutlined,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              moviesModelProvider.releaseDate,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            FavoriteBtnWidget(
                              movieModel: moviesModelProvider,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
