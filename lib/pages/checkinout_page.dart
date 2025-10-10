import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_page.dart';
import 'history_page.dart';
import 'login_page.dart';
import 'camera_page.dart';

class CheckInOutPage extends StatefulWidget {
  const CheckInOutPage({super.key});

  @override
  State<CheckInOutPage> createState() => _CheckInOutPageState();
}

class _CheckInOutPageState extends State<CheckInOutPage> {
  bool isCheckedIn = false;
  String? lastActivity;
  String? lastTime;
  String? selectedLeaveType;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String name = "Hanifa";
  String position = "Drafter";
  String company = "Arunika Saha Vikasa";

  void _toggleCheckInOut() {
    setState(() {
      final now = DateTime.now();
      final formatted = DateFormat("dd MMM yyyy • HH:mm").format(now);
      if (isCheckedIn) {
        lastActivity = "Check Out";
        lastTime = formatted;
      } else {
        lastActivity = "Check In";
        lastTime = formatted;
      }
      isCheckedIn = !isCheckedIn;
    });
  }

  Future<void> takePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Widget _leaveButton(String type) {
    bool isSelected = selectedLeaveType == type;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (isSelected) {
              selectedLeaveType = null;
              lastActivity = null;
              lastTime = null;
            } else {
              selectedLeaveType = type;
              final now = DateTime.now();
              lastActivity = type;
              lastTime = DateFormat("dd MMM yyyy • HH:mm").format(now);
              isCheckedIn = true;
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.lightGreen : Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1A237E),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF254669),
        title: const Text(
          "Absensi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "profile") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              } else if (value == "history") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()),
                );
              } else if (value == "logout") {
                _logout();
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(value: "profile", child: Text("Profile")),
                  const PopupMenuItem(
                    value: "history",
                    child: Text("Riwayat Absensi"),
                  ),
                  const PopupMenuItem(value: "logout", child: Text("Logout")),
                ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo-arunika.png",
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  position,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "|",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  company,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child:
                            _imageFile != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.camera_alt,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Belum ada foto",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    if (lastActivity != null && lastTime != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lastActivity!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            lastTime!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    else
                      const Text(
                        "Belum ada aktivitas",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 6,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final imagePath = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraPage(),
                      ),
                    );

                    if (imagePath != null) {
                      setState(() {
                        _imageFile = File(imagePath);
                        lastTime = DateFormat(
                          "dd MMM yyyy • HH:mm",
                        ).format(DateTime.now());
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF254669),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Take Picture",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 6,
              ),
              child: Row(
                children: [
                  _leaveButton("Izin"),
                  const SizedBox(width: 8),
                  _leaveButton("Cuti"),
                  const SizedBox(width: 8),
                  _leaveButton("Lembur"),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 6, 24, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      _imageFile == null 
                          ? null
                          : () {
                            _toggleCheckInOut();
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCheckedIn ? const Color.fromARGB(255, 34, 12, 10) : Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    isCheckedIn ? "Check Out" : "Check In",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
