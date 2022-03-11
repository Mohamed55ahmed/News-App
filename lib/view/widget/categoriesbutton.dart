import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mynewsapp/view/screens/categoryscreen.dart';

class CategoriesButton extends StatelessWidget {

  Color colorButton;
  String textCategories;


  CategoriesButton({required this.colorButton, required this.textCategories});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 2.5),
      child: RaisedButton(
        onPressed: () {
          Navigator.push(context,CupertinoPageRoute(
              builder: (BuildContext context){
                return CategoryScreen(textCategories);
              }));
        },
        color: this.colorButton,
        child:Text("${this.textCategories}"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
