import 'package:bluestacks/models/tournament.dart';
import 'package:bluestacks/provider/tournament_provider.dart';
import 'package:bluestacks/views/widgets/loader.dart';
import 'package:bluestacks/views/widgets/error_widget.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bluestacks/services/result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'home_profile_header_widget.dart';
import 'home_tournament_item_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    var tournamentsProvider =
        Provider.of<TournamentDataProvider>(context, listen: false);
    tournamentsProvider.initStreams();
    tournamentsProvider.fetchTournamentPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        tournamentsProvider.setLoadMoreState(LoadingState(''));
        tournamentsProvider.fetchTournamentPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "FlyingWolf",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey[300],
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                final storage = FlutterSecureStorage();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('login', (_) => false);
                storage.delete(key: 'isLoggedIn');
              },
            ),
          ],
        ),
      ),
      body:
          Consumer<TournamentDataProvider>(builder: (context, provider, child) {
        if (provider.tournaments.isNotEmpty) {
          List<Tournament> tournaments = provider.tournaments;
          return buildListView(provider, tournaments);
        } else if (provider.currentState is ErrorState) {
          String errorMessage = (provider.currentState as ErrorState).msg;
          return ErrorMessageWidget(errorMessage: errorMessage);
        } else {
          return Loader();
        }
      }),
    );
  }

  ListView buildListView(
      TournamentDataProvider provider, List<Tournament> tournaments) {
    return ListView.separated(
      controller: _scrollController,
      physics: AlwaysScrollableScrollPhysics(),
      separatorBuilder: (ctx, idx) => SizedBox(
        height: 20,
      ),
      padding: EdgeInsets.fromLTRB(18, 0, 18, 44),
      itemCount: tournaments.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return Loader();
                }
                if (snapshot.hasError) {
                  return ErrorMessageWidget(
                    errorMessage: 'Something went wrong',
                  );
                }
                return HomeProfileHeaderWidget(
                  document: snapshot.data.docs[0],
                );
              });
        }
        if (index == tournaments.length) {
          if (provider.currentState is ErrorState) {
            String errorMessage = (provider.currentState as ErrorState).msg;
            return ErrorMessageWidget(errorMessage: errorMessage);
          } else if (provider.currentState is LoadingState) {
            return Loader();
          }
        }

        return HomeTournamentItemWidget(tournaments: tournaments, index: index);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
