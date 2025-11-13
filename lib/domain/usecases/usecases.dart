import '../entities/entities.dart';
import '../repositories/repository.dart';

class GetMoviesUseCase {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getMovies();
  }
}