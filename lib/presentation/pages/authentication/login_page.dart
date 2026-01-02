import 'package:customer_management/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../values/colors.dart';
import '../../values/fonts.dart';
import '../../values/strings.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? emailError;
  String? passwordError;

  void validateAndLogin() {
    setState(() {
      emailError = null;
      passwordError = null;

      if (emailController.text.isEmpty) {
        emailError = AppStrings.emailErrEmpty;
      } else if (!_isValidEmail(emailController.text)) {
        emailError = AppStrings.emailErrInvalid;
      }

      if (passwordController.text.isEmpty) {
        passwordError = AppStrings.passwordErrEmpty;
      } else if (passwordController.text.length < 6) {
        passwordError = AppStrings.passwordErrInvalid;
      }

      if (emailError == null && passwordError == null) {
        // Handle login logic here


        // For debugging directly navigate to home_page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.06,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                _appLogoAndTitles(),
                _textFieldSection(),
                const Spacer(flex: 3)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: _bottomSection()
      ),
    );
  }

  Widget _appLogoAndTitles() {
    return Column(
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
    );
  }

  Widget _textFieldSection() {
    return Column(
      children: [
        const SizedBox(height: 32),
        Row(
          children: [
            Text(
              AppStrings.loginTitle,
              style: TextStyle(
                  fontFamily: AppFonts.semiBold,
                  fontSize: 20
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Text(
              AppStrings.emailTitle,
              style: TextStyle(
                fontFamily: AppFonts.semiBold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: emailController,
          labelText: AppStrings.emailLabel,
          hintText: AppStrings.emailHint,
          errorText: emailError,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Iconsax.send_2),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              AppStrings.passwordTitle,
              style: TextStyle(
                fontFamily: AppFonts.semiBold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: passwordController,
          labelText: AppStrings.passwordLabel,
          hintText: AppStrings.passwordHint,
          errorText: passwordError,
          isPassword: true,
          prefixIcon: const Icon(Iconsax.lock),
        ),
        const SizedBox(height: 32),
        CustomElevatedButton(
          width: MediaQuery.of(context).size.width,
          fontFamily: AppFonts.bold,
          backgroundColor: AppColors.primaryColor,
          textPadding: EdgeInsets.symmetric(vertical: 3),
          text: AppStrings.loginButtonText,
          onPressed: () {
            //print('Login pressed');
            validateAndLogin();
          },
        ),
      ],
    );
  }

  Widget _bottomSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.06,
        vertical: MediaQuery.of(context).size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
      ),
      child: Text(
        AppStrings.loginGuideWarning,
        style: TextStyle(
          fontFamily: AppFonts.regular,
          fontSize: 12
        ),
      ),
    );
  }
}