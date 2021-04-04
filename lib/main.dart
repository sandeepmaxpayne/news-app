import 'package:flutter/material.dart';
import 'package:news_app/News.dart';
import 'package:news_app/network.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<News> news = [];
  static List<News> newsInApp = [];

  @override
  void initState() {
    comingNews().then((value) {
      setState(() {
        news.addAll(value);
        newsInApp = news;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(97),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.white))),
              child: AppBar(
                title: Text(
                  'News',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return _listItem(index);
        },
        itemCount: newsInApp.length,
      ),
    );
  }

  _listItem(index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 1, right: 1, bottom: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      newsInApp[index].title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: IconButton(
                          iconSize: 16,
                          color: Colors.black26,
                          alignment: Alignment.bottomCenter,
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return new MaterialApp(
                              debugShowCheckedModeBanner: false,
                              home: Scaffold(
                                appBar: AppBar(
                                  centerTitle: true,
                                  backgroundColor: Colors.white,
                                  leading: IconButton(
                                    iconSize: 20,
                                    color: Colors.blue,
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  title: Text(
                                    newsInApp[index].title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                body: SingleChildScrollView(
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Container(
                                        height: 220,
                                        width: 400,
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Image.network(
                                          newsInApp[index].image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ListTile(
                                        title: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                newsInApp[index].title,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              Text(
                                                newsInApp[index].publisher,
                                                style: TextStyle(
                                                    color: Colors.black26),
                                              ),
                                              SizedBox(
                                                height: 12.0,
                                              ),
                                              Text(
                                                newsInApp[index].text,
                                                textAlign: TextAlign.justify,
                                                style:
                                                    TextStyle(wordSpacing: 2),
                                              ),
                                              SizedBox(
                                                height: 12.0,
                                              ),
                                              Text(
                                                  "Author: ${newsInApp[index].author}"),
                                              SizedBox(
                                                height: 12.0,
                                              ),
                                              Text(
                                                  'Date: ${newsInApp[index].date}'),
                                              SizedBox(
                                                height: 5.0,
                                              ), 
                                              Text('Full story at:'),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              InkWell(
                                                child: Text(
                                                  newsInApp[index].url,
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                onTap: () async => await canLaunch(
                                                        newsInApp[index].url)
                                                    ? await launch(
                                                        newsInApp[index].url)
                                                    : throw 'cannot launch ${newsInApp[index].url}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                                ),
                              ),
                            );
                          })),
                        )))
              ],
            ),
            Text(
              newsInApp[index].publisher,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Divider(
                color: Colors.black12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
