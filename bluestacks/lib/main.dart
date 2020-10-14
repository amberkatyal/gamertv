import 'package:flutter/material.dart';

import 'app/splash_app.dart';
import 'app/gamertv_app.dart';

void main() {
  // GestureBinding.instance.resamplingEnabled = true;
  runApp(
    SplashApp(
      key: UniqueKey(),
      onInitializationComplete: (route) => runMainApp(route),
    ),
  );
}

void runMainApp(String route) {
  runApp(
    GamerTVApp(route),
  );
}
