import 'dart:convert';

import 'package:book_app_flutter/models/book_detail_response.dart';
import 'package:book_app_flutter/models/book_list_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookProvider extends ChangeNotifier {
  BookListResponse? bookList;
  BookDetailResponse? detailBook;
  BookListResponse? similarBooks;

  fetchBookApi() async {
    var url = Uri.https('api.itbook.store', '1.0/new');
    var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookList = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }
  }

  fetchDetailBookApi(isbn) async {
    var url = Uri.https('api.itbook.store', '/1.0/books/$isbn');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      notifyListeners();
      fetchSimilarBookApi(detailBook!.title!);
    }
  }

  fetchSimilarBookApi(String title) async {
    var url = Uri.https('api.itbook.store', '/1.0/search/$title');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similarBooks = BookListResponse.fromJson(jsonDetail);
      notifyListeners();
    }
  }

}