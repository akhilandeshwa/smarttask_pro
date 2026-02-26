import 'package:flutter/material.dart';
import 'package:smart_task_pro/screens/businesshours.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hasImage1 = false;
  bool _hasImage2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button
               Row(
                  children: [
                  
                    const SizedBox(width: 8),
                    const Text(
                      'FarmerEats',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                
                const SizedBox(height: 40),
                
                // Verification Title
                const Text(
                  'Verification',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                
                const SizedBox(height: 32),
                
                // First Document Section (Full upload area)
                _documentSection(
                  'Attach proof of Department of Agriculture registration (e.g. Florida Fresh USDA, USDA Organic)',
                  _hasImage1,
                  () => _pickImage(1),
                ),
                const SizedBox(height: 24),
                
                // Second Document Section (Text + Camera button)
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
                          onTap: () => _pickImage(2),
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
                  ],
                ),
                
                const SizedBox(height: 60),
                
                // Continue Button
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
        MaterialPageRoute(builder: (context) => BusinessHoursScreen()),
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
 
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _documentSection(String title, bool hasImage, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
       ],
    );
  }
  
  void _pickImage(int index) {
    setState(() {
      if (index == 1) _hasImage1 = true;
      if (index == 2) _hasImage2 = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image picker for document $index')),
    );
  }
  
  void _onContinue() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification complete!')),
    );
  }
}
