import 'package:book_app_flutter/providers/book_provider.dart';
import 'package:book_app_flutter/views/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookProvider? bookProvider;

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  @override
  initState() {
    super.initState();
    bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider!.fetchDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Consumer<BookProvider>(builder: (context, provider, child) {
        return bookProvider!.detailBook == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ImageViewScreen(
                                      imageUrl:
                                          bookProvider!.detailBook!.image!)));
                            },
                            child: Image.network(
                              bookProvider!.detailBook!.image!,
                              height: 150,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bookProvider!.detailBook!.title!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    bookProvider!.detailBook!.authors!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => Icon(
                                        Icons.star,
                                        color: index <
                                                int.parse(bookProvider!
                                                    .detailBook!.rating!)
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    bookProvider!.detailBook!.subtitle!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    bookProvider!.detailBook!.price!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              _launchUrl(
                                  Uri.parse(bookProvider!.detailBook!.url!));
                            },
                            child: const Text('BUY')),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(bookProvider!.detailBook!.desc!),
                      const Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: const Text(
                                  'Year',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(bookProvider!.detailBook!.year!),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: const Text(
                                  'ISBN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(bookProvider!.detailBook!.isbn13!),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: const Text(
                                  'Total Pages',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(bookProvider!.detailBook!.pages!),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: const Text(
                                  'Publisher',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(bookProvider!.detailBook!.publisher!),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: const Text(
                                  'Language',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(bookProvider!.detailBook!.language!),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Text(
                            'Similar Books',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      bookProvider!.similarBooks == null
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    bookProvider!.similarBooks!.books!.length,
                                itemBuilder: (context, index) {
                                  final current =
                                      bookProvider!.similarBooks!.books![index];
                                  return SizedBox(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => ImageViewScreen(
                                                    imageUrl: current.image!)));
                                          },
                                          child: Image.network(
                                            current.image!,
                                            height: 100,
                                          ),
                                        ),
                                        Text(
                                          current.title!,
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
            );
      }),
    );
  }
}
