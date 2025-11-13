import 'package:get_it/get_it.dart';

import '../../MovieCom/data/datasources/datasources.dart';
import '../../MovieCom/data/repositories/repo_Impl.dart';
import '../../MovieCom/presentation/bloc/movie_bloc.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/usecases/usecases.dart';
import 'package:http/http.dart' as http;


final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<MovieRemoteDataSource>(
        () => MovieRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetMoviesUseCase(sl()));

  sl.registerFactory(() => MovieBloc(sl()));
}