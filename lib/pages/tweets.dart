import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flitter/pages/search.dart';
import 'package:flitter/utils/variables.dart';
import 'package:flutter/material.dart';

import '../utils/addtweet.dart';
import '../utils/comment.dart';
import '../utils/variables.dart';

class TweetsPage extends StatefulWidget {
  @override
  _TweetsPageState createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  String uid;
  initState() {
    super.initState();
    getcurrentuseruid();
  }

  getcurrentuseruid() async {
    var firebaseuser = FirebaseAuth.instance.currentUser;
    setState(() {
      uid = firebaseuser.uid;
    });
  }

  likepost(String documentid) async {
    var firebaseuser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot doc = await tweetcollection.doc(documentid).get();

    if (doc.data()['likes'].contains(firebaseuser.uid)) {
      tweetcollection.doc(documentid).update({
        'likes': FieldValue.arrayRemove([firebaseuser.uid])
      });
    } else {
      tweetcollection.doc(documentid).update({
        'likes': FieldValue.arrayUnion([firebaseuser.uid])
      });
    }
  }

  sharepost(String documentid, String tweet) async {
    Share.text('Flitter', tweet, 'text/plain');
    DocumentSnapshot doc = await tweetcollection.doc(documentid).get();
    tweetcollection
        .doc(documentid)
        .update({'shares': doc.data()['shares'] + 1});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTweet())),
          child: Icon(Icons.add, size: 32),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
         title:Text(
           'Tut.Social',
           style: mystyle(35, Colors.white, FontWeight.w500),
         ),
         actions: <Widget>[
           Padding(
             padding: const EdgeInsets.only(right:8.0),
             child: IconButton(icon: Icon(Icons.search,size: 35,), onPressed:(){ Navigator.push(
                 context, MaterialPageRoute(builder: (context) => SearchPage()));}),
           )
         ],


         /* title: Row(
          //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Text(
                  'Tut.Social',
                  style: mystyle(35, Colors.white, FontWeight.w700),
                ),
              ),
              SizedBox(
                width: 100.0,
              ),
              Icon(Icons.search,size: 35,)
            ],
          ),*/
        ),
        body: StreamBuilder(
            stream: tweetcollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot tweetdoc = snapshot.data.documents[index];
                    return Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              NetworkImage(tweetdoc.data()['profilepic']),
                        ),
                        title: Text(
                          tweetdoc.data()['username'],
                          style: mystyle1(20, Colors.black, FontWeight.w500),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (tweetdoc.data()['type'] == 1)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  tweetdoc.data()['tweet'],
                                  style: mystyle1(
                                      20, Colors.black, FontWeight.w300),
                                ),
                              ),
                            if (tweetdoc.data()['type'] == 2)
                              Image(image: NetworkImage(tweetdoc['image'])),
                            if (tweetdoc.data()['type'] == 3)
                              Column(
                                children: [
                                  Text(
                                    tweetdoc.data()['tweet'],
                                    style: mystyle1(
                                        20, Colors.black, FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Image(
                                      image: NetworkImage(
                                          tweetdoc.data()['image'])),
                                ],
                              ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CommentPage(
                                                  tweetdoc.data()['id']))),
                                      child: Icon(Icons.comment),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      tweetdoc
                                          .data()['commentcount']
                                          .toString(),
                                      style: mystyle1(18),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          likepost(tweetdoc.data()['id']),
                                      child:
                                          tweetdoc.data()['likes'].contains(uid)
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : Icon(Icons.favorite_border),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      tweetdoc
                                          .data()['likes']
                                          .length
                                          .toString(),
                                      style: mystyle1(18),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => sharepost(
                                          tweetdoc.data()['id'],
                                          tweetdoc.data()['tweet']),
                                      child: Icon(Icons.share),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      tweetdoc.data()['shares'].toString(),
                                      style: mystyle1(18),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}
