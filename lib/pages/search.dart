import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flitter/pages/viewuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



import '../utils/variables.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<QuerySnapshot> searchuseresult;
  searchuser(String s) {
    var users =
        usercollection.where('username', isGreaterThanOrEqualTo: s).get();

    setState(() {
      searchuseresult = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffECE5DA),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: TextFormField(
            style: mystyle1(20.0,Colors.white,FontWeight.w600),
            cursorColor: Colors.white,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                fillColor: Colors.green[850],
                hintText: "  Search for Tuters",
                hintStyle: mystyle1(18,Colors.white,FontWeight.w600)),
            onFieldSubmitted: searchuser,
          ),
        ),
        body: searchuseresult == null
            ? Center(
                child: Image.asset("lib/assets/search.png",fit:BoxFit.cover ,height: MediaQuery.of(context).size.height,
                width:  MediaQuery.of(context).size.width,)
              )
            : FutureBuilder(
                future: searchuseresult,
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot user = snapshot.data.docs[index];
                      return Card(
                        shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                        elevation: 8.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                NetworkImage(user.data()['profilepic']),
                          ),
                          title: Text(
                            user.data()['username'],
                            style: mystyle1(25),
                          ),
                          trailing: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewUser(user.data()['uid']))),
                            child: Container(
                              width: 90,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.pink[500]),
                              child: Center(
                                child: Text("View", style: mystyle1(20)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ));
  }
}
