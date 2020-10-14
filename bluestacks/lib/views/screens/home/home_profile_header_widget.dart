import 'dart:ui';

import 'package:bluestacks/view_models/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_segment_item_widget.dart';

class HomeProfileHeaderWidget extends StatelessWidget {
  final QueryDocumentSnapshot document;

  const HomeProfileHeaderWidget({
    Key key,
    this.document,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(document.data()['image_url']),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Text(
                      document.data()['name'],
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 8, 20, 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue[700],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          document.data()['elo_rating'],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.blue[700]),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Elo rating',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                HomeSegmentItemWidget(
                    gradients: [
                      Colors.orangeAccent[700],
                      Colors.orangeAccent,
                    ],
                    segmentType: HomeSegmentType.TournamentPlayed,
                    segmentValue: document.data()['tournaments_played'],
                    segmentTitle: 'Tournaments\nplayed'),
                SizedBox(
                  width: 1,
                ),
                HomeSegmentItemWidget(
                    gradients: [
                      Colors.purple[900],
                      Colors.purple[300],
                    ],
                    segmentType: HomeSegmentType.TournamentWon,
                    segmentTitle: 'Tournaments\nwon',
                    segmentValue: document.data()['tournaments_won']),
                SizedBox(
                  width: 1,
                ),
                HomeSegmentItemWidget(
                    gradients: [
                      Colors.deepOrange,
                      Colors.deepOrange[300],
                    ],
                    segmentType: HomeSegmentType.WinningPercentage,
                    segmentTitle: 'Winning\npercentage',
                    segmentValue: document.data()['winning_percentage']),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Recommended for you',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
