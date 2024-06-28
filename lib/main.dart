import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prioritysoft_shoesly/firebase_options.dart';
import 'package:prioritysoft_shoesly/products/product_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Shoesly',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.lailaTextTheme(textTheme).copyWith(
          titleLarge: GoogleFonts.nunito(textStyle: textTheme.titleLarge),
          titleMedium: GoogleFonts.nunito(textStyle: textTheme.titleMedium),
          titleSmall: GoogleFonts.nunito(textStyle: textTheme.titleSmall),
          displayLarge: GoogleFonts.nunito(textStyle: textTheme.displayLarge),
          displayMedium: GoogleFonts.nunito(textStyle: textTheme.displayMedium),
          displaySmall: GoogleFonts.nunito(textStyle: textTheme.displaySmall),
        ),
      ),
      home: ProductListPage(),
    );
  }
}
