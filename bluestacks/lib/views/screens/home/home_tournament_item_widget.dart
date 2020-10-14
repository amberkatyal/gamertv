import 'package:bluestacks/models/tournament.dart';
import 'package:flutter/material.dart';

class HomeTournamentItemWidget extends StatelessWidget {
  const HomeTournamentItemWidget(
      {Key key, @required this.tournaments, @required this.index})
      : super(key: key);

  final List<Tournament> tournaments;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        child: Column(children: [
          Container(
            height: 128,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(tournaments[index - 1].coverURL),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tournaments[index - 1].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        tournaments[index - 1].gameName,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
