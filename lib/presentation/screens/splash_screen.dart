import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';

import '../pages/authentication/login_page.dart';
import '../values/colors.dart';
import '../values/fonts.dart';
import '../values/resources.dart';
import '../values/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _redirectToLogin();
  }

  Future<void> _redirectToLogin() async {
    await Future.delayed(Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              _splashMainContent(),
              _splashBottomAnim()
            ],
          ),
        ),
      ),
    );
  }

  Widget _splashMainContent() {
    return Expanded(
      flex: 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: const Icon(
              Icons.people_alt_outlined,
              color: Colors.white,
              size: 64,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            AppStrings.appTitle,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.bold,
                color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            AppStrings.appSubTitle,
            style: TextStyle(
                fontFamily: AppFonts.regular,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }

  Widget _splashBottomAnim() {
    return Expanded(
        flex: 1,
        child: Lottie.asset(
          AppResources.loadingDotAnim,
        )
    );
  }
}