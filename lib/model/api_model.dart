class Amiibo {
  final String name;
  final String image;
  final String gameSeries;

  Amiibo({required this.name, required this.image, required this.gameSeries});

  factory Amiibo.fromJson(Map<String, dynamic> json) {
    return Amiibo(
      name: json['name'],
      image: json['image'],
      gameSeries: json['gameSeries'],
    );
  }
}
