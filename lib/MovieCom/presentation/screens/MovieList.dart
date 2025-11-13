import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../domain/entities/entities.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/moviecom_event.dart';
import '../bloc/moviecom_state.dart';
import 'MovieDetails.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieBloc>()..add(LoadMoviesEvent()),
      child: const MovieListView(),
    );
  }
}

class MovieListView extends StatelessWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("Assets/Images/movieIcon.png", height: 25,width: 25,color: Colors.white,),
            SizedBox(width: 5,),
            const Text('MovieCom'),
          ],
        ),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(context, screenSize, isPortrait),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieLoaded) {
                  if (state.filteredMovies.isEmpty) {
                    return Center(
                      child: Text(
                        'No movies found',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.045,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return _buildMovieList(
                    context,
                    state.filteredMovies,
                    screenSize,
                    orientation,
                  );
                } else if (state is MovieError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: screenSize.width * 0.15,
                            color: Colors.red,
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          Text(
                            'Error loading movies',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenSize.width * 0.04,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          ElevatedButton(
                            onPressed: () {
                              context.read<MovieBloc>().add(LoadMoviesEvent());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSearchBar(
      BuildContext context,
      Size screenSize,
      bool isPortrait,
      ) {
    return Container(
      padding: EdgeInsets.all(screenSize.width * 0.04),
      color: Colors.grey[100],
      child: TextField(
        onChanged: (query) {
          context.read<MovieBloc>().add(SearchMoviesEvent(query));
        },
        decoration: InputDecoration(
          hintText: 'Search movies...',
          hintStyle: TextStyle(fontSize: screenSize.width * 0.04),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
            vertical: screenSize.height * 0.015,
          ),
        ),
      ),
    );
  }

  Widget _buildMovieList(
      BuildContext context,
      List<Movie> movies,
      Size screenSize,
      Orientation orientation,
      ) {
    final isPortrait = orientation == Orientation.portrait;
    final crossAxisCount = isPortrait ? 2 : 3;

    return GridView.builder(
      padding: EdgeInsets.all(screenSize.width * 0.04),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: isPortrait ? 0.7 : 0.75,
        crossAxisSpacing: screenSize.width * 0.03,
        mainAxisSpacing: screenSize.height * 0.02,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _buildMovieCard(context, movie, screenSize, isPortrait);
      },
    );
  }

  Widget _buildMovieCard(
      BuildContext context,
      Movie movie,
      Size screenSize,
      bool isPortrait,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MovieDetailScreen(movie: movie),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1A237E),
                          const Color(0xFF3949AB),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child:
                      Icon(
                        Icons.movie_filter_outlined,
                        size: constraints.maxWidth * 0.3,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(constraints.maxWidth * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            movie.title,
                            style: TextStyle(
                              fontSize: constraints.maxWidth * 0.09,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.01),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              movie.director,
                              style: TextStyle(
                                fontSize: constraints.maxWidth * 0.075,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: constraints.maxHeight * 0.008),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  movie.releaseDate.toString(),
                                  style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.07,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: constraints.maxWidth * 0.1,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(width: constraints.maxWidth * 0.02),
                                    Text(
                                      '${movie.rtScore}%',
                                      style: TextStyle(
                                        fontSize: constraints.maxWidth * 0.08,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}