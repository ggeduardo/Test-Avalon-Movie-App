import 'package:flutter/material.dart';
import 'package:test_avalon_movie_app/main.dart';
import 'package:test_avalon_movie_app/pages/detail_movie/movie_detail.dart';
import 'package:test_avalon_movie_app/pages/extra_movies/extra_movies_page.dart';
import 'package:test_avalon_movie_app/pages/main_page/home_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case LoadingPage.route:
        page = const LoadingPage();
        break;
      case HomePage.route:
        page = const HomePage();
        break;
      case ExtraMovies.route:
        page = ExtraMovies(
          data: settings.arguments as Map<String, dynamic>,
        );
        break;
      case DetailMovie.route:
        page = DetailMovie(data: settings.arguments as Map<String, dynamic>);
        break;
      default:
        page = const HomePage();
        break;
    }
    return RouteAnimation(page: page);
  }
}

class RouteAnimation extends PageRouteBuilder {
  final Widget page;
  final Offset? begin;
  final Offset? end;
  RouteAnimation({required this.page, this.begin, this.end})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var _begin = begin ?? const Offset(1.0, 0.0);
              var _end = end ?? Offset.zero;
              var curve = Curves.easeOut;
              var tween = Tween(
                begin: _begin,
                end: _end,
              ).chain(CurveTween(curve: curve)).animate(animation);

              return SlideTransition(position: tween, child: child);
            });
}
