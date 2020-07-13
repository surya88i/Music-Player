import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sun/Item.dart';
import 'package:sun/pages/MainPage.dart';
import 'package:sun/theme/theme.dart';
import 'package:video_player/video_player.dart';
import 'package:volume/volume.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:chewie/chewie.dart';

class VideoScreen extends StatefulWidget {
  final String title, subtitle, imgPath, file;
  final int heroTag;
  VideoScreen(
      {this.heroTag, this.title, this.subtitle, this.imgPath, this.file});
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with SingleTickerProviderStateMixin {
  bool on = false;
  bool flag = false;
  bool flags = false;
  Duration duration = new Duration();
  Duration position = new Duration();
  AudioManager audioManager;
  YoutubePlayerController controller;
  YoutubePlayer youtubePlayer;
  int maxVol, currentVol;
  double val = 0.0;
  IconData one;
  Color ones;
  int playbackTime=0;
  final GlobalKey<ScaffoldState> skey = new GlobalKey<ScaffoldState>();
  VideoPlayerController player;
  bool isPlaying;
  ChewieController chewieController;
  YoutubePlayerValue value = YoutubePlayerValue();
  @override
  void initState() {
    super.initState();
    initPlatformState();
    updateVolumes();
    initPlayer();
    refresh();
    youtubePlayer = YoutubePlayer(controller: controller);
    isPlaying=player.value.isPlaying;
  }

  void updateValue(YoutubePlayerValue newValue) => value = newValue;
  Future<void> initialize;
  int currentIndex=0;
  void initPlayer() async {
    player = VideoPlayerController.network(Item.itemListItem[widget.heroTag].imgPath);
    chewieController = ChewieController(
      videoPlayerController: player,
      aspectRatio: 3/2,
      autoPlay: false,
      looping: false,
    );
    initialize = player.initialize()
      ..then((_) {
        setState(() {
          player.addListener(() {
           
            setState(() {
               playbackTime=player.value.position.inSeconds;
               player.value.initialized;
            });
          });
        });
      });
  }
  void play(Item item) async{
    if (currentIndex != -1) {
      if (currentIndex >= 0) {
      player = VideoPlayerController.network(Item.itemListItem[widget.heroTag].imgPath);
    chewieController = ChewieController(
      videoPlayerController: player,
      aspectRatio: 3/2,
      autoPlay: false,
      looping: false,
    );
    initialize = player.initialize()
      ..then((_) {
        setState(() {
          player.addListener(() {
            setState(() {
               playbackTime=player.value.position.inSeconds;
               player.value.initialized;
            });
          });
        });
      });
        item = Item.itemListItem[currentIndex = widget.heroTag];
        currentIndex++;
      } else {
        if (currentIndex <= Item.itemListItem.length - 1) {
         player = VideoPlayerController.network(Item.itemListItem[widget.heroTag].imgPath);
    chewieController = ChewieController(
      videoPlayerController: player,
      aspectRatio: 3/2,
      autoPlay: false,
      looping: false,
    );
    initialize = player.initialize()
      ..then((_) {
        setState(() {
          player.addListener(() {
            setState(() {
              player.value.position.inSeconds;
            });
          });
        });
      });
      item = Item.itemListItem[currentIndex = widget.heroTag];
        currentIndex--;
        }
      }
    }
  }
  void stop()
  {
    player.pause();
  }
  Future<void> initPlatformState() async {
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  refresh() {
    setState(() {
      one = Icons.favorite_border;
      ones = Colors.teal;
    });
  }

  updateVolumes() async {
    maxVol = await Volume.getMaxVol;
    currentVol = await Volume.getVol;
  }

  setVol(int i) async {
    await Volume.setVol(i, showVolumeUI: ShowVolumeUI.SHOW);
  }

  seekToSeconds(int seconds) {
    Duration newDuration = Duration(seconds: seconds);
    player.seekTo(newDuration);
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: playerWidget());
  }

  Widget playerWidget() {
    return SafeArea(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                setState(() {
                                  player.pause();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()));
                                });
                              });
                            }),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Video Song Player",
                          style: TextStyle(color: primaryGreen, fontSize: 18))),
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
              SizedBox(height: 50),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Hero(
                    tag: widget.heroTag,
                    transitionOnUserGestures: true,
                    flightShuttleBuilder: (flightContext, animation,
                        direction, fromHeroContext, toHeroContext) {
                      final Hero toHero = toHeroContext.widget;
                      return SizeTransition(
                        axis: Axis.vertical,
                        axisAlignment: animation.value,
                        sizeFactor: animation,
                        child: toHero.child,
                      );
                    },
                    child: FutureBuilder(
                        future: initialize,
                        initialData: player.value.initialized,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Chewie(
                              controller: chewieController,
                            );
                          } else {
                            return Container(
                              height: 260,
                              child: Center(
                                  child: CircularProgressIndicator()),
                            );
                          }
                        }),
                  ),
                  
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget.title + '.mp3',
                  style: TextStyle(color: primaryGreen, fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget.subtitle,
                  style: TextStyle(color: primaryGreen, fontSize: 20),
                ),
              ),
              SizedBox(height: 30),
              /* Slider(
                  value: playbackTime.toDouble(),
                  min: 0.0,
                  max: player.value.duration.inSeconds.toDouble(),
                  activeColor: Colors.teal,
                  inactiveColor: Colors.grey[300],
                  onChanged: (double value) {
                    setState(() {
                      seekToSeconds(value.toInt());
                      value = value;
                    });
                  }), */
              /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                        Duration(
                                seconds:
                                    player.value.position.inSeconds.toInt())
                            .toString()
                            .split('.')[0],
                        style: TextStyle(color: primaryGreen)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                        Duration(
                                seconds:
                                    player.value.duration.inSeconds.toInt())
                            .toString()
                            .split('.')[0],
                        style: TextStyle(color: primaryGreen)),
                  ),
                ],
              ), */
              SizedBox(height: 30),
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
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            icon: Icon(Icons.keyboard_arrow_left,
                                size: 25, color: Colors.teal),
                            onPressed: () {
                              setState(() {
                                 player.pause();
                                  if (widget.heroTag != 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VideoScreen(
                                                  heroTag: Item
                                                      .itemListItem[
                                                          widget.heroTag - 1]
                                                      .heroTag,
                                                  title: Item
                                                      .itemListItem[
                                                          widget.heroTag - 1]
                                                      .title,
                                                  subtitle: Item
                                                      .itemListItem[
                                                          widget.heroTag - 1]
                                                      .subtitle,
                                                  imgPath: Item
                                                      .itemListItem[
                                                          widget.heroTag - 1]
                                                      .imgPath,
                                                  file: Item
                                                      .itemListItem[
                                                          widget.heroTag - 1]
                                                      .file,
                                                )));

                                    print(widget.title +
                                        '\t' +
                                        widget.heroTag.toString() +
                                        '\t' +
                                        widget.file);
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
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            icon: Icon(Icons.screen_rotation,
                                size: 25, color: Colors.teal),
                            onPressed: () {
                              updateValue(value.copyWith(
                                  isFullScreen: !value.isFullScreen));
                              if (value.isFullScreen) {
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.landscapeLeft,
                                  DeviceOrientation.landscapeRight,
                                ]);
                              } else {
                                SystemChrome.setPreferredOrientations(
                                    [DeviceOrientation.portraitUp]);
                              }
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
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            icon: player.value.isPlaying
                                ? Icon(
                                    Icons.pause_circle_outline,
                                    color: Colors.teal,
                                    size: 30,
                                  )
                                : Icon(Icons.play_circle_outline,
                                    size: 30, color: Colors.teal),
                            onPressed: () {
                              setState(() {
                                if (player.value.isPlaying) {
                                  player.pause();
                                } else {
                                  if (player.value.position >
                                      Duration(seconds: 0)) {
                                    player.seekTo(Duration(seconds: 0));
                                  }
                                  player.play();
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
                            borderRadius: BorderRadius.circular(30)),
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
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            icon: Icon(Icons.keyboard_arrow_right,
                                size: 25, color: Colors.teal),
                            onPressed: () {
                                setState(() {
                                  player.pause();
                                  if (widget.heroTag <
                                      Item.itemListItem.length - 1) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VideoScreen(
                                                  heroTag: Item
                                                      .itemListItem[
                                                          widget.heroTag + 1]
                                                      .heroTag,
                                                  title: Item
                                                      .itemListItem[
                                                          widget.heroTag + 1]
                                                      .title,
                                                  subtitle: Item
                                                      .itemListItem[
                                                          widget.heroTag + 1]
                                                      .subtitle,
                                                  imgPath: Item
                                                      .itemListItem[
                                                          widget.heroTag + 1]
                                                      .imgPath,
                                                  file: Item
                                                      .itemListItem[
                                                          widget.heroTag + 1]
                                                      .file,
                                                )));

                                    print(widget.title+'\t'+widget.heroTag.toString()+'\t'+widget.file);
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
        ],
      ),
    );
  }
}
