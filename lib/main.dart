import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:http/http.dart';
import 'package:test_avalon_movie_app/bloc/appBloc.dart';
import 'package:test_avalon_movie_app/models/list_movies_model.dart';
import 'package:test_avalon_movie_app/pages/main_page/home_page.dart';
import 'package:test_avalon_movie_app/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(BlocProvider(bloc: AppBloc(), child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moaplon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: const Color.fromRGBO(28, 28, 36, 1),
          textTheme: const TextTheme(
              titleLarge: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              bodyMedium: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
              bodySmall: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ))),
      home: const LoadingPage(),
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}

class LoadingPage extends StatelessWidget {
  static const route = "/";
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder<void>(
      future: getListMovies(context),
      builder: (context, snapshot) {
        return const WaitingSplash();
      });

  Future<void> getListMovies(BuildContext context) async {
    AllMoviesDB allMoviesDB = AllMoviesDB.fromEmty();
    try {
      final Response listMoviesByPopular =
          await AppBloc().getBy(getBy: "popular");
      if (listMoviesByPopular.statusCode == 200) {
        allMoviesDB.popularMovies =
            listMovieDbFromJson(listMoviesByPopular.body);
      }

      final Response listMoviesByRank =
          await AppBloc().getBy(getBy: "top_rated");
      if (listMoviesByRank.statusCode == 200) {
        allMoviesDB.ratedMovies = listMovieDbFromJson(listMoviesByRank.body);
      }

      final AppBloc bloc = BlocProvider.of<AppBloc>(context);

      bloc.changeListMoviesStream(allMoviesDB);

      Navigator.of(context).pushNamedAndRemoveUntil(
          HomePage.route, ModalRoute.withName(HomePage.route));
    } catch (error) {
      print(error);
    }
  }
}

class WaitingSplash extends StatelessWidget {
  const WaitingSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromRGBO(28, 28, 36, 1),
        child: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
