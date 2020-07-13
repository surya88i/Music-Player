import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sun/Music.dart';
import 'package:sun/pages/MainPage.dart';
import 'package:sun/theme/theme.dart';
import 'package:volume/volume.dart';

class HomePage extends StatefulWidget {
  final String title, subtitle, imgPath, file;
  final int heroTag;
  HomePage({this.heroTag, this.title, this.subtitle, this.imgPath, this.file});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool flag = false;
  bool flags = false;
  bool on = false;
  AudioManager audioManager;
  int currentIndex = 0;
  int maxVol, currentVol;
  Duration duration = new Duration();
  Duration position = new Duration();
  double val = 0.0;
  IconData one;
  Color ones;
  final GlobalKey<ScaffoldState> skey = new GlobalKey<ScaffoldState>();
  var playerID;
  Animation<double> animation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    refresh();

    initPlatformState();
    updateVolumes();
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

  refresh() {
    setState(() {
      one = Icons.favorite_border;
      ones = Colors.teal;
    });
  }

  changeVolume(double value) {
    player.setVolume(value);
  }

  AudioPlayer player = new AudioPlayer();
  AudioCache audioCache = new AudioCache();
  AudioPlayerState playerState;
  void play(Music music) async {
    if (currentIndex != -1) {
      if (currentIndex >= 0) {
        player =
            await audioCache.play(Music.musicListItem[widget.heroTag].file);
        music = Music.musicListItem[currentIndex = widget.heroTag];
        currentIndex++;
      } else {
        if (currentIndex <= Music.musicListItem.length - 1) {
          player =
              await audioCache.play(Music.musicListItem[widget.heroTag].file);
          music = Music.musicListItem[currentIndex = widget.heroTag];
          currentIndex--;
        }
      }
    }
    player.onDurationChanged.listen((Duration d) {
      setState(() => duration = d);
    });
    player.onAudioPositionChanged.listen((Duration p) {
      setState(() => position = p);
    });
    player.onPlayerStateChanged.listen((event) {
      if (mounted) {
        setState(() {
          playerState = event;
        });
      }
    });
    player.onPlayerCompletion.listen((event) {
      setState(() {
        duration = position;
        playerState = AudioPlayerState.STOPPED;
        flags = false;
      });
    });
    player.onPlayerError.listen((event) {
      setState(() {
        playerState = AudioPlayerState.STOPPED;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
  }

  void stop() {
    player?.stop();
  }

  seekToSeconds(int seconds) {
    Duration newDuration = Duration(seconds: seconds);
    player.seek(newDuration);
  }

  @override
  void dispose() {
    player?.stop();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: skey,
      backgroundColor: primaryGreen,
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          children: <Widget>[
            Column(
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
                                  stop();
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
                        child: Text("Music Player",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20))),
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
                SizedBox(height: 20),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(200))),
                        child: Hero(
                          tag: widget.heroTag,
                          createRectTween: (Rect begin, Rect end) {
                            return RectTween(
                              begin: Rect.fromCircle(
                                  radius: 60, center: Offset(20, -10)),
                              end: Rect.fromCircle(
                                  radius: 60, center: Offset(-10, 20)),
                            );
                          },
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
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                boxShadow: shadowList,
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                    image: AssetImage(widget.imgPath),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Padding(
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
                                icon: Icon(one, color: ones),
                                onPressed: () {
                                  setState(() {
                                    one = flag
                                        ? Icons.favorite
                                        : Icons.favorite_border;
                                    ones = flag ? Colors.red : Colors.teal;
                                    flag = !flag;
                                  });
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.title + '.mp3',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.subtitle,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                Slider(
                    value: position.inSeconds.toDouble(),
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    activeColor: Colors.teal,
                    inactiveColor: Colors.grey[300],
                    onChanged: (double value) {
                      setState(() {
                        seekToSeconds(value.toInt());
                        value = value;
                      });
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                          Duration(seconds: position.inSeconds.toInt())
                              .toString()
                              .split('.')[0],
                          style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                          Duration(seconds: duration.inSeconds.toInt())
                              .toString()
                              .split('.')[0],
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(height: 40),
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
                                  stop();
                                  if (widget.heroTag != 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                  heroTag: Music
                                                      .musicListItem[
                                                          widget.heroTag - 1]
                                                      .heroTag,
                                                  title: Music
                                                      .musicListItem[
                                                          widget.heroTag - 1]
                                                      .title,
                                                  subtitle: Music
                                                      .musicListItem[
                                                          widget.heroTag - 1]
                                                      .subtitle,
                                                  imgPath: Music
                                                      .musicListItem[
                                                          widget.heroTag - 1]
                                                      .imgPath,
                                                  file: Music
                                                      .musicListItem[
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
                              icon: Icon(Icons.headset_mic,
                                  size: 25, color: Colors.teal),
                              onPressed: () {
                                player?.earpieceOrSpeakersToggle();
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
                              icon: flags == false
                                  ? Icon(
                                      Icons.play_circle_outline,
                                      color: Colors.teal,
                                      size: 30,
                                    )
                                  : Icon(Icons.pause_circle_outline,
                                      size: 30, color: Colors.teal),
                              onPressed: () {
                                setState(() {
                                  flags = !flags;
                                  flags
                                      ? play(Music.musicListItem[currentIndex])
                                      : stop();
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
                                  stop();
                                  if (widget.heroTag <
                                      Music.musicListItem.length - 1) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                  heroTag: Music
                                                      .musicListItem[
                                                          widget.heroTag + 1]
                                                      .heroTag,
                                                  title: Music
                                                      .musicListItem[
                                                          widget.heroTag + 1]
                                                      .title,
                                                  subtitle: Music
                                                      .musicListItem[
                                                          widget.heroTag + 1]
                                                      .subtitle,
                                                  imgPath: Music
                                                      .musicListItem[
                                                          widget.heroTag + 1]
                                                      .imgPath,
                                                  file: Music
                                                      .musicListItem[
                                                          widget.heroTag + 1]
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
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
