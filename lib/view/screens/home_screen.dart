import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynewsapp/services/apis.dart';
import 'package:mynewsapp/services/fun.dart';
import 'package:mynewsapp/view/widget/categoriesbutton.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
                top: MediaQuery.of(context).size.height / 14),
            child: Text(
              "Choose News Categories",
              style: TextStyle(
                  color: textColor,
                  fontSize: fontXLarg,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 14,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoriesButton(
                  textCategories: 'General',
                  colorButton: blue,
                ),
                CategoriesButton(
                  textCategories: 'Science',
                  colorButton: green,
                ),
                CategoriesButton(
                  textCategories: 'Health',
                  colorButton: orangeLight,
                ),
                CategoriesButton(
                  textCategories: 'Business',
                  colorButton: yellow,
                ),
                CategoriesButton(
                  textCategories: 'Technology',
                  colorButton: blue,
                ),
                CategoriesButton(
                  textCategories: 'Sports',
                  colorButton: orangDark,
                ),
                CategoriesButton(
                  textCategories: 'Entertainment',
                  colorButton: yellow,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Best News",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: textColor,
                  fontSize: fontTitle,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: APIS.fetchArticles(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){
                            FUN.openLink("${snapshot.data[index].url}");
                          },
                          child: Card(
                            color: white,
                            elevation: 5,
                            shadowColor: textColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            ("${snapshot.data[index].urlToImage}" ==
                                                null)
                                                ? "https://www.google.com/url?sa=i&url=https%3A%2F%2Fbitsofco.de%2Fhandling-broken-images-with-service-worker%2F&psig=AOvVaw2mtOVMADLEV37XSyZUZekl&ust=1640980369908000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCJC7k7KmjPUCFQAAAAAdAAAAABAD"
                                                : "${snapshot.data[index].urlToImage}")),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.topCenter,
                                    width: MediaQuery.of(context).size.width * 0.90,
                                    child: Text(
                                      " ${snapshot.data[index].title} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: textColor),
                                      textAlign: TextAlign.center,
                                    )),
                                Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            FUN.shareLink(snapshot.data[index].url);
                                          }, icon: Icon(Icons.share)),
                                      IconButton(
                                          onPressed: () {
                                            FUN.copyLink(snapshot.data[index].url).then((value){
                                              final snackBar = SnackBar(
                                                content: Text('Copy...'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            });
                                          }, icon: Icon(Icons.copy))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )),
        ],
      ),
    );
  }
}
