import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username / Password tidak boleh kosong")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4989C6),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
    
                const Text( 
                  "LOGO", 
                  style: TextStyle( 
                    fontSize: 40, 
                    fontWeight: FontWeight.bold, 
                    letterSpacing: 3, 
                    ), 
                  ), 
                  const SizedBox(height: 10),

                const Text(
                  "Online Attendance Application",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDEE0E4),
                  ),
                ),
                const SizedBox(height: 5),

                const Text(
                  "Login using your company employee account",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFDEE0E4),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(color: Color(0xFFDEE0E4)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFDEE0E4)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFDEE0E4)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Color(0xFFDEE0E4)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFDEE0E4)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFDEE0E4)),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 12, color: Color(0xFFDEE0E4)),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black),
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
