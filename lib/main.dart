import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskerist/page/task_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static String title = 'Taskerist with sqflite';

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.black,
        cardTheme: CardTheme(color: Colors.blue.shade50),
        scaffoldBackgroundColor: const Color.fromARGB(255, 113, 139, 152),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const TaskPage(),
    );
  }
}
