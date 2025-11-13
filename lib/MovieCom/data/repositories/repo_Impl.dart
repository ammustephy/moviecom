import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repository.dart';
import '../datasources/datasources.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getMovies() async {
    final movieModels = await remoteDataSource.getMovies();
    return movieModels.map((model) => model.toEntity()).toList();
  }
}