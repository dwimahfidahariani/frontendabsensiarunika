import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF254669),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text("Nama: Hanifa", style: TextStyle(fontSize: 16)),
            Text("Jabatan: Drafter", style: TextStyle(fontSize: 16)),
            Text("Perusahaan: Arunika Saha Vikasa", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("Email: xxx@example.com", style: TextStyle(fontSize: 16)),
            Text("No HP: 08xxxxxxxxxx", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
