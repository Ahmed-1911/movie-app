import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/models/movie.dart';
class MyProvider {
  fetchAllMovies() async {
    try {
      var url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        Movies movies = Movies.fromJson(extractedData);
        List<Movie> MList = movies.moviesList.map((e) => Movie.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
