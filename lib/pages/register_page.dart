import 'package:flutter/material.dart';
import 'package:funfix/services/auth/auth_service.dart';
import 'package:funfix/components/my_button.dart';
import 'package:funfix/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  // controller for text
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();
  // login to go

  final void Function()? onTap;

  // register
  void register(BuildContext context) {
    final auth = AuthService();

    if (passwordcontroller.text == confirmpasswordcontroller.text) {
      try {
        auth.signUpWithEmailPassword(
          emailcontroller.text,
          passwordcontroller.text,
        );
      } catch (e) {
        throw Exception(
          showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(e.toString())),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password and confirm password don't match"),
        ),
      );
    }
  }

  RegisterPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Lets create an a Account for you ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            //email textfld
            MyTextfield(
              keyboardType: TextInputType.emailAddress,
              hintText: "Email",
              obscureText: false,
              controller: emailcontroller,
            ),
            SizedBox(height: 10),
            MyTextfield(
              keyboardType: TextInputType.text,
              hintText: "Password",
              obscureText: true,
              controller: passwordcontroller,
            ),
            SizedBox(height: 10),
            //cpw txtfld
            MyTextfield(
              keyboardType: TextInputType.text,
              controller: confirmpasswordcontroller,
              hintText: "Confirm Password",
              obscureText: true,
            ),

            SizedBox(height: 25),
            //login button
            MyButton(text: "Register", onTap: () => register(context)),
            //registor now
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an a Account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "login now",
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
