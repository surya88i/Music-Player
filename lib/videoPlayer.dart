import 'package:flutter/material.dart';
import 'package:sun/Video.dart';
import 'package:sun/pages/MainPage.dart';
import 'package:volume/volume.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'theme/theme.dart';

class VideoPlayer extends StatefulWidget {
  final String title, subtitle, imgPath;
  final int heroTag;
  VideoPlayer({this.heroTag, this.title, this.subtitle, this.imgPath});
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController controller;
  final GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  bool flag = false;
  int maxVol, currentVol;

  bool on = false;
  Future<void> initPlatformState() async {
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  updateVolumes() async {
    maxVol = await Volume.getMaxVol;
    currentVol = await Volume.getVol;
  }

  setVol(int i) async {
    await Volume.setVol(i, showVolumeUI: ShowVolumeUI.SHOW);
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    updateVolumes();
    controller = YoutubePlayerController(
      initialVideoId: Video.videoListItem[widget.heroTag].imgPath,
      flags: YoutubePlayerFlags(
        captionLanguage: 'en',
        autoPlay: false,
        mute: false,
        isLive: true,
      ),
    );
  }

  int currentIndex = 0;
  void play(Video video) async {
    if (currentIndex != -1) {
      if (currentIndex >= 0) {
        controller = YoutubePlayerController(
          initialVideoId: Video.videoListItem[widget.heroTag].imgPath,
          flags: YoutubePlayerFlags(
            captionLanguage: 'en',
            autoPlay: false,
            mute: false,
            isLive: true,
          ),
        );
        video = Video.videoListItem[currentIndex = widget.heroTag];
        currentIndex++;
      } else {
        if (currentIndex <= Video.videoListItem.length - 1) {
          controller = YoutubePlayerController(
            initialVideoId: Video.videoListItem[widget.heroTag].imgPath,
            flags: YoutubePlayerFlags(
              captionLanguage: 'en',
              autoPlay: false,
              mute: false,
              isLive: true,
            ),
          );

          video = Video.videoListItem[currentIndex = widget.heroTag];
          currentIndex--;
        }
      }
    }
  }

  void pause() {
    controller.pause();
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
      drawer: Drawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                            icon: Icon(Icons.keyboard_arrow_left,
                                color: Colors.teal),
                            onPressed: () {
                              setState(() {
                                controller.pause();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPage()));
                              });
                            }),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Live Movie",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
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
                            icon: Icon(Icons.notifications_none,
                                color: Colors.teal),
                            onPressed: () {}),
                      ),
                    ),
                  )
                ],
              ),
              Hero(
                tag: widget.heroTag,
                child: YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blue,
                    width: MediaQuery.of(context).size.width,
                    liveUIColor: Colors.red,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),
                    onReady: () {},
                  ),
                  builder: (context, player) {
                    return Column(
                      children: <Widget>[
                        player,
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 5),
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 340,
                    child: Card(
                      color: primaryGreen,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.movie_filter,
                                    color: primaryGreen)),
                            title: Text(widget.title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22)),
                            subtitle: Text(widget.subtitle,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Text(
                              "The ${widget.title} film is released date in 2000. This Film is produced by ${widget.subtitle}.This film actor is role played by ${widget.title} and ${widget.subtitle}.Bollywood is the largest film producer in india and one of the largest centers of film production in the world.Bollywood is formally reffered to as hindi cinema. Indian cinema specially Bollywood is a craze millions of fans with its superhit blockbuster film.this film made by entertaiment purpose Hindi movie.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: IconButton(
                                        icon: Icon(Icons.keyboard_arrow_left,
                                            size: 25, color: Colors.teal),
                                        onPressed: () {
                                          setState(() {
                                            controller.pause();
                                            if (widget.heroTag != 0) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VideoPlayer(
                                                            heroTag: Video
                                                                .videoListItem[
                                                                    widget.heroTag -
                                                                        1]
                                                                .heroTag,
                                                            title: Video
                                                                .videoListItem[
                                                                    widget.heroTag -
                                                                        1]
                                                                .title,
                                                            subtitle: Video
                                                                .videoListItem[
                                                                    widget.heroTag -
                                                                        1]
                                                                .subtitle,
                                                            imgPath: Video
                                                                .videoListItem[
                                                                    widget.heroTag -
                                                                        1]
                                                                .imgPath,
                                                          )));

                                              print(widget.title +
                                                  '\t' +
                                                  widget.heroTag.toString() +
                                                  '\t' +
                                                  widget.imgPath);
                                            }
                                          });
                                        }),
                                  ),
                                ),
                              ),
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
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: IconButton(
                                        icon: Icon(Icons.screen_rotation,
                                            size: 25, color: Colors.teal),
                                        onPressed: () {
                                          controller.toggleFullScreenMode();
                                        }),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    boxShadow: shadowList,
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: IconButton(
                                        icon: flag
                                            ? Icon(
                                                Icons.pause_circle_outline,
                                                color: Colors.teal,
                                                size: 30,
                                              )
                                            : Icon(
                                                Icons.play_circle_outline,
                                                color: Colors.teal,
                                                size: 30,
                                              ),
                                        onPressed: () {
                                          setState(() {
                                            flag = !flag;
                                            flag
                                                ? play(Video.videoListItem[
                                                    currentIndex])
                                                : pause();
                                          });
                                        }),
                                  ),
                                ),
                              ),
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
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: IconButton(
                                        icon: on
                                            ? Icon(Icons.volume_up,
                                                size: 25, color: Colors.teal)
                                            : Icon(Icons.volume_down,
                                                size: 25, color: Colors.teal),
                                        onPressed: () {
                                          setState(() {
                                            on = !on;
                                            on ? setVol(100) : setVol(0);
                                          });
                                        }),
                                  ),
                                ),
                              ),
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
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: IconButton(
                                        icon: Icon(Icons.keyboard_arrow_right,
                                            size: 25, color: Colors.teal),
                                        onPressed: () {
                                          setState(() {
                                            controller.pause();
                                            if (widget.heroTag <
                                                Video.videoListItem.length -
                                                    1) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VideoPlayer(
                                                            heroTag: Video
                                                                .videoListItem[
                                                                    widget.heroTag +
                                                                        1]
                                                                .heroTag,
                                                            title: Video
                                                                .videoListItem[
                                                                    widget.heroTag +
                                                                        1]
                                                                .title,
                                                            subtitle: Video
                                                                .videoListItem[
                                                                    widget.heroTag +
                                                                        1]
                                                                .subtitle,
                                                            imgPath: Video
                                                                .videoListItem[
                                                                    widget.heroTag +
                                                                        1]
                                                                .imgPath,
                                                          )));

                                              print(widget.title +
                                                  '\t' +
                                                  widget.heroTag.toString() +
                                                  '\t' +
                                                  widget.imgPath);
                                            }
                                          });
                                        }),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
