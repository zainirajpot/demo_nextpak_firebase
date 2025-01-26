import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_nextpak_demo_test/src/common/constants/global_variables.dart';
import 'package:firbase_nextpak_demo_test/src/common/utils/custom_snackbar.dart';
import 'package:firbase_nextpak_demo_test/src/router/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool hidePassword = true;
  bool isLoading = false;
  bool canResendVerification = true;
  bool isEmailVerified = false; // Track email verification state
  Timer? _resendTimer;

  void togglePasswordVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    notifyListeners();

    try {
      // Get the email from the username
      final email = await _getEmailFromUsername(nameController.text.trim());

      if (email == null) {
        throw Exception('No email found for the provided username!');
      }

      // Log in with email and password
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: passwordController.text.trim(),
        );

        final user = userCredential.user;
        if (user != null) {
          if (user.emailVerified) {
            showSnackbar(message: 'Login Successful!');
            context.pushNamed(AppRoute.homePage);
          } else {
            _showVerifyEmailDialog(context, user);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          showSnackbar(message: 'Invalid password!', isError: true);
        } else {
          showSnackbar(message: e.message ?? 'Login failed!', isError: true);
        }
      }
    } catch (e) {
      if (e is Exception) {
        showSnackbar(message: e.toString(), isError: true);
      } else {
        showSnackbar(
            message: 'An unexpected error occurred. Please try again.',
            isError: true);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> _getEmailFromUsername(String username) async {
    try {
      final normalizedUsername = username.trim().toLowerCase();
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: normalizedUsername)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final email = querySnapshot.docs.first['email'];
        return email;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to fetch email: $e');
    }
  }

  // Show dialog for email verification
  void _showVerifyEmailDialog(BuildContext context, User user) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          Timer? _emailVerificationTimer;

          // Start the email verification check when the dialog is shown
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _emailVerificationTimer = Timer.periodic(Duration(seconds: 4), (timer) async {
              await user.reload();
              if (user.emailVerified) {
                timer.cancel();
                setState(() {
                  isEmailVerified = true; // Mark as verified
                });
              }
            });
          });

          return AlertDialog(
            title: Text('Verify Your Email'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please verify your email to continue. If you have not received a verification email, we can resend it.',
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: canResendVerification
                      ? () async {
                          await user.sendEmailVerification();
                          showSnackbar(message: 'Verification email sent!');
                          startResendCooldown();
                        }
                      : null,
                  child: Text('Resend Verification Email'),
                ),
                if (!canResendVerification)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Please wait before retrying.',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: Text('Close'),
              ),
                TextButton(
                  onPressed: () {
                    context.pushNamed(AppRoute.homePage); 
                  },
                  child: Text('Continue',style: TextStyle(color: colorScheme(context).onSurface),),
                ),
            ],
          );
        },
      );
    },
  );
}


  // Make this method public for use
  void startResendCooldown() {
    canResendVerification = false;
    notifyListeners();
    _resendTimer = Timer(Duration(seconds: 60), () {
      canResendVerification = true;
      notifyListeners();
    });
  }

  // Google Sign-In method
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      showSnackbar(message: 'Google Sign-In Successful');

      context.pushNamed(AppRoute.homePage);
    } catch (e) {
      showSnackbar(message: 'Google Sign-In failed: $e');
    }
  }
}
