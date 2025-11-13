import '../../../domain/entities/entities.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.description,
    required super.director,
    required super.producer,
    required super.releaseDate,
    required super.rtScore,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      director: json['director'] ?? '',
      producer: json['producer'] ?? '',
      releaseDate: int.tryParse(json['release_date'] ?? '0') ?? 0,
      rtScore: int.tryParse(json['rt_score'] ?? '0') ?? 0,
    );
  }

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      description: description,
      director: director,
      producer: producer,
      releaseDate: releaseDate,
      rtScore: rtScore,
    );
  }
}