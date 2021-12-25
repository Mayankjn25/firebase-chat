import 'package:firebase_chat/models/user_data.dart';
import 'package:firebase_chat/screens/home_screen.dart';
import 'package:firebase_chat/screens/login_screen.dart';
import 'package:firebase_chat/services/auth_service.dart';
import 'package:firebase_chat/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserData(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<StorageService>(
          create: (_) => StorageService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Chat',
      theme: ThemeData(primaryColor: Colors.white),
      home: StreamBuilder<auth.User?>(
        stream: Provider.of<AuthService>(
          context,
        ).user,
        builder: (context, AsyncSnapshot<auth.User?> snapshot) {
          if (snapshot.hasData || snapshot.data?.uid != null) {
            Provider.of<UserData>(context, listen: false).currentUserId =
                snapshot.data?.uid;
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
