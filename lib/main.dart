import 'package:flutter/material.dart';
import 'package:funfix/services/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:funfix/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application. rf
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'FunFix',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: AuthGate(),
    );
  }
}
