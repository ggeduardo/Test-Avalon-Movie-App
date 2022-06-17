import 'dart:convert';

ListMovieDb listMovieDbFromJson(String str) =>
    ListMovieDb.fromJson(json.decode(str));

String listMovieDbToJson(ListMovieDb data) => json.encode(data.toJson());

class AllMoviesDB {
  AllMoviesDB({
    this.popularMovies,
    this.ratedMovies,
  });
  ListMovieDb? popularMovies;
  ListMovieDb? ratedMovies;

  factory AllMoviesDB.fromEmty() => AllMoviesDB();
}

class ListMovieDb {
  ListMovieDb({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  factory ListMovieDb.fromJson(Map<String, dynamic> json) => ListMovieDb(
        page: json["page"] ?? 0,
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"] ?? 0,
        totalResults: json["total_results"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "page": page ?? 0,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages ?? 0,
        "total_results": totalResults ?? 0,
      };
}

class Result {
  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "",
        genreIds: json["genre_ids"] == null
            ? null
            : List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"] ?? 0,
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"] ?? "",
        overview: json["overview"] ?? "",
        popularity:
            json["popularity"] == null ? 0.1 : json["popularity"].toDouble(),
        posterPath: json["poster_path"] ?? "",
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        title: json["title"] ?? "",
        video: json["video"] ?? "",
        voteAverage: json["vote_average"] == null
            ? 0.1
            : json["vote_average"].toDouble(),
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult ?? false,
        "backdrop_path": backdropPath ?? "",
        "genre_ids": genreIds == null
            ? null
            : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id ?? 0,
        "original_language": originalLanguage,
        "original_title": originalTitle ?? "",
        "overview": overview ?? "",
        "popularity": popularity ?? 0.1,
        "poster_path": posterPath ?? "",
        "release_date": releaseDate == null
            ? null
            : "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "title": title ?? "",
        "video": video ?? "",
        "vote_average": voteAverage ?? 0.1,
        "vote_count": voteCount ?? 0,
      };
}
