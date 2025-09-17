import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/practice2.dart';
class practice extends StatefulWidget{
  @override
  State<practice> createState() => _practiceState();
}
class _practiceState extends State<practice> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 123),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context)=>Heroo(),
                ),
                );
              },
              child: Container(
                height: 120,
                width: 225,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage("assets/images/img.png"),
                      fit:BoxFit.cover,
                    ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple,Colors.purpleAccent],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 12,
                      blurRadius: 34
                  ),
                  ],
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}