import 'package:flutter/material.dart';
Color primaryGreen=Color(0xFF333945);
List<BoxShadow> shadowList=[
  BoxShadow(
    blurRadius: 5,
    color: Colors.grey[300],
    offset: Offset(0,1),   
  ),
];
List<Map> categories=[
  {'name':'Hamburger','iconPath':'assets/images/burger.png'},
  {'name':'Hamburger','iconPath':'assets/images/burger.png'},
  {'name':'Hamburger','iconPath':'assets/images/burger.png'},
  {'name':'Hamburger','iconPath':'assets/images/burger.png'},
  {'name':'Hamburger','iconPath':'assets/images/burger.png'},
  {'name':'Hamburger','iconPath':'assets/images/burger.png'},
  {'name':'Hamburger','iconPath':'assets/images/burger.png'},
  {'name':'Hamburger','iconPath':'assets/images/burger.png'},
  {'name':'Hamburger','iconPath':'assets/images/burger.png'},
  {'name':'Hamburger','iconPath':'assets/images/burger.png'},

];
List<Map> drawerItems=[
  {
    'title':'Home',
    'icon':Icons.home,
  },
  {
    'title':'Home',
    'icon':Icons.home,
  },
  {
    'title':'Home',
    'icon':Icons.home,
  },
  {
    'title':'Home',
    'icon':Icons.home,
  },
];
TextStyle textStyle=TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.w400,
);