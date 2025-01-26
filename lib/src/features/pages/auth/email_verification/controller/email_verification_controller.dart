import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/utils/custom_snackbar.dart';
import '../../../../../router/routes.dart';

class EmailVerificationController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  bool isCooldownActive = false;
  int resendCooldown = 60;
  Timer? _resendTimer;

  // Resend verification email with cooldown functionality
  Future<void> resendVerificationEmail(BuildContext context) async {
    if (isCooldownActive) {
      showSnackbar(
        message: "Please wait before retrying.",
        backgroundColor: Colors.grey,
      );
      return;
    }

    final colorScheme = Theme.of(context).colorScheme;
    try {
      User? user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        showSnackbar(
          message: "A verification email has been resent to ${user.email}.",
        );

        isCooldownActive = true;
        _startCooldown();
      } else {
        showSnackbar(
          message: "User is either not logged in or already verified.",
          backgroundColor: colorScheme.error.withOpacity(0.5),
        );
      }
    } catch (e) {
      showSnackbar(
        message: "Something went wrong. Please try again later.",
        backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.5),
      );
    }
  }

  // Send verification email for entered email
  Future<void> sendVerificationForEmail(BuildContext context) async {
    final isValid = await validateEmail(context);
    if (!isValid) return;

    isLoading = true;
    notifyListeners();

    try {
      // Check if email already exists
      final signInMethods = await _auth.fetchSignInMethodsForEmail(emailController.text);
      if (signInMethods.isNotEmpty) {
        showSnackbar(message: "Email is already registered.");
        return;
      }

      // Create new user with email and temporary password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: 'temporaryPassword', // Use a temporary password
      );

      if (userCredential.user != null) {
        await userCredential.user!.sendEmailVerification();

        // Check if email is verified and redirect
        if (userCredential.user!.emailVerified) {
          context.pushNamed(AppRoute.homePage); // Redirect to home page if verified
          return;
        }

        isLoading = false;
        notifyListeners();

        showSnackbar(
          message: "A verification email has been sent to ${emailController.text}.",
        );

        isCooldownActive = true;
        _startCooldown();

        // Check email verification status using onAuthStateChanged
        _listenForEmailVerification(context);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showSnackbar(
        message: "Failed to send email verification. Please try again later.",
        backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.5),
      );
    }
  }

  // Listen for email verification status using onAuthStateChanged
  void _listenForEmailVerification(BuildContext context) {
    _auth.userChanges().listen((user) async {
      if (user != null && user.emailVerified) {
        showSnackbar(message: "Your email is verified");
        context.pushNamed(AppRoute.homePage); // Redirect to home page
      }
    });
  }

  // Start cooldown for resend email
  void _startCooldown() {
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCooldown == 0) {
        isCooldownActive = false;
        resendCooldown = 60; // Reset cooldown
        _resendTimer?.cancel();
        notifyListeners();
      } else {
        resendCooldown--;
        notifyListeners();
      }
    });
  }

  // Validate email
  Future<bool> validateEmail(BuildContext context) async {
    final email = emailController.text;
    if (email.isEmpty) {
      showSnackbar(message: "Email cannot be empty.");
      return false;
    }
    if (!email.contains('@')) {
      showSnackbar(message: "Please enter a valid email address.");
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }
}
