import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle mystyle(double size, [Color color, FontWeight fw]) {
  return GoogleFonts.playfairDisplay(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}
TextStyle mystyle1(double size, [Color color, FontWeight fw]) {
  return GoogleFonts.roboto(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}


CollectionReference usercollection =
    FirebaseFirestore.instance.collection('users');
String exampleimage =
    'https://upload.wikimedia.org/wikipedia/commons/9/9a/Mahesh_Babu_in_Spyder_%28cropped%29.jpg';
Reference tweetpictures =
FirebaseStorage.instance.ref().child('tweetpictures');

CollectionReference tweetcollection =
    FirebaseFirestore.instance.collection('tweets');
Reference pictures = FirebaseStorage.instance.ref().child('tweetpics');
