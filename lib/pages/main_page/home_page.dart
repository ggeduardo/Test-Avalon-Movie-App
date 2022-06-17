import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:test_avalon_movie_app/bloc/appBloc.dart';
import 'package:test_avalon_movie_app/custom/widgets/custom_app_bar.dart';
import 'package:test_avalon_movie_app/custom/widgets/custom_cached_network_image.dart';
import 'package:test_avalon_movie_app/custom/widgets/custom_carousel.dart';
import 'package:test_avalon_movie_app/custom/widgets/custom_texts.dart';
import 'package:test_avalon_movie_app/custom/widgets/title_category.dart';
import 'package:test_avalon_movie_app/models/list_movies_model.dart';
import 'package:test_avalon_movie_app/pages/detail_movie/movie_detail.dart';
import 'package:test_avalon_movie_app/pages/extra_movies/extra_movies_page.dart';
import 'package:test_avalon_movie_app/static/strings.dart';
import 'package:test_avalon_movie_app/utils/date.dart';

class HomePage extends StatelessWidget {
  static const route = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppBloc bloc = BlocProvider.of<AppBloc>(context);

    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: _size.height,
      width: _size.width,
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const CustomAppBar(),
                const TopThreeMovies(),
                MoviesCategory(
                  categoryTitle: Strings.popular,
                  listMovies: bloc.listMovies.popularMovies,
                ),
                MoviesCategory(
                  categoryTitle: Strings.mostRated,
                  listMovies: bloc.listMovies.ratedMovies,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class TopThreeMovies extends StatefulWidget {
  const TopThreeMovies({Key? key}) : super(key: key);

  @override
  State<TopThreeMovies> createState() => _TopThreeMoviesState();
}

class _TopThreeMoviesState extends State<TopThreeMovies> {
  int currentMovie = 0;
  List<Result> listToShow = [];
  late CarouselController carouselController;

  @override
  void initState() {
    super.initState();
    carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final AppBloc bloc = BlocProvider.of<AppBloc>(context);
    TextTheme textTheme = Theme.of(context).textTheme;

    listToShow = [];
    listToShow.add(bloc.listMovies.popularMovies!.results!.first);
    listToShow.add(bloc.listMovies.ratedMovies!.results!.first);

    return SizedBox(
      child: CustomCarouselSlider(
          viewportFraction: 0.85,
          controller: carouselController,
          enableDots: true,
          onPageChanged:
              (int i, CarouselPageChangedReason carouselPageChangedReason) {
            setState(() {
              currentMovie = i;
            });
          },
          indexDot: currentMovie,
          autoPlay: false,
          items: listToShow.map(
            (Result movie) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(DetailMovie.route,
                      arguments: {Strings.movie: movie});
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CachedImage(
                      path: movie.backdropPath!,
                      height: double.infinity,
                      width: double.infinity,
                      boxFit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${movie.voteAverage}',
                                style: textTheme.bodySmall!.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.yellowAccent,
                                size: 20,
                              )
                            ],
                          ),
                          Expanded(child: Container()),
                          CustomText(
                            text: movie.title!,
                            fontSize: 20,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ).toList(),
          height: MediaQuery.of(context).size.height * 0.25),
    );
  }
}

class MoviesCategory extends StatelessWidget {
  final String categoryTitle;
  final ListMovieDb? listMovies;
  const MoviesCategory(
      {Key? key, required this.categoryTitle, required this.listMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleCategory(
              titleCategory: categoryTitle,
              icon: const Icon(Icons.arrow_forward_ios_rounded,
                  size: 25, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed(ExtraMovies.route, arguments: {
                  'title': categoryTitle,
                  'movies': listMovies,
                });
              }),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  DateTime? _release = listMovies!.results![index].releaseDate;
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(DetailMovie.route,
                          arguments: {
                            Strings.movie: listMovies!.results![index]
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CachedImage(
                            path: listMovies!.results![index].backdropPath!,
                            height: 150,
                            boxFit: BoxFit.fill,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomText(text: listMovies!.results![index].title!),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            Utils().getDateFromDateTime(_release!),
                            style: textTheme.bodySmall!.copyWith(
                              fontSize: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${listMovies!.results![index].voteAverage}',
                                style: textTheme.bodySmall!.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.yellowAccent,
                                size: 15,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
