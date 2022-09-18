import 'package:book_app_flutter/providers/book_provider.dart';
import 'package:book_app_flutter/views/book_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookProvider(),
      child: MaterialApp(
        title: 'Book Catalogue',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const BookListPage(),
      ),
    );
  }
}