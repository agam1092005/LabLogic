// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lablogic/AdditionalFiles/constants.dart';
import 'package:lablogic/AdditionalFiles/rounded_button.dart';
import 'package:lablogic/Pages/SubPages/privacy_loader.dart';
import 'package:lablogic/utils/utilities.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: RoundedButton(
          onPressed: () async {
            await Glogin();
            var response = await verifyUser(auth.currentUser!.email.toString());
            var statusCode = response[0];
            var message = response[1];
            if (statusCode == 200 || statusCode == 201) {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool("loggedIn", true);
              prefs.setBool('bio', false);
              await refreshData();
              Navigator.of(context, rootNavigator: true).pushReplacement(
                CupertinoPageRoute<bool>(
                  fullscreenDialog: false,
                  builder: (BuildContext context) => const PrivacyLoader(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message['message'],
                  ),
                ),
              );
            }
            HapticFeedback.selectionClick();
          },
          height: 50,
          width: double.maxFinite,
          child: const Text(
            "Login with Google",
            style: ButtonTextStyle,
          ),
        ),
      ),
      body: Stack(
        children: [
          const RiveAnimation.asset("assets/shapes.riv"),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 25,
              sigmaX: 25,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 100, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.6,
                    child: const RiveAnimation.asset("assets/animation"),
                  ),
                  const Spacer(),
                  const Text(
                    "Save your time while doing your ",
                    style: SubHeadingTextStyle,
                  ),
                  Row(
                    children: [
                      AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Academic Research',
                            textStyle: HeadingTextStyle,
                          ),
                          TypewriterAnimatedText(
                            'Scientific Research',
                            textStyle: HeadingTextStyle,
                          ),
                          TypewriterAnimatedText(
                            'Lab Work',
                            textStyle: HeadingTextStyle,
                          ),
                          TypewriterAnimatedText(
                            'Simulation and Modeling',
                            textStyle: HeadingTextStyle,
                          ),
                          TypewriterAnimatedText(
                            'Data Analysis',
                            textStyle: HeadingTextStyle,
                          ),
                          TypewriterAnimatedText(
                            'Publication',
                            textStyle: HeadingTextStyle,
                          ),
                        ],
                      ),
                      const Text(
                        ",",
                        style: CommaTextStyle,
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
