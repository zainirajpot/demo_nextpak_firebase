import 'dart:ui';

import 'package:firbase_nextpak_demo_test/src/common/constants/app_images.dart';
import 'package:firbase_nextpak_demo_test/src/common/constants/global_variables.dart';
import 'package:firbase_nextpak_demo_test/src/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../common/constants/app_colors.dart';
import '../../../../../common/widgets/custom_text_field.dart';
import '../../../../../common/widgets/social_Icon_container.dart';
import '../../../../../router/routes.dart';
import '../controller/signup_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late String _password = "";
  bool get _hasLetter => _password.contains(RegExp(r'[a-zA-Z]'));
  bool get _hasNumberOrSymbol =>
      _password.contains(RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]'));
  bool get _hasMinimumLength => _password.length >= 8;

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<SignupController>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppColors.darkPurple,
                    Colors.transparent,
                    AppColors.lightpink,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 0,
            child: Image.asset(
              AppImages.bgImage,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            right: -10,
            child: Image.asset(
              AppImages.signupLogo,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme(context).surface.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Form(
                    key: authController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Get Started Free',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: colorScheme(context).surface,
                                      fontSize: 26,
                                    ),
                              ),
                              Text(
                                'Free Forever. No Credit Card Needed',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: colorScheme(context)
                                          .surface
                                          .withOpacity(0.8),
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                spacing: 5,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //  const SizedBox(height: 3),
                                  Text(
                                    'Email',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: colorScheme(context).surface,
                                        ),
                                  ),
                                  // const SizedBox(height: 5),
                                  CustomTextFormField(
                                    controller: authController.emailController,
                                    hint: 'Email',
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Image.asset(AppImages.mail),
                                    onChanged: (_) =>
                                        authController.validateEmail(),
                                  ),
                                  // const SizedBox(height: 8),
                                  Text(
                                    'Full Name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: colorScheme(context).surface,
                                        ),
                                  ),
                                  //  const SizedBox(height: 5),
                                  CustomTextFormField(
                                    controller: authController.nameController,
                                    prefixIcon: Image.asset(AppImages.nameIcon),
                                    hint: 'Full Name',
                                    validator: (value) => value!.isEmpty
                                        ? "Name is required"
                                        : null,
                                  ),
                                  //  const SizedBox(height: 10),
                                  Text(
                                    'Password',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: colorScheme(context).surface,
                                        ),
                                  ),
                                  //  const SizedBox(height: 5),
                                  CustomTextFormField(
                                    controller:
                                        authController.passwordController,
                                    hint: '....',
                                    obscureText: authController.hidePassword,
                                    suffixIcon: SizedBox(
                                        width: 80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                spacing: 2,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 2,
                                                    width: 12,
                                                    color: _hasLetter
                                                        ? AppColors.appGreen
                                                        : AppColors.lightBlack,
                                                  ),
                                                  
                                                  Container(
                                                    height: 2,
                                                    width: 12,
                                                    color: _hasNumberOrSymbol
                                                        ? AppColors.appGreen
                                                        : AppColors.lightBlack,
                                                  ),
                                                  Container(
                                                    height: 2,
                                                    width: 12,
                                                    color: _hasMinimumLength
                                                        ? AppColors.appGreen
                                                        : AppColors.lightBlack,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              'Strong',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: AppColors.appGreen,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ],
                                        )),
                                    prefixIcon: Image.asset(AppImages.password),
                                    onChanged: (value) {
                                      setState(() {
                                        _password = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                              authController.isLoading
                                  ? const CircularProgressIndicator()
                                  : CustomButton(
                                      onTap: () {
                                        if (authController.formKey.currentState!
                                            .validate()) {
                                          authController.signup(context);
                                        }
                                      },
                                      text: 'SignUp'),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Or sign up with',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildSocialIcon(AppImages.google, () {
                                      // controller.signInWithGoogle(context);
                                    }, context),
                                    buildSocialIcon(AppImages.apple, () {
                                      context.pushNamed(AppRoute.login);
                                    }, context),
                                    buildSocialIcon(
                                        AppImages.facebook, () {}, context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
