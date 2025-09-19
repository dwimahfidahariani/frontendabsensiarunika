import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => CheckInPageState();
}

class CheckInPageState extends State<CheckInPage> {
  final TextEditingController companyController = TextEditingController(); // bisa diketik
  final TextEditingController positionController = TextEditingController(); // bisa diketik
  final TextEditingController nameController = TextEditingController(); // bisa diketik
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  late TextEditingController dateController;
  late TextEditingController timeController;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedTime = DateFormat('HH:mm').format(now);

    dateController = TextEditingController(text: formattedDate);
    timeController = TextEditingController(text: formattedTime);

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location service is disabled")),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    String address = "${placemarks.first.street}, ${placemarks.first.locality}";

    setState(() {
      locationController.text =
          "$address (${position.latitude}, ${position.longitude})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA1BAD2),
      appBar: AppBar(title: const Text("Check In")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            children: [
              TextField(
                controller: companyController,
                decoration: const InputDecoration(labelText: "Company"),
              ),
              TextField(
                controller: positionController,
                decoration: const InputDecoration(labelText: "Position"),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: const InputDecoration(labelText: "Date"),
              ),
              TextField(
                controller: timeController,
                readOnly: true,
                decoration: const InputDecoration(labelText: "Time"),
              ),
              const SizedBox(height: 20),

              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.black26),
                ),
                child: const Center(
                  child: Icon(Icons.location_on, size: 40, color: Colors.red),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: locationController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text(
                  "Upload File",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Check In Success")),
                  );
                },
                child: const Text("Check In"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
