import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kids_stuff/components/my_button.dart';
import 'package:kids_stuff/components/my_inputfield.dart';
import 'package:kids_stuff/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // remove loading
        Navigator.pop(context);
        if (e.code == 'user-not-found') {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Wrong email"),
                );
              });
        } else if (e.code == 'wrong-password') {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Wrong password"),
                );
              });
        }
      }
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceVariant,
      body: SafeArea(
        child: Center(
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
                'Welcome to Kids Stuff',
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
              MyButton(onTap: signUserIn),

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
                children: const [
                  SquareTile(imagePath: 'lib/images/google.png'),
                  SizedBox(
                    width: 10,
                  ),
                  SquareTile(imagePath: 'lib/images/facebook.png')
                ],
              ),

              const SizedBox(
                height: 50,
              ),

              // register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Not a member?"),
                  SizedBox(
                    width: 4,
                  ),
                  Text("Register now",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
