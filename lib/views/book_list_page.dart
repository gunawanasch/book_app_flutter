import 'package:book_app_flutter/providers/book_provider.dart';
import 'package:book_app_flutter/views/detail_book_page.dart';
import 'package:book_app_flutter/views/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookProvider? bookProvider;

  @override
  void initState() {
    super.initState();
    bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Catalogue'),
      ),
      body: Consumer<BookProvider>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, provider, child) => Container(
          child: bookProvider!.bookList == null
              ? child
              : ListView.builder(
                itemCount: bookProvider!.bookList!.books!.length,
                itemBuilder: (context, index) {
                  final currentBook = bookProvider!.bookList!.books![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailBookPage(isbn: currentBook.isbn13!)
                      ));
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ImageViewScreen(
                                          imageUrl: currentBook.image!)
                              ));
                            },
                            child: Image.network(currentBook.image!,
                              height: 100,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12),
                                  Text(
                                    currentBook.title!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    currentBook.subtitle!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      currentBook.price!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
          ),
        ),
      ),
    );
  }
}
