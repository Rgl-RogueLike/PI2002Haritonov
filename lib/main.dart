import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:html/parser.dart';

Future<List<News>> fetchNews(http.Client client) async {
  final response = await client.get(Uri.parse('https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90'));
  Bidi.stripHtmlIfNeeded(response.body);
  String html = parse(response.body).body!.text;
  return compute(parseNews, html);
}

List<News> parseNews(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<News>((json) => News.fromJson(json)).toList();
}

class News {
  final String date;
  final String title;
  final String previewText;
  final String image;

  const News({
    required this.date,
    required this.title,
    required this.previewText,
    required this.image,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      date: json['ACTIVE_FROM'] as String,
      title: json['TITLE'] as String,
      previewText: json['PREVIEW_TEXT'] as String,
      image: json['PREVIEW_PICTURE_SRC'] as String,
    );
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Новоcти КубГау';

    return  const MaterialApp(
      title: appTitle,
      home:MyHomePage(title: appTitle)
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.news}): super(key: key);

  final List<News> news;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding:  const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            Image.network(news[index].image),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${news[index].date}',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${news[index].title}',
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${news[index].previewText}',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<News>>(
        future: fetchNews(http.Client()),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const Center(
              child: Text('Ошибка запроса!'),
            );
          } else if (snapshot.hasData) {
            return NewsList(news: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = 
        (X509Certificate cert, String host, int port) => true;
  }
}