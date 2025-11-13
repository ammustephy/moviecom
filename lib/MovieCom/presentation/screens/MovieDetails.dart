import 'package:flutter/material.dart';

import '../../../domain/entities/entities.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: isPortrait
                ? screenSize.height * 0.25
                : screenSize.height * 0.4,
            pinned: true,
            backgroundColor: const Color(0xFF1A237E),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: TextStyle(
                  fontSize: screenSize.width * 0.040,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF1A237E),
                      const Color(0xFF1A237E).withOpacity(0.5),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset("Assets/Images/movieIcon.png", color: Colors.white,),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildScoreCard(screenSize),
                  SizedBox(height: screenSize.height * 0.025),
                  _buildInfoRow(
                    'Director',
                    movie.director,
                    Icons.person,
                    screenSize,
                  ),
                  SizedBox(height: screenSize.height * 0.015),
                  _buildInfoRow(
                    'Producer',
                    movie.producer,
                    Icons.movie_creation,
                    screenSize,
                  ),
                  SizedBox(height: screenSize.height * 0.015),
                  _buildInfoRow(
                    'Release Year',
                    movie.releaseDate.toString(),
                    Icons.calendar_today,
                    screenSize,
                  ),
                  SizedBox(height: screenSize.height * 0.025),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: screenSize.width * 0.055,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.015),
                  Text(
                    movie.description,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.04,
                      height: 1.6,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(Size screenSize) {
    return Container(
      padding: EdgeInsets.all(screenSize.width * 0.05),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[700]!, Colors.amber[500]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            size: screenSize.width * 0.12,
            color: Colors.white,
          ),
          SizedBox(width: screenSize.width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${movie.rtScore}%',
                style: TextStyle(
                  fontSize: screenSize.width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Rotten Tomatoes Score',
                style: TextStyle(
                  fontSize: screenSize.width * 0.035,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      String label,
      String value,
      IconData icon,
      Size screenSize,
      ) {
    return Container(
      padding: EdgeInsets.all(screenSize.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF1A237E),
            size: screenSize.width * 0.06,
          ),
          SizedBox(width: screenSize.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.005),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}