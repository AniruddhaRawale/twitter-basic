import 'package:flitter/pages/addvideo.dart';
import 'package:flitter/pages/notificationes.dart';
import 'package:flitter/pages/profile.dart';
import 'package:flitter/pages/search.dart';
import 'package:flitter/pages/tweets.dart';
import 'package:flitter/utils/variables.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List pageoptions = [
    TweetsPage(),
    SearchPage(),
    AddVideo(),
    notification(),
    ProfilePage(),
  ];
  customicon(){
    return Container(
      width: 45,
      height: 27,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: 38,
            decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(7)
            ),
          ),
          Container(
            height: double.infinity,
            margin: EdgeInsets.only(right: 10),
            width: 38,
            decoration: BoxDecoration(
              //color: Color.fromARGB(255, 32, 211, 234),
              color: Colors.lightGreenAccent,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: 38,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7)
              ),
              child: Icon(
                Icons.add,size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageoptions[page],
      bottomNavigationBar: BottomNavigationBar(

        onTap: (index){
          FocusScope.of(context).unfocus();
          setState(() {
            page = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        currentIndex: page,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 30,),
            title:Text("Home",style: mystyle1(15),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call,size: 30,),
            title:Text("Live-Connect",style: mystyle1(15),),
          ),
          BottomNavigationBarItem(icon: customicon(),
              title: Text("",style: mystyle1(12),)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message,size: 30,),
            title:Text("Messages",style: mystyle1(15),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,size: 30,),
            title:Text("Profile",style: mystyle1(15),),
          ),

        ],
      ),
    );
  }
}


