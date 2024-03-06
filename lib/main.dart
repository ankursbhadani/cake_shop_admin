import 'package:cake_shop_admin/admin_dashbord.dart';
import 'package:cake_shop_admin/login.dart';
import 'package:cake_shop_admin/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'checkuser.dart';
import 'common.dart';
import 'connection.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider()..checkLoginStatus(),
      child: MaterialApp(
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return authProvider.isLoggedIn ? Dashbord() : Login();
          },
        ),
      ),
    );
  }
}



