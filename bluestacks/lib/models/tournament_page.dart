import 'package:bluestacks/models/tournament.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

class TournamentPage {
  final String cursor;
  final List<Tournament> tournaments;
  final bool isLastBatch;

  TournamentPage(
      {@required this.cursor, this.tournaments, @required this.isLastBatch});

  factory TournamentPage.fromRawJSON(String str) =>
      TournamentPage.fromJSON(json.decode(str));

  factory TournamentPage.fromJSON(Map<String, dynamic> json) => TournamentPage(
        cursor: json['data']['cursor'],
        tournaments: List<Tournament>.from(
          json['data']["tournaments"].map((i) => Tournament.fromJSON(i)),
        ),
        isLastBatch: json['data']['is_last_batch'],
      );
}
