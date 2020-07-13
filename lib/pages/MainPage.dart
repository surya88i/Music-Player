import 'package:flutter/material.dart';
import 'package:sun/Bookmark.dart';
import 'package:sun/DashboardPage.dart';
import 'FavouritePage.dart';
import 'package:sun/theme/theme.dart';
class MainPage extends StatefulWidget {
  final String title;
  MainPage({Key key, this.title}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DashboardPage dashboardPage;
  FavouritePage favouritePage;
  BookMarkPage bookMarkPage;
  int currentIndex = 0;
  String title,
      name = "Sunil Shedge",
      names = "Niwas Shedge",
      pic='assets/images/ganesh.jpg',
      pics='assets/images/tuxedo.png',
      backup,
      backups,
      pickup,
      email = 'swarajya888@gmail.com',
      emails = 'shedgesunil900@gmail.com';
  List<Widget> pages;
  Widget currentPage;
  final GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    dashboardPage = DashboardPage();
    favouritePage = FavouritePage();
    bookMarkPage=BookMarkPage();
    pages = [dashboardPage,bookMarkPage,favouritePage];
    currentPage = dashboardPage;
    title = 'Music Player';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: primaryGreen,
      key: skey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              margin: EdgeInsets.only(bottom:0),
              accountName: Text(name),
              accountEmail: Text(email),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/light-cycle.jpg'),
                  fit: BoxFit.cover)
              ),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundImage:AssetImage(pic),
                  backgroundColor: Colors.white,
                ),
                onTap: () {
                  setState(() {
                    backup = name;
                    name = names;
                    names = backup;

                    backups = email;
                    email = emails;
                    emails = backups;

                    pickup = pic;
                    pic = pics;
                    pics = pickup;
                  });
                },
              ),
              otherAccountsPictures: <Widget>[
                /* GestureDetector(
                  child: CircleAvatar(
                    backgroundImage:AssetImage(pics),
                    backgroundColor: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      backup = name;
                      name = names;
                      names = backup;

                      backups = email;
                      email = emails;
                      emails = backups;

                      pickup = pic;
                      pic = pics;
                      pics = pickup;
                    });
                  },
                ), */

                 Container(
                   width: 80,
                   height: 80,
                   decoration: BoxDecoration(
                     boxShadow: shadowList,
                     shape: BoxShape.circle,
                     color: Colors.white,
                   ),
                   child: Card(
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(30)),
                     child: IconButton(
                         icon: Icon(Icons.close, color: Colors.teal,size: 15,),
                         onPressed: () {
                           setState(() {
                             Navigator.pop(context);
                           });
                         }),
                   ),
                 ),
              ],
            ),
            Card(
              color: primaryGreen,
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: shadowList,
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                        icon: Icon(Icons.home, color: Colors.teal),
                        onPressed: () {
                          setState(() {});
                        }),
                  ),
                ),
                title: Text("Home",style: textStyle),
                onTap: () {},
              ),
            ),
            Card(
               color: primaryGreen,
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: shadowList,
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                        icon: Icon(Icons.album, color: Colors.teal),
                        onPressed: () {
                          setState(() {});
                        }),
                  ),
                ),
                title: Text("Album",style: textStyle),
                onTap: () {},
              ),
            ),
            Card(
               color: primaryGreen,
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: shadowList,
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                        icon: Icon(Icons.library_music, color: Colors.teal),
                        onPressed: () {
                          setState(() {});
                        }),
                  ),
                ),
                title: Text("Music",style: textStyle),
                onTap: () {},
              ),
            ),
            Card(
              color: primaryGreen,
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: shadowList,
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                        icon: Icon(Icons.video_library, color: Colors.teal),
                        onPressed: () {
                          setState(() {});
                        }),
                  ),
                ),
                title: Text("Videos",style: textStyle),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: shadowList,
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: IconButton(
                          icon: Icon(Icons.menu, color: Colors.teal),
                          onPressed: () {
                            setState(() {
                              skey.currentState.openDrawer();
                            });
                          }),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(title,
                        style: TextStyle(color:  Colors.white, fontSize: 20))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: shadowList,
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: IconButton(
                          icon: Icon(Icons.playlist_add, color: Colors.teal),
                          onPressed: () {}),
                    ),
                  ),
                )
              ],
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: currentPage),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              currentPage = pages[currentIndex];
              switch (index) {
                case 0:
                  {
                    title = 'Music Player';
                  }
                  break;
                case 1:
                  {
                    title = 'Video Song Player';
                  }
                  break;
                case 2:
                  {
                    title = 'Video Player';
                  }
                  break;
              }
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xFF333945),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.library_music),
                title: Text("Songs")),
            
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.ondemand_video,
                ),
                title: Text("Video Song")),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.live_tv,
                ),
                title: Text("Video")),
          ]),
    );
  }
}
