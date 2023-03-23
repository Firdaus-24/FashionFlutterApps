class Movie {
  final dynamic image;
  final dynamic title;
  final dynamic country;
  final dynamic network;

  const Movie({
    required this.image,
    required this.title,
    required this.country,
    required this.network,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      image: json['image_thumbnail_path'],
      title: json['name'],
      country: json['country'],
      network: json['network'],
    );
  }
}
