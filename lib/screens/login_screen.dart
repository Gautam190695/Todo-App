
import 'package:flutter/material.dart';
import 'package:robust/providers/auth_provider.dart';
import 'package:robust/providers/task_provider.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();
     final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: pass, decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => auth.login(email.text, pass.text),
              child: const Text("Login"),
            ),
            ElevatedButton(
              onPressed: () => auth.signup(email.text, pass.text),
              child: const Text("Signup"),
            ),
            // ElevatedButton(
            //   onPressed: () => auth.googleLogin(),
            //   child: const Text("Google Sign-In"),
            // )
          ],
        ),
      ),
    );
  }
}
