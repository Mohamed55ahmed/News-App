import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynewsapp/services/apis.dart';
import 'package:mynewsapp/services/fun.dart';


import '../../constant.dart';

class CategoryScreen extends StatefulWidget {
  String textCategories;

  CategoryScreen(this.textCategories);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 5.0, vertical: 40.0),
            child: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,size: 30,color: textColor,),
              label: Text("${widget.textCategories}"),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: APIS.fetchCategoryArticles("${widget.textCategories}"),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
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
                                          },
                                          icon: Icon(Icons.share)),
                                      IconButton(
                                          onPressed: () {
                                            FUN
                                                .copyLink(snapshot.data[index].url)
                                                .then((value) {
                                              final snackBar = SnackBar(
                                                content: Text('Copy...'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          },
                                          icon: Icon(Icons.copy))
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






