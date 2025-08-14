import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_yessica_5simia1/provider/order_providers.dart';
import 'package:uts_yessica_5simia1/screen/menu_page.dart';
import 'package:uts_yessica_5simia1/screen/order_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderProvider(),
      child: MaterialApp(
        title: 'Aplikasi Pemesanan',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) =>  MenuScreen(),
          '/orders': (context) =>  OrderScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}