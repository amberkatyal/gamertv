import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String rating;
  final int tournamentsPlayed;
  final int tournamentsWon;
  final double winningPercentage;

  User(
      {@required this.id,
      this.name,
      this.rating,
      this.tournamentsPlayed,
      this.tournamentsWon,
      this.winningPercentage});

  factory User.fromJSON(Map<String, dynamic> json) => User(
      id: json["id"],
      rating: json["elo_rating"],
      tournamentsPlayed: json["stats"]["played"],
      tournamentsWon: json["stats"]["won"],
      winningPercentage: json["stats"]["win_percent"]);
}
