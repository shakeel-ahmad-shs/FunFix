import 'package:flutter/material.dart';
import 'package:funfix/services/auth/auth_service.dart';
import 'package:funfix/components/my_button.dart';
import 'package:funfix/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  // controller for text
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  // register to go

  final void Function()? onTap;

  // login
  void login(BuildContext context) async {
    // auth services
    final authservice = AuthService();
    // catch  my errors
    try {
      await authservice.signInWithEmailPassword(
        emailcontroller.text,
        passwordcontroller.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  LoginPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // use background in surface if nit work
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).primaryColor,
            ),

            SizedBox(height: 50),
            //welcome back message
            Text(
              "Welcome Back , you´ve been missed! ",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: 25),
            //email textfld
            MyTextfield(
              hintText: "Email",
              obscureText: false,
              controller: emailcontroller,
            ),
            SizedBox(height: 10),
            //pw txtfld
            MyTextfield(
              controller: passwordcontroller,
              hintText: "Password",
              obscureText: true,
            ),

            SizedBox(height: 25),
            //login button
            MyButton(text: "login", onTap: () => login(context)),
            //registor now
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Registre now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
