import 'package:flutter/material.dart';
import 'package:sun/Music.dart';
import 'pages/HomePage.dart';
import 'theme/theme.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin{
  final GlobalKey<AnimatedListState> key=GlobalKey<AnimatedListState>();
  bool flag = false;
  bool flags = false;
  AnimationController animationController;
  Animation animation;
  List<Music> musicList;
  ScrollController controller;
   @override
  void initState() {
    super.initState();
    controller=ScrollController();
    musicList=Music.musicListItem;
    animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
        animationBehavior: AnimationBehavior.preserve);
    animation = Tween<double>(begin: 20.0, end: 200.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInCirc,
    ));
    animation.addListener(() {
      setState(() {});
    });

    animationController.forward();
  }
  @override
  void dispose() { 
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGreen,
      body: AnimatedList(
        key: key,
        scrollDirection: Axis.vertical,
        controller: controller,
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        initialItemCount: musicList.length,
        itemBuilder: (context,index,animation){
          return SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              axisAlignment: animation.value,
              child: buildMusicItem(
              musicList[index].heroTag, 
              musicList[index].title, 
              musicList[index].subtitle, 
              musicList[index].imgPath, 
              musicList[index].file,
              animation,
            ),
          );
        }),
    );
  }

  Widget buildMusicItem(
      int heroTag, String title, String subtitle, String imgPath, String file,Animation animation) {
    return Column(
      children: <Widget>[
        Card(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SlideTransition(
                position: Tween<Offset>(begin: Offset(10, 0),end: Offset.zero).animate(animation),
                child: ListTile(
                leading: Hero(
                    tag: heroTag,
                    createRectTween: (Rect begin,Rect end){
                      return RectTween(
                        begin: Rect.fromCircle(radius:60,center: Offset(20, -10)),
                        end: Rect.fromCircle(radius:60,center: Offset(-10, 20)),
                      );
                    },
                    transitionOnUserGestures: true,
                    child: CircleAvatar(
                       backgroundColor: primaryGreen,
                        backgroundImage: AssetImage(imgPath),
                    )),
                title: Text(title),
                subtitle: Text(subtitle),
                
                onTap: () {
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          heroTag: heroTag,
                          title: title,
                          subtitle: subtitle,
                          imgPath: imgPath,
                          file: file,
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
