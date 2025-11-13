class Movie {
  final String id;
  final String title;
  final String description;
  final String director;
  final String producer;
  final int releaseDate;
  final int rtScore;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.rtScore,
  });
}