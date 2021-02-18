// Our movie model
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
class Section {
  final String title, api1, api2;

  final IconData icon;

  Section({
    this.title,
    this.icon,
    this.api1,
    this.api2,
  });
}

List<Section> sectionList = [
  Section(
    title: 'All Geners',
    icon: Icons.category,
    api1:
        "https://api.themoviedb.org/3/genre/movie/list?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US",
    api2:
        "https://api.themoviedb.org/3/genre/movie/list?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US",
  ),
  Section(
    title: 'Top Rated',
    icon: Icons.stars,
    api1:
        "https://api.themoviedb.org/3/movie/top_rated?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1",
    api2:
        "https://api.themoviedb.org/3/movie/top_rated?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=3",
  ),
  Section(
    title: 'Popular',
    icon: Icons.label_important,
    api1:
        "https://api.themoviedb.org/3/movie/popular?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1",
    api2:
        "https://api.themoviedb.org/3/movie/popular?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=2",
  ),
  Section(
    title: 'Week Trend',
    icon: Icons.whatshot,
    api1:
        "https://api.themoviedb.org/3/trending/all/week?api_key=5748c9cc927b2d946e4d0c007bb63972",
    api2:
        "https://api.themoviedb.org/3/trending/movie/week?api_key=5748c9cc927b2d946e4d0c007bb63972",
  ),
  Section(
    title: 'Day Trend',
    icon: Icons.assistant_photo,
    api1:
        "https://api.themoviedb.org/3/trending/movie/day?api_key=5748c9cc927b2d946e4d0c007bb63972",
    api2:
        "https://api.themoviedb.org/3/trending/all/day?api_key=5748c9cc927b2d946e4d0c007bb63972",
  ),
  Section(
    title: 'Popular People',
    icon: Icons.people,
    api1:
        "https://api.themoviedb.org/3/person/popular?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1",
    api2:
        "https://api.themoviedb.org/3/person/popular?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=2",
  ),
  Section(
    title: 'Now Playing',
    icon: Icons.play_circle_filled,
    api1:
        "https://api.themoviedb.org/3/movie/now_playing?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1",
    api2:
        "https://api.themoviedb.org/3/movie/now_playing?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=2",
  ),
  Section(
    title: 'Upcoming',
    icon: Icons.alarm_on,
    api1:
        "https://api.themoviedb.org/3/movie/upcoming?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1",
    api2:
        "https://api.themoviedb.org/3/movie/upcoming?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=2",
  ),
];

class Movie {
  Movie({
    @required this.id,
    @required this.title,
    @required this.img,
    @required this.desc,
  });

  final int id;
  final String title, img, desc;

  factory Movie.fromJson(Map<String, dynamic> jsonData) {
    return Movie(
        id: jsonData['id'],
        title: jsonData['title'],
        img: jsonData['poster_path'],
        desc: jsonData['overview']
    );
  }
}

class Movies with ChangeNotifier{
  List<dynamic> moviesList=[];

    Movies({this.moviesList});

  factory Movies.fromJson(Map<String, dynamic> jsonData) {
    return Movies(
      moviesList: jsonData['result'],
    );
  }
  fetchAllMovies() async {
    try {
      var url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        //Movies movies = Movies.fromJson(extractedData);
        moviesList = Movies.fromJson(extractedData).moviesList.map((e) => Movie.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}