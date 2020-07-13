import 'package:flutter/material.dart';
import 'package:sun/Video.dart';
import 'package:sun/videoPlayer.dart';
import 'package:sun/theme/theme.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();
  ScrollController controller;
  List<Video> videoList;
  @override
  void initState() {
    super.initState();
    videoList = Video.videoListItem;
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGreen,
      body: AnimatedList(
        key: key,
        controller: controller,
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        scrollDirection: Axis.vertical,
        initialItemCount: videoList.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            axis: Axis.vertical,
            axisAlignment: animation.value,
            child: buildVideoItem(
              videoList[index].heroTag,
              videoList[index].title,
              videoList[index].subtitle,
              videoList[index].imgPath,
              animation,
            ),
          );
        },
      ),
    );
  }

  Widget buildVideoItem(int heroTag, String title, String subtitle,
      String imgPath, Animation animation) {
    return Column(
      children: <Widget>[
        Card(
          color: Colors.deepOrangeAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeTransition(
              opacity: animation,
              child: ListTile(
                leading: Hero(
                    tag: heroTag,
                    child: CircleAvatar(
                      backgroundColor: primaryGreen,
                      child: Icon(Icons.video_library, color: Colors.white),
                    )),
                title: Text(title, style: textStyle),
                subtitle: Text(
                  subtitle,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VideoPlayer(
                          heroTag: heroTag,
                          title: title,
                          subtitle: subtitle,
                          imgPath: imgPath,
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
