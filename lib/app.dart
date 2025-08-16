import 'package:bootcamp_flutter_tm06/blocs/auth/auth_bloc.dart';
import 'package:bootcamp_flutter_tm06/blocs/auth/auth_event.dart';
import 'package:bootcamp_flutter_tm06/pages/item_list_page.dart';
import 'package:bootcamp_flutter_tm06/pages/login_page.dart';
import 'package:bootcamp_flutter_tm06/pages/signup_page.dart';
import 'package:bootcamp_flutter_tm06/repositories/auth_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final authRepositories = AuthRepositories();
//     return BlocProvider(
//       create: (context) => Authbloc(),
//       child: MaterialApp(
//         // title: 'Flutter Demo',
//         // theme: ThemeData(

//         // ),
//         home: const ItemListPage(),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authRepositories = AuthRepositories();
    return BlocProvider(
      create: (context) => AuthBloc(authRepositories)..add(AuthStarted()),
      child: MaterialApp(
          title: 'Firebase Auth',
          initialRoute: '/',
          routes: {
            '/': (context) => LoginPage(),
            '/home': (context) => ItemListPage(), //ini yg perlu dicek 'HomePage()'
            '/signup': (context) => SignUpPage(),
          },
        ),
    );
  }
}