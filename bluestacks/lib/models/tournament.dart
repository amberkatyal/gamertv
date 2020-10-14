class Tournament {
  final String name;
  final String coverURL;
  final String gameName;

  Tournament({this.name, this.coverURL, this.gameName});

  factory Tournament.fromJSON(Map<String, dynamic> json) => Tournament(
      name: json["name"],
      coverURL: json["cover_url"],
      gameName: json["game_name"]);
}
