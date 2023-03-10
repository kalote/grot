import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grot/components/my_button.dart';
import 'package:grot/components/my_inputfield.dart';
import 'package:grot/components/square_tile.dart';
import 'package:grot/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.headlineSmall!
        .copyWith(color: theme.colorScheme.onSurfaceVariant);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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

    void signUserIn() async {
      // show loading
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      // log user
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        // remove loading
        if (context.mounted) {
          Navigator.pop(context);
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
                  height: 50,
                ),

                // Logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(
                  height: 50,
                ),

                // Title
                Text(
                  'Welcome to G.R.O.T',
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
                  height: 10,
                ),

                // Forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password?",
                        style: style.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // Sign in button
                MyButton(
                  onTap: signUserIn,
                  text: "Sign In",
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
                    const Text("Not a member?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("Register now",
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
