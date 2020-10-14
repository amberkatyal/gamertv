import 'package:bluestacks/models/tournament_page.dart';
import 'package:bluestacks/services/result.dart';

import 'web_service.dart';

class TournamentsWebService extends WebService {
  Future<Result> getTournaments(
      {String cursor, String batchSize = '10'}) async {
    try {
      var route =
          'tournament/api/tournaments_list_v2?limit=$batchSize&status=all';
      if ((cursor != null) || (cursor.isNotEmpty)) {
        route += '&cursor=$cursor';
      }
      final response = await super.request(HTTPMethod.GET, route);
      if (response.statusCode == 200) {
        return Result<TournamentPage>.success(
            TournamentPage.fromRawJSON(response.body));
      } else {
        return Result.error('Tournaments Not Available');
      }
    } catch (error) {
      return Result.error('Something went wrong.');
    }
  }
}
