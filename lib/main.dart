import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:discount_box/ui/favorite_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neon/neon.dart';
import 'custom_widgets/gradient_app_bar.dart';
import 'custom_widgets/slider_widget_class.dart';
import 'rest_apis/all_media_response.dart';
import 'rest_apis/media_response.dart';
import 'rest_apis/product_response.dart';
import 'ui/search_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discount Box',
      theme: ThemeData(
          primaryColor: new MaterialColor(
        mPrimaryColor,
        <int, Color>{
          50: Color(0xff9708cc),
          100: Color(0xff9708cc),
          200: Color(0xff9708cc),
          300: Color(0xff9708cc),
          400: Color(0xff9708cc),
          500: Color(mPrimaryColor),
          600: Color(0xff9708cc),
          700: Color(0xff9708cc),
          800: Color(0xff9708cc),
          900: Color(0xff9708cc),
        },
      )),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Discount Box'), //Notification_Screen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  Future<ProductResponse> futureProducts;
  Future<AllMediaResponse> allMediaResponse;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchAlbum();
    allMediaResponse = fetchAllMedia();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget getBuilder(var snapshot) {
    return Row(
      children: [
        FutureBuilder<media_response>(
            future: fetchMedia(
                snapshot.data.productList.elementAt(1).featuredMedia),
            builder: (context, snapshoter) {
              if (snapshoter.hasData) {
                return Image.network(snapshoter.data.guid.rendered,
                    width: 50, height: 50);
              } else if (snapshot.hasError) return Container();
              return CircularProgressIndicator();
            }),
        Text(snapshot.data.productList.elementAt(1).title.rendered)
      ],
    );
  }

  Widget listRow(var snapshot, int index) {
    return Row(
      children: [
        snapshot.data.productList.elementAt(index).featuredMedia != 0
            ? FutureBuilder<media_response>(
                future: fetchMedia(
                    snapshot.data.productList.elementAt(index).featuredMedia),
                builder: (context, snapshoter) {
                  if (snapshoter.hasData) {
                    return Image.network(snapshoter.data.guid.rendered,
                        width: 50, height: 50);
                  } else if (snapshot.hasError) return Container();
                  return CircularProgressIndicator();
                })
            : Icon(
                Icons.shop,
                size: 50,
              ),
        Text(snapshot.data.productList.elementAt(index).title.rendered)
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget makeItemRow(var snapshot, int index) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        height: 170,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: cardBorderColor, width: 1)),
        child: makeListItem(snapshot, index),
      ),
    );
  }

  /*
  * GradientText('Discount' , gradient: LinearGradient(
                    colors: [
                      Color(0XFFe8c3fd),
                      Color(0XFF86c5fc),
                    ]
                  ),)*/

  Widget makeListItem(var snapshot, int index) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: Row(
        children: [
          /*Image Logo*/
          Expanded(
            flex: 1,
            child: snapshot.data.productList.elementAt(index).featuredMedia != 0
                ? Center(
                    child: FutureBuilder<media_response>(
                        future: fetchMedia(snapshot.data.productList
                            .elementAt(index)
                            .featuredMedia),
                        builder: (context, snapshoter) {
                          if (snapshoter.hasData) {
                            return Image.network(snapshoter.data.guid.rendered,
                                width: 50, height: 50);
                          } else if (snapshot.hasError) return Container();
                          return CircularProgressIndicator();
                        }),
                  )
                : Icon(
                    Icons.shop,
                    size: 50,
                  ),
          ),
          /*Divider*/
          SizedBox(
            width: 2,
            child: Container(
              color: Colors.grey[300],
            ),
            height: MediaQuery.of(context).size.height * .1,
          ),
          SizedBox(
            width: 5,
          ),
          /*Details*/
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                      snapshot.data.productList.elementAt(index).title.rendered,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: bottomBarBackgroundEndColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Neon(
                      text: snapshot.data.productList
                          .elementAt(index)
                          .content
                          .rendered
                          .toString()
                          .replaceAll("<p>", "")
                          .replaceAll("</p>", ""),
                      color: Colors.purple,
                      fontSize: 15,
                      font: NeonFont.Beon,
                      blurRadius: 0.6,
                      glowing: true,
                      flickeringText: true,
                    )),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '9 Dec 21 - 9 Jan 21',
                    style: TextStyle(
                        color: bottomBarBackgroundEndColor, fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    'Days Remaining:',
                    style: TextStyle(
                        color: bottomBarBackgroundEndColor, fontSize: 12),
                  ),
                ),
                Container(
                  child: SliderWidget(
                    sliderHeight: 30,
                    min: 100,
                    max: 0,
                    fullWidth: true,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Icon(Icons.label_important, color: sliderStartColor, size: 15,),
                    Expanded(
                      child: new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text(
                          snapshot.data.productList
                              .elementAt(index)
                              .excerpt
                              .rendered
                              .toString()
                              .replaceAll("<p>", "")
                              .replaceAll("</p>", ""),
                          style: TextStyle(color: bottomBarBackgroundEndColor),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _mainBodyView() {
    return RefreshIndicator(
      onRefresh: fetchAlbum,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          header(),
          SizedBox(
            height: 10,
          ),
          Container(
            child: FutureBuilder<ProductResponse>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.productList.length,
                        itemBuilder: (context, index) {
                          print('print:comming');
                          return makeItemRow(snapshot, index);
                        }),
                  );
                } else if (snapshot.hasError) return Container();
                return CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget mainBodyBuilder() {
    switch (_selectedIndex) {
      case 0:
        return Search_Screen();
        break;
      case 1:
        return _mainBodyView();
        break;
      case 2:
        return Favorite_Screen();
        break;
      default:
        return _mainBodyView();
        break;
    }
  }

  Widget header() {
    return FutureBuilder<AllMediaResponse>(
      future: allMediaResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CarouselSlider(
            options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3)),
            items: snapshot.data.productList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    elevation: 5.0,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: FutureBuilder<AllMediaResponse>(
                            future: allMediaResponse,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print('print:' +
                                    snapshot.data.productList.length
                                        .toString());
                                return Expanded(
                                  child: ListView.builder(
                                      itemCount:
                                          snapshot.data.productList.length,
                                      itemBuilder: (context, index) {
                                        print('print:' +
                                            snapshot.data.productList
                                                .elementAt(index)
                                                .guid
                                                .rendered);
                                        return Image.network(
                                          i.guid.rendered,
                                          fit: BoxFit.scaleDown,
                                        );
                                      }),
                                );
                              } else if (snapshot.hasError) return Container();
                              return CircularProgressIndicator();
                            },
                          ),
                        )),
                  );
                },
              );
            }).toList(),
          );
        } else {
          return Container();
        }
      },
    );

    return CarouselSlider(
      options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3)),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              elevation: 5.0,
              margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: FutureBuilder<AllMediaResponse>(
                      future: allMediaResponse,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print('print:' +
                              snapshot.data.productList.length.toString());
                          return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.productList.length,
                                itemBuilder: (context, index) {
                                  print('print:' +
                                      snapshot.data.productList
                                          .elementAt(index)
                                          .guid
                                          .rendered);
                                  return Image.network(
                                    'https://disc.noits.ltd/blog/wp-content/uploads/2021/07/woocommerce-placeholder.png',
                                    fit: BoxFit.scaleDown,
                                  );
                                }),
                          );
                        } else if (snapshot.hasError) return Container();
                        return CircularProgressIndicator();
                      },
                    ),
                  )),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 200),
        child: GradientAppBar("Discount Box"),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Center(child: mainBodyBuilder()),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.titled,
        backgroundColor: bottomBarBackground,
        gradient: LinearGradient(
          colors: [
            bottomBarBackgroundEndColor,
            bottomBarBackground,
            bottomBarBackgroundEndColor
          ],
          begin: const FractionalOffset(0.0, 0.0),
        ),
        color: Colors.black,
        top: -15,
        items: [
          TabItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            title: "Search",
          ),
          TabItem(
            icon: Icon(Icons.home, color: Colors.black),
            title: "Home",
          ),
          TabItem(
            icon: Icon(Icons.favorite, color: Colors.black),
            title: "Favourite",
          ),
        ],
        initialActiveIndex: 1,
        onTap: (int i) => _onItemTapped(i),
      ),
    );
  }

  /*BottomNavigationBar(
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        backgroundColor: mCardColor,
        onTap: _onItemTapped,
      )*/

  Future<void> getProducts() {
    setState(() {
      futureProducts = fetchAlbum();
    });
  }
}

Future<ProductResponse> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://disc.noits.ltd/blog/wp-json/wp/v2/product'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonresp = (json.decode(response.body) as List);

    //ProductResponse resp = new ProductResponse(productList: jsonresp);

    return ProductResponse.getData(jsonresp);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<media_response> fetchMedia(int id) async {
  String url =
      "https://disc.noits.ltd/blog/wp-json/wp/v2/media/" + id.toString();
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //var jsonresp = (json.decode(response.body) as List);

    //ProductResponse resp = new ProductResponse(productList: jsonresp);

    return media_response.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<String> getAllMedia() async {
  String url = "https://disc.noits.ltd/blog/wp-json/wp/v2/media/";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //var jsonresp = (json.decode(response.body) as List);

    //ProductResponse resp = new ProductResponse(productList: jsonresp);

    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<AllMediaResponse> fetchAllMedia() async {
  String url = "https://disc.noits.ltd/blog/wp-json/wp/v2/media";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonresp = (json.decode(response.body) as List);

    //ProductResponse resp = new ProductResponse(productList: jsonresp);

    return AllMediaResponse.getData(jsonresp);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Widget makeListTile(var snapshot, int index) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: new BoxDecoration(
              color: Colors.green,
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: snapshot.data.productList.elementAt(index).featuredMedia != 0
              ? FutureBuilder<media_response>(
                  future: fetchMedia(
                      snapshot.data.productList.elementAt(index).featuredMedia),
                  builder: (context, snapshoter) {
                    if (snapshoter.hasData) {
                      return Image.network(snapshoter.data.guid.rendered,
                          width: 50, height: 50);
                    } else if (snapshot.hasError) return Container();
                    return CircularProgressIndicator();
                  })
              : Icon(
                  Icons.shop,
                  size: 50,
                ),
        ),
      ],
    ),
    title: Text(
      snapshot.data.productList.elementAt(index).title.rendered,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
    subtitle: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.watch_later, color: Colors.yellowAccent),
              Expanded(
                child: new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(
                    snapshot.data.productList.elementAt(index).date.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.label_important, color: Colors.yellowAccent),
            Expanded(
              child: new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(
                  snapshot.data.productList
                      .elementAt(index)
                      .excerpt
                      .rendered
                      .toString()
                      .replaceAll("<p>", "")
                      .replaceAll("</p>", ""),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        )
      ],
    ),
    // trailing:
    // Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
  );
}
