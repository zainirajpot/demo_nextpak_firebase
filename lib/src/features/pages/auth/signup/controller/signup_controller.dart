// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firbase_nextpak_demo_test/src/router/routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../../common/utils/custom_snackbar.dart';
// import '../../../../../common/utils/shared_preferences_helper.dart';

// class SignupController with ChangeNotifier {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   String? emailError;
//   String? passwordError;
//   bool hidePassword = true;
//   bool isLoading = false;
//   String? passwordStrengthLabel;
//   bool hasLetter = false;
//   bool hasNumberOrSymbol = false;
//   bool hasMinimumLength = false;

//   void togglePasswordVisibility() {
//     hidePassword = !hidePassword;
//     notifyListeners();
//   }

//   void validatePassword(String value) {
//     hasLetter = value.contains(RegExp(r'[a-zA-Z]'));
//     hasNumberOrSymbol = value.contains(RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]'));
//     hasMinimumLength = value.length >= 8;

//     if (value.isEmpty) {
//       passwordError = 'Password cannot be empty';
//       passwordStrengthLabel = null;
//     } else if (hasMinimumLength) {
//       passwordError = null;
//       passwordStrengthLabel = 'Strong Password';
//     } else {
//       passwordError = null;
//       passwordStrengthLabel = 'Weak Password';
//     }
//   }

//   void validateEmail() {
//     if (emailController.text.isEmpty) {
//       emailError = 'Email is required';
//     } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$')
//         .hasMatch(emailController.text)) {
//       emailError = 'Enter a valid email';
//     } else {
//       emailError = null;
//     }
//     notifyListeners();
//   }

// Future<void> signup(BuildContext context) async {
//   isLoading = true;
//   notifyListeners();

//   try {
//     // Create User
//     final userCredential = await _auth.createUserWithEmailAndPassword(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     );

//     // Save User Data to Firestore
//     await _firestore.collection('users').doc(userCredential.user!.uid).set({
//       'name': nameController.text.trim(),
//       'email': emailController.text.trim(),
//       'uid': userCredential.user!.uid,
//       'isEmailVerified': false,
//     });

//     // Save Data Locally using SharedPreferencesHelper
//     await SharedPreferencesHelper.saveString('name', nameController.text.trim());
//     await SharedPreferencesHelper.saveString('email', emailController.text.trim());
//     await SharedPreferencesHelper.saveBool('isLoggedIn', false); // Mark as not logged in yet
//     await SharedPreferencesHelper.saveBool('isFirstTime', false); // Not first time now

//     // Send Email Verification
//     await userCredential.user!.sendEmailVerification();

//     showSnackbar(
//       message: 'Registration successful!',
//       icon: Icons.done_all_rounded,
//       isError: false,
//     );

//     context.pushNamed(AppRoute.login);
//   } on FirebaseAuthException catch (e) {
//     showSnackbar(
//       message: e.message ?? 'An error occurred',
//       icon: Icons.warning_amber_rounded,
//       isError: true,
//     );
//   } catch (e) {
//     showSnackbar(
//       message: 'An error occurred: $e',
//       icon: Icons.warning_amber_rounded,
//       isError: true,
//     );
//   } finally {
//     isLoading = false;
//     notifyListeners();
//   }
// }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/utils/custom_snackbar.dart';
import '../../../../../common/utils/shared_preferences_helper.dart';
import '../../../../../router/routes.dart';

class SignupController with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool hidePassword = true;
  bool isLoading = false;

  void togglePasswordVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void validateEmail() {
    if (emailController.text.isEmpty) {
      showSnackbar(
        message: 'Email is required',
        icon: Icons.warning_amber_rounded,
        isError: true,
      );
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      showSnackbar(
        message: 'Enter a valid email address',
        icon: Icons.warning_amber_rounded,
        isError: true,
      );
    }
  }

  Future<void> signup(BuildContext context) async {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      showSnackbar(
        message: 'Please fill all fields correctly',
        icon: Icons.warning_amber_rounded,
        isError: true,
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      // Create user with Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'uid': userCredential.user!.uid,
        'isEmailVerified': false,
      });

      // Save data locally using SharedPreferences
      await SharedPreferencesHelper.saveString(
          'name', nameController.text.trim());
      await SharedPreferencesHelper.saveString(
          'email', emailController.text.trim());
      await SharedPreferencesHelper.saveBool('isLoggedIn', false);

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      showSnackbar(
        message: 'Registration successful! Please verify your email.',
        icon: Icons.done_all_rounded,
        isError: false,
      );

      // Navigate to login screen
      context.pushNamed(AppRoute.login);
    } on FirebaseAuthException catch (e) {
      showSnackbar(
        message: e.message ?? 'Registration failed',
        icon: Icons.error_outline,
        isError: true,
      );
    } catch (e) {
      showSnackbar(
        message: 'An error occurred: $e',
        icon: Icons.error_outline,
        isError: true,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
