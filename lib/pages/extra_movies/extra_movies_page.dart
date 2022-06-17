import 'package:flutter/material.dart';
import 'package:test_avalon_movie_app/custom/widgets/custom_app_bar.dart';
import 'package:test_avalon_movie_app/custom/widgets/custom_cached_network_image.dart';
import 'package:test_avalon_movie_app/custom/widgets/title_category.dart';
import 'package:test_avalon_movie_app/models/list_movies_model.dart';
import 'package:test_avalon_movie_app/pages/detail_movie/movie_detail.dart';
import 'package:test_avalon_movie_app/static/strings.dart';
import 'package:test_avalon_movie_app/utils/date.dart';

class ExtraMovies extends StatelessWidget {
  static const String route = '/extraMovies';

  final Map<String, dynamic> data;
  const ExtraMovies({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    String title = data['title'] ?? '';
    ListMovieDb movies = data['movies'];

    return Scaffold(
      body: Container(
        height: _size.height,
        width: _size.width,
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                const CustomAppBar(
                  needIcon: true,
                ),
                TitleCategory(
                  titleCategory: title,
                  icon: const Icon(
                    Icons.star_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                ListMoviesByCategory(
                  listMovieDb: movies,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListMoviesByCategory extends StatelessWidget {
  final ListMovieDb listMovieDb;
  const ListMoviesByCategory({Key? key, required this.listMovieDb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: _size.height * 0.65,
            child: ListView.builder(
              itemCount: listMovieDb.results!.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(DetailMovie.route,
                        arguments: {
                          Strings.movie: listMovieDb.results![index]
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: _size.width,
                    child: SizedBox(
                      height: 110,
                      child: Row(children: <Widget>[
                        CachedImage(
                          path: listMovieDb.results![index].backdropPath!,
                          width: 90,
                          height: 120,
                          boxFit: BoxFit.fill,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: _size.width * 0.5,
                              child: Text(listMovieDb.results![index].title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: 20)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  listMovieDb.results![index].voteAverage
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 10,
                                      ),
                                ),
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellowAccent,
                                  size: 15,
                                )
                              ],
                            ),
                            Text(
                              Utils().getDateFromDateTime(
                                  listMovieDb.results![index].releaseDate!),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 10,
                                  ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
