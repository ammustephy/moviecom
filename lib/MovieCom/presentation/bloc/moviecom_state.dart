import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';


abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final List<Movie> filteredMovies;
  final String searchQuery;

  const MovieLoaded({
    required this.movies,
    required this.filteredMovies,
    this.searchQuery = '',
  });

  @override
  List<Object> get props => [movies, filteredMovies, searchQuery];

  MovieLoaded copyWith({
    List<Movie>? movies,
    List<Movie>? filteredMovies,
    String? searchQuery,
  }) {
    return MovieLoaded(
      movies: movies ?? this.movies,
      filteredMovies: filteredMovies ?? this.filteredMovies,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}