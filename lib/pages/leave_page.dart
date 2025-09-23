import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => LeavePageState();
}

class LeavePageState extends State<LeavePage> {
  final TextEditingController companyController =
      TextEditingController(text: ""); 
  final TextEditingController positionController =
      TextEditingController(text: ""); 
  final TextEditingController nameController =
      TextEditingController(text: ""); 
  final TextEditingController startDateController = 
      TextEditingController();
  final TextEditingController endDateController = 
      TextEditingController();
  final TextEditingController reasonController = 
      TextEditingController();

  Future<void> _pickDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF254669),
      appBar: AppBar(title: const Text("Leave Request")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            
            TextField(
              controller: companyController,
              decoration: const InputDecoration(labelText: "Company", labelStyle: TextStyle(color: Color(0xFFDEE0E4))),
              style: TextStyle(color: Color(0xFFDEE0E4)),
            ),
            
            TextField(
              controller: positionController,
              decoration: const InputDecoration(labelText: "Position", labelStyle: TextStyle(color: Color(0xFFDEE0E4))),
              style: TextStyle(color: Color(0xFFDEE0E4)),
            ),
            
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name", labelStyle: TextStyle(color: Color(0xFFDEE0E4))),
              style: TextStyle(color: Color(0xFFDEE0E4)),
            ),
            
            TextField(
              controller: startDateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Start Date",
                labelStyle: TextStyle(color: Color(0xFFDEE0E4)),
                suffixIcon: Icon(Icons.calendar_today, color: Color(0xFFDEE0E4)),
              ),
              style: TextStyle(color: Color(0xFFDEE0E4)),
              onTap: () => _pickDate(startDateController),
            ),
          
            TextField(
              controller: endDateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "End Date",
                labelStyle: TextStyle(color: Color(0xFFDEE0E4)),
                suffixIcon: Icon(Icons.calendar_today, color: Color(0xFFDEE0E4)),
              ),
              style: TextStyle(color: Color(0xFFDEE0E4)),
              onTap: () => _pickDate(endDateController),
            ),
            
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Reason", 
                labelStyle: TextStyle(color: Color(0xFFDEE0E4)),
                ),
              style: TextStyle(color: Color(0xFFDEE0E4)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Leave Request Submitted")),
                );
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
