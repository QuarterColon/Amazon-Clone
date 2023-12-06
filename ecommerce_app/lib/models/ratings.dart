// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ratings {
  final String userId;
  final double rating;

  Ratings({
    required this.userId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'rating': rating,
    };
  }

  factory Ratings.fromMap(Map<String, dynamic> map) {
    return Ratings(
      userId: map['userId'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ratings.fromJson(String source) =>
      Ratings.fromMap(json.decode(source) as Map<String, dynamic>);
}
