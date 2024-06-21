// ignore_for_file: file_names, avoid_print

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lablogic/AdditionalFiles/constants.dart';
import 'package:lablogic/Pages/Notes.dart';
import 'package:lablogic/Pages/Profile.dart';
import 'package:lablogic/Pages/Records.dart';
import 'package:vosk_flutter/vosk_flutter.dart';
import 'dart:math' as math;

import '../utils/utilities.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? _tabController;
  String T = "Please speak";

  bool isListening = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void showTopModalSheet(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Dismissible(
                      key: const Key('dismiss'),
                      direction: DismissDirection.up,
                      onDismissed: (direction) {
                        Navigator.of(context).pop();
                        HapticFeedback.vibrate();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05,
                            left: 16,
                            right: 16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Notebooks",
                              style: SubHeadingTextStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: MediaQuery.of(context).size.width * 0.025,
                              children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.025,),
                                    decoration: BoxDecoration(
                                      color: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt(),
                                      ).withOpacity(1.0),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    height: 100,
                                    width: 80,
                                  ),
                                Container(
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.025,),
                                  decoration: BoxDecoration(
                                    color: Color(
                                      (math.Random().nextDouble() * 0xFFFFFF)
                                          .toInt(),
                                    ).withOpacity(1.0),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  height: 100,
                                  width: 80,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.025,),
                                  decoration: BoxDecoration(
                                    color: Color(
                                      (math.Random().nextDouble() * 0xFFFFFF)
                                          .toInt(),
                                    ).withOpacity(1.0),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  height: 100,
                                  width: 80,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.025,),
                                  decoration: BoxDecoration(
                                    color: Color(
                                      (math.Random().nextDouble() * 0xFFFFFF)
                                          .toInt(),
                                    ).withOpacity(1.0),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  height: 100,
                                  width: 80,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.025,),
                                  decoration: BoxDecoration(
                                    color: Color(
                                      (math.Random().nextDouble() * 0xFFFFFF)
                                          .toInt(),
                                    ).withOpacity(1.0),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  height: 100,
                                  width: 80,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 5,
                                width: 100,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                            ),

                            // Add other content here
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset(0.0, 0.0);
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DefaultTabController(
        length: 2,
        child: TabBar(
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              return Colors.transparent;
            },
          ),
          padding: const EdgeInsets.only(bottom: 16),
          controller: _tabController,
          onTap: (val) {
            setState(() {});
          },
          dividerHeight: 0,
          splashBorderRadius: BorderRadius.zero,
          dividerColor: Colors.transparent,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.white,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'DMSans',
            fontWeight: FontWeight.w500,
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 16),
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: secondaryColor,
          ),
          tabs: const [
            Tab(
              child: Center(
                child: Text(
                  "Record",
                ),
              ),
            ),
            Tab(
              child: Center(
                child: Text(
                  "Notes",
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: (_tabController?.index == 0) ? FloatingActionButton(
        onPressed: () async {
          if (!isListening) {
            final model = await ModelLoader().loadFromAssets(
                'assets/models/vosk-model-small-en-us-0.15.zip');
            final vosk = VoskFlutterPlugin.instance();

            final recognizer = await vosk.createRecognizer(
              model: model as Model,
              sampleRate: 1600,
            );
            final speechService = await vosk.initSpeechService(recognizer);
            speechService.onPartial().forEach((partial) => print(partial));
            speechService.onResult().forEach((result) => print(result));
            await speechService.start();
          } else {
            setState(() {
              isListening = false;
              print(isListening);
            });
          }
          setState(() {});
        },
        backgroundColor: accentColor,
        enableFeedback: true,
        child: const Icon(
          Icons.mic,
          color: Colors.white,
        ),
      ) : null,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.125),
        child: Container(
          padding: const EdgeInsets.all(16),
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showTopModalSheet(context);
                  HapticFeedback.selectionClick();
                },
                child: const Text(
                  "• Amoeba Research",
                  style: SubHeadingTextStyle,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute<bool>(
                      fullscreenDialog: false,
                      builder: (BuildContext context) => const Profile(),
                    ),
                  );
                  HapticFeedback.selectionClick();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    auth.currentUser!.photoURL.toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TabBarView(
          controller: _tabController,
          children: const [
            Records(),
            Notes(),
          ],
        ),
      ),
    );
  }
}
