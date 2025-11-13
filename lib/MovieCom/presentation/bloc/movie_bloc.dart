import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/usecases.dart';
import 'moviecom_event.dart';
import 'moviecom_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesUseCase getMoviesUseCase;

  MovieBloc(this.getMoviesUseCase) : super(MovieInitial()) {
    on<LoadMoviesEvent>(_onLoadMovies);
    on<SearchMoviesEvent>(_onSearchMovies);
  }

  Future<void> _onLoadMovies(
      LoadMoviesEvent event,
      Emitter<MovieState> emit,
      ) async {
    emit(MovieLoading());
    try {
      final movies = await getMoviesUseCase();
      emit(MovieLoaded(movies: movies, filteredMovies: movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  void _onSearchMovies(
      SearchMoviesEvent event,
      Emitter<MovieState> emit,
      ) {
    if (state is MovieLoaded) {
      final currentState = state as MovieLoaded;
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        emit(currentState.copyWith(
          filteredMovies: currentState.movies,
          searchQuery: '',
        ));
      } else {
        final filtered = currentState.movies.where((movie) {
          return movie.title.toLowerCase().contains(query);
        }).toList();

        emit(currentState.copyWith(
          filteredMovies: filtered,
          searchQuery: query,
        ));
      }
    }
  }
}