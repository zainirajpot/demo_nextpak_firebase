import 'package:firbase_nextpak_demo_test/src/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/constants/global_variables.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../controller/email_verification_controller.dart';

class EmailVerificationPage extends StatelessWidget {
  EmailVerificationPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailVerificationController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: colorScheme(context).onSurface,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Verify Email"),
            centerTitle: true,
            backgroundColor: colorScheme(context).onSurface,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 50),
                    Icon(
                      Icons.email_outlined,
                      color: colorScheme(context).surface,
                      size: 70,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Enter your email address to receive the verification link',
                      style: textTheme(context).titleMedium?.copyWith(
                          color: colorScheme(context).surface,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hint: "Enter your email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be empty";
                        }
                        if (!value.contains('@')) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: controller.isLoading
                          ? "Sending..."
                          : "Send Verification Email",
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          controller.sendVerificationForEmail(context);
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: controller.isCooldownActive
                          ? null
                          : () => controller.resendVerificationEmail(context),
                      child: Text(
                        controller.isCooldownActive
                            ? 'Resend in ${controller.resendCooldown}s'
                            : 'Resend Email Link',
                        style: TextStyle(
                          color: controller.isCooldownActive
                              ? Colors.grey
                              : Colors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
