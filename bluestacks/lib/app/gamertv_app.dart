import 'package:bluestacks/coordinator/route_generator.dart';
import 'package:bluestacks/provider/tournament_provider.dart';
import 'package:bluestacks/views/screens/home/home_page.dart';
import 'package:bluestacks/views/widgets/error_widget.dart';
import 'package:bluestacks/views/widgets/loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app_localizations.dart';
// import 'package:flutter/gestures.dart';

class GamerTVApp extends StatelessWidget {
  final String initialRoute;

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  GamerTVApp(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            ErrorMessageWidget(
              errorMessage: 'Something went wrong',
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => TournamentDataProvider(),
                child: HomePage(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: this.initialRoute,
              onGenerateRoute: RouteGenerator.generateRoute,
              supportedLocales: [
                Locale('en', 'US'),
                Locale('ja', 'JP'),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supported in supportedLocales) {
                  if (supported.languageCode == locale.languageCode) {
                    return supported;
                  }
                }
                return supportedLocales.first;
              },
            ),
          );
        });
  }
}
