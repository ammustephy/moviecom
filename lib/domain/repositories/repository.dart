import '../entities/entities.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies();
}