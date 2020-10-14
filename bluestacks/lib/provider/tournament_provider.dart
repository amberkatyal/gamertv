import 'package:bluestacks/models/tournament.dart';
import 'package:bluestacks/models/tournament_page.dart';
import 'package:bluestacks/services/result.dart';
import 'package:bluestacks/services/tournament_web_service.dart';
import 'package:flutter/material.dart';

enum LoadMoreStatus { Loading, Stable }

class TournamentDataProvider with ChangeNotifier {
  TournamentsWebService _tournamentWebService;

  String cursor = '';
  bool isLastPageLoaded;
  List<Tournament> _tournaments;
  Result<dynamic> _currentState = SuccessState([]);

  List<Tournament> get tournaments => _tournaments;
  Result<dynamic> get currentState => _currentState;

  TournamentDataProvider() {
    initStreams();
  }

  initStreams() {
    _tournamentWebService = TournamentsWebService();
    _tournaments = [];
    isLastPageLoaded = false;
  }

  fetchTournamentPage() async {
    if ((_tournaments.isEmpty) || !isLastPageLoaded) {
      Result<dynamic> result =
          await _tournamentWebService.getTournaments(cursor: this.cursor);
      print(result);
      if (result is SuccessState) {
        TournamentPage page = result.value;
        this.cursor = page.cursor;
        this.isLastPageLoaded = page.isLastBatch;
        this.tournaments.addAll(page.tournaments);
      }
      this.setLoadMoreState(result);
    } else {
      this.setLoadMoreState(SuccessState([]));
    }
  }

  setLoadMoreState(Result<dynamic> status) {
    this._currentState = status;
    notifyListeners();
  }
}
