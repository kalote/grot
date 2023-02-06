import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grot/components/my_button.dart';
import 'package:grot/components/my_inputfield.dart';
import 'package:grot/components/square_tile.dart';
import 'package:grot/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.headlineSmall!
        .copyWith(color: theme.colorScheme.onSurfaceVariant);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    void showErrorMessage(String message) {
      showDialog(
          context: context,
          builder: (context) {
            var theme = Theme.of(context);
            return AlertDialog(
              backgroundColor: theme.dialogBackgroundColor,
              title: Center(
                child: Text(message,
                    style: TextStyle(
                        color: theme.colorScheme.onSecondaryContainer)),
              ),
            );
          });
    }

    void signUserUp() async {
      // show loading
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      // create user
      try {
        // check if password & confirm are the same
        if (passwordController.text == confirmPasswordController.text) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
          if (context.mounted) {
            Navigator.pop(context);
          }
        } else {
          Navigator.pop(context);
          showErrorMessage("Passwords don't match");
        }
      } on FirebaseAuthException catch (e) {
        // remove loading
        Navigator.pop(context);
        showErrorMessage(e.code);
      }
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceVariant,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),

                // Logo
                const Icon(
                  Icons.lock,
                  size: 50,
                ),

                const SizedBox(
                  height: 25,
                ),

                // Title
                Text(
                  'Let\'s create an account!',
                  style: style,
                ),

                const SizedBox(
                  height: 25,
                ),

                // Username
                MyInputField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),

                const SizedBox(
                  height: 25,
                ),

                // Password
                MyInputField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true),

                const SizedBox(
                  height: 25,
                ),

                // Confirm Password
                MyInputField(
                    controller: confirmPasswordController,
                    hintText: "Confirm password",
                    obscureText: true),

                const SizedBox(
                  height: 25,
                ),

                // Sign in button
                MyButton(
                  onTap: signUserUp,
                  text: "Sign Up",
                ),

                const SizedBox(
                  height: 25,
                ),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color:
                              theme.colorScheme.onSurfaceVariant.withAlpha(100),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("or continue with"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color:
                              theme.colorScheme.onSurfaceVariant.withAlpha(100),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // Google + facebook login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/google.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    SquareTile(
                        onTap: () {}, imagePath: 'lib/images/facebook.png')
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),

                // register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("login now",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
