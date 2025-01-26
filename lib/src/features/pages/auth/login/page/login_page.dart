import 'dart:ui';

import 'package:firbase_nextpak_demo_test/src/common/constants/app_images.dart';
import 'package:firbase_nextpak_demo_test/src/common/constants/global_variables.dart';
import 'package:firbase_nextpak_demo_test/src/common/widgets/custom_button.dart';
import 'package:firbase_nextpak_demo_test/src/features/pages/auth/login/controller/login_controller.dart';
import 'package:firbase_nextpak_demo_test/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../common/constants/app_colors.dart';
import '../../../../../common/widgets/custom_text_field.dart';
import '../../../../../common/widgets/social_Icon_container.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final loginController = Provider.of<LoginController>(context);

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: AppColors.black,
//       body: Stack(
//         children: [
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 100,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomRight,
//                   end: Alignment.bottomLeft,
//                   colors: [
//                     AppColors.darkPurple,
//                     Colors.transparent,
//                     AppColors.lightpink,
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 40,
//             right: 0,
//             child: Image.asset(
//               AppImages.bgImage,
//               height: 300,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             top: 40,
//             right: -10,
//             child: Image.asset(
//               AppImages.loginLogo,
//               height: 300,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: _buildLoginForm(context, loginController),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoginForm(BuildContext context, LoginController controller) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(25),
//         topRight: Radius.circular(25),
//       ),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.9,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
//           decoration: BoxDecoration(
//             color: colorScheme(context).surface.withOpacity(0.1),
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(25),
//               topRight: Radius.circular(25),
//             ),
//           ),
//           child: Form(
//             key: controller.formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Column(
//                     children: [
//                       Text(
//                         'Welcome Back!',
//                         style:
//                             Theme.of(context).textTheme.headlineSmall?.copyWith(
//                                   color: colorScheme(context).surface,
//                                   fontSize: 26,
//                                 ),
//                       ),
//                       Text(
//                         'Welcome back we missed you!',
//                         style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                               color:
//                                   colorScheme(context).surface.withOpacity(0.8),
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Username',
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         color: colorScheme(context).surface,
//                       ),
//                 ),
//                 CustomTextFormField(
//                   controller: controller.nameController,
//                   hint: 'User Name',
//                   prefixIcon: Image.asset(AppImages.nameIcon),
//                   validator: (value) => value == null || value.isEmpty
//                       ? "User Name is required"
//                       : null,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Password',
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                         color: colorScheme(context).surface,
//                       ),
//                 ),
//                 CustomTextFormField(
//                   controller: controller.passwordController,
//                   hint: 'Password',
//                   obscureText: controller.hidePassword,
//                   prefixIcon: Image.asset(AppImages.password),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       controller.hidePassword
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                       color: colorScheme(context).surface.withOpacity(0.7),
//                     ),
//                     onPressed: controller.togglePasswordVisibility,
//                   ),
//                   validator: (value) => value == null || value.isEmpty
//                       ? "Password is required"
//                       : null,
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       context.pushNamed(AppRoute.verifyEmailPage);
//                     },
//                     child: Text(
//                       'Forgot Password?',
//                       style: TextStyle(
//                         color: colorScheme(context).surface.withOpacity(0.8),
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 controller.isLoading
//                     ? Center(child: const CircularProgressIndicator())
//                     : CustomButton(
//                         onTap: () {
//                           if (controller.formKey.currentState!.validate()) {
//                             controller.login(context);
//                           }
//                         },
//                         text: 'Sign In',
//                       ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Divider(
//                           color: colorScheme(context).surface.withOpacity(0.7)),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Or continue with',
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Divider(
//                           color: colorScheme(context).surface.withOpacity(0.7)),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     buildSocialIcon(AppImages.google, () {
//                      // controller.signInWithGoogle(context);
//                     }, context),
//                     buildSocialIcon(AppImages.apple, () {}, context),
//                     buildSocialIcon(AppImages.facebook, () {}, context),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

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
              AppImages.loginLogo,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildLoginForm(context, loginController),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, LoginController controller) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          decoration: BoxDecoration(
            color: colorScheme(context).surface.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Welcome Back!',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: colorScheme(context).surface,
                                  fontSize: 26,
                                ),
                      ),
                      Text(
                        'Welcome back we missed you!',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color:
                                  colorScheme(context).surface.withOpacity(0.8),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Username',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme(context).surface,
                      ),
                ),
                CustomTextFormField(
                  controller: controller.nameController,
                  hint: 'User Name',
                  prefixIcon: Image.asset(AppImages.nameIcon),
                  validator: (value) => value == null || value.isEmpty
                      ? "User Name is required"
                      : null,
                ),
                const SizedBox(height: 10),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme(context).surface,
                      ),
                ),
                CustomTextFormField(
                  controller: controller.passwordController,
                  hint: 'Password',
                  obscureText: controller.hidePassword,
                  prefixIcon: Image.asset(AppImages.password),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: colorScheme(context).surface.withOpacity(0.7),
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Password is required"
                      : null,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.verifyEmailPage);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: colorScheme(context).surface.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                controller.isLoading
                    ? Center(child: const CircularProgressIndicator())
                    : CustomButton(
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.login(context);
                          }
                        },
                        text: 'Sign In',
                      ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                          color: colorScheme(context).surface.withOpacity(0.7)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Divider(
                          color: colorScheme(context).surface.withOpacity(0.7)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSocialIcon(AppImages.google, () {
                      controller.signInWithGoogle(context);
                    }, context),
                    buildSocialIcon(AppImages.apple, () {}, context),
                    buildSocialIcon(AppImages.facebook, () {}, context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
