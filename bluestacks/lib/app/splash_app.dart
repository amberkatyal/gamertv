import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashApp extends StatefulWidget {
  final Function(String route) onInitializationComplete;

  const SplashApp({
    Key key,
    @required this.onInitializationComplete,
  }) : super(key: key);

  @override
  _SplashAppState createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp> {
  @override
  void initState() {
    super.initState();
    fakeLoadingAndSuccess();
  }

  Future<void> fakeLoadingAndSuccess() async {
    final storage = FlutterSecureStorage();
    var isLoggedIn = await storage.read(key: 'isLoggedIn');
    widget.onInitializationComplete((isLoggedIn != null) ? '/' : 'login');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      home: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'lib/resources/images/gametv.png',
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
