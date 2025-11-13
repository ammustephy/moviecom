import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://ghibliapi.vercel.app/films';

  MovieRemoteDataSourceImpl(this.client);

  @override
  Future<List<MovieModel>> getMovies() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}