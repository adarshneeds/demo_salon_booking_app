import 'package:demo_app/config/app_theme.dart';
import 'package:demo_app/firebase_options.dart';
import 'package:demo_app/provider/home_provider.dart';
import 'package:demo_app/views/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: ChangeNotifierProvider(
        create: (context) => HomeProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Salon Booking App",
          theme: AppTheme.lightTheme,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
