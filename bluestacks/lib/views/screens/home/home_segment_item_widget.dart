import 'package:bluestacks/view_models/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeSegmentItemWidget extends StatelessWidget {
  const HomeSegmentItemWidget({
    Key key,
    @required this.gradients,
    @required this.segmentType,
    @required this.segmentTitle,
    @required this.segmentValue,
  }) : super(key: key);

  final List<Color> gradients;
  final HomeSegmentType segmentType;
  final String segmentValue;
  final String segmentTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: buildBorderRadius(),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: this.gradients,
          ),
        ),
        child: Column(
          children: [
            buildSegmentValueText(),
            SizedBox(
              height: 2,
            ),
            buildSegmentTitleText(),
          ],
        ),
      ),
    );
  }

  Text buildSegmentTitleText() {
    return Text(
      this.segmentTitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Text buildSegmentValueText() {
    return Text(
      this.segmentValue,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  BorderRadius buildBorderRadius() {
    BorderRadius borderRadius;
    switch (this.segmentType) {
      case HomeSegmentType.TournamentPlayed:
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        );
        break;
      case HomeSegmentType.WinningPercentage:
        borderRadius = BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        );
        break;
      default:
        borderRadius = BorderRadius.zero;
    }
    return borderRadius;
  }
}
