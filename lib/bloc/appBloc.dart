import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:test_avalon_movie_app/models/list_movies_model.dart';
import 'package:test_avalon_movie_app/static/api.dart';
import 'package:test_avalon_movie_app/static/keys.dart';

class AppBloc extends Bloc {
  static final AppBloc _userBloc = AppBloc._internal();
  factory AppBloc() {
    return _userBloc;
  }

  AppBloc._internal();

  //Streams

  final _listMoviesController = BehaviorSubject<AllMoviesDB>();

  //Recuperar datos de los Streams

  Stream<AllMoviesDB> get listMoviesStream => _listMoviesController.stream;

  //insertar valores a los Streams

  Function(AllMoviesDB) get changeListMoviesStream =>
      _listMoviesController.sink.add;

  //Obtener ultimo valor de los Streams

  AllMoviesDB get listMovies => _listMoviesController.value;

  @override
  void dispose() {
    _listMoviesController.close();
  }

  Future<http.Response> getBy({required String getBy}) async {
    Uri _url = Uri.http(Api.api, Api.pathBase + getBy, {
      "api_key": Keys.keyDBMovie,
    });
    Map<String, String> myHeaders = {
      "Content-Type": "application/json",
    };

    final _responseListMovies = await http.get(_url, headers: myHeaders);

    return _responseListMovies;
  }
}
