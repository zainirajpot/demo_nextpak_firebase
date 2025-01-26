import 'package:device_preview/device_preview.dart';
import 'package:firbase_nextpak_demo_test/src/features/pages/auth/login/controller/login_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/common/constants/global_variables.dart';
import 'src/common/utils/shared_preferences_helper.dart';
import 'src/features/pages/auth/email_verification/controller/email_verification_controller.dart';
import 'src/features/pages/auth/signup/controller/signup_controller.dart';
import 'src/router/routes.dart';
import 'src/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesHelper.getInitialValue();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => EmailVerificationController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: AppTheme.instance.lightTheme,
      routerConfig: MyAppRouter.router,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}
