import 'package:flutter/material.dart';
import 'package:test_avalon_movie_app/custom/widgets/custom_cached_network_image.dart';
import 'package:test_avalon_movie_app/custom/widgets/custom_texts.dart';
import 'package:test_avalon_movie_app/custom/widgets/rows.dart';
import 'package:test_avalon_movie_app/models/list_movies_model.dart';
import 'package:test_avalon_movie_app/static/strings.dart';
import 'package:test_avalon_movie_app/utils/date.dart';

class DetailMovie extends StatelessWidget {
  static const String route = '/detailMovie';

  final Map<String, dynamic> data;

  const DetailMovie({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    Result result = data[Strings.movie] as Result;
    return Scaffold(
      body: Container(
        height: _size.height,
        width: _size.width,
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _size.height * 0.45,
                  width: _size.width,
                  child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        CachedImage(
                          path: result.backdropPath!,
                          boxFit: BoxFit.fill,
                          height: double.infinity,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                            ),
                            Expanded(child: Container()),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CustomText(
                                text: result.title!,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
                SizedBox(
                  height: _size.height * 0.5,
                  width: _size.width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomRow(
                            textLeft: Strings.popularity,
                            textRight: result.popularity.toString(),
                            icon: const Icon(Icons.remove_red_eye_rounded,
                                color: Colors.red),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomRow(
                            textLeft: Strings.rating,
                            textRight: result.voteAverage.toString(),
                            icon: const Icon(Icons.star_rounded,
                                color: Colors.yellowAccent),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomRow(
                            textLeft: Strings.stars,
                            textRight: result.voteCount.toString(),
                            icon:
                                const Icon(Icons.numbers, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomRow(
                            textLeft: Strings.adult,
                            textRight: result.adult ?? false ? "Yes" : "No",
                            icon: const Icon(Icons.groups_rounded,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomRow(
                            textLeft: Strings.releaseDate,
                            textRight: Utils()
                                .getDateFromDateTime(result.releaseDate!),
                            icon: const Icon(Icons.calendar_month_rounded,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomRow(
                            textLeft: Strings.originalLanguage,
                            textRight: result.originalLanguage.toString(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomText(
                            text: Strings.overview,
                            fontSize: 17,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: _size.height * 0.2,
                            child: SingleChildScrollView(
                                child: CustomTextBody(text: result.overview!)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
