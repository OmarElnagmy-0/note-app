import 'package:flutter/material.dart';
import 'package:notes_app/data/services/login_shared_preference.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login-image.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Welcome Back! 👋",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Today is a new day. Start your day with us. Sign in to continue.",
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            const SizedBox(height: 30),
            Text(
              "Email",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Example@email.com",
                hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "At least 8 characters",
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot Password?",
                style: TextStyle(fontSize: 18, color: Colors.blue[800]),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (isDataValid(emailController, passwordController)) {
                  await AuthService.logIn();
                  // Navigator.pushNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Invalid email or password!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.brown[700],
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Sign In"),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  ),
                  Text(
                    "  Sign up",
                    style: TextStyle(fontSize: 18, color: Colors.blue[800]),
                  ),
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Text(
                "© 2025 All rights reserved.",
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool isDataValid(
  TextEditingController emailController,
  TextEditingController passwordController,
) {
  if (emailController.text == 'admin' && passwordController.text == 'admin') {
    return true;
  } else {
    return false;
  }
}
