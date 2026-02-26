import 'package:flutter/material.dart';
import 'package:smart_task_pro/screens/confirmation.dart';
// Remove dart:io import - not needed for demo

class Verification1Screen extends StatefulWidget {
  @override
  _Verification1ScreenState createState() => _Verification1ScreenState();
}

class _Verification1ScreenState extends State<Verification1Screen> {
  String? selectedFileName; // Changed from File? to String? for demo
  bool hasFile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top header
              Row(
                children: [
                  const SizedBox(width: 8),
                  const Text(
                    'FarmerEats',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Title
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 32),

              // Subtitle text
              Text(
                'Attached proof of Department of Agriculture\nregistration (e.g., Florida Fresh Ag, USDA\nOrganic registration)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 32),

              // Attach button section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text + Orange Camera Row
                  Row(
                    children: [
                      Expanded(
                        child: const Text(
                          'Attach proof of registration',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _pickImage(), // ✅ FIXED: Call correct method
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B35),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // ✅ ADDED: File preview when selected
                  if (hasFile && selectedFileName != null) ...[
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3F3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFFFD1D1)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedFileName!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() {
                              selectedFileName = null;
                              hasFile = false;
                            }),
                            child: Icon(Icons.close, color: Colors.red, size: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),

              Spacer(),

              // Bottom navigation
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Back Button (Left side)
    Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 18,
        ),
        onPressed: () => Navigator.pop(context),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    ),
    
    // Continue Button (Right side)
      Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Back Button (Left side)
   
    
    // Continue Button (Right side)
   SizedBox(
  height: 48,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountSetupSuccessScreen()),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF6B35),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    child: const Text('Continue'),
  ),
),

  ],
),


  ],
),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ FIXED: Proper method name and implementation
  void _pickImage() {
    setState(() {
      selectedFileName = 'usda_regist.pdf'; // Demo file
      hasFile = true;
    });
  }

  void _submit() {
    print('Submitting verification with file: $selectedFileName');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification submitted successfully!')),
    );
  }
}
