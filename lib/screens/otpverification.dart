import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_task_pro/screens/resetpassword.dart';

class OTPVerificationScreen extends StatefulWidget {
  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
  late List<FocusNode> focusNodes;
  bool isResendVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(6, (_) => FocusNode());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) controller.dispose();
    for (var focusNode in focusNodes) focusNode.dispose();
    super.dispose();
  }

  Future<void> _verifyOTP() async {
    String otp = controllers.map((c) => c.text).join();
    
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter 6-digit OTP'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 🔥 EXACT VERIFY OTP API PAYLOAD
      final payload = {
        "otp": otp,  // "895642"
      };

      print('🔥 VERIFY OTP PAYLOAD: ${jsonEncode(payload)}');

      final response = await http.post(
        Uri.parse('https://swlab.com/assignment/user/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      print('🔥 VERIFY OTP RESPONSE: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ OTP Verified Successfully!'), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
        );
      } else {
        throw Exception('Invalid OTP');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  const Text(
                    'FarmerEats',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 60),
              
              // Header
              Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF2D1B14)),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 40),
              
              // OTP Instruction
              Text(
                'Enter 6-digit code sent to your phone',
                style: TextStyle(fontSize: 16, color: Color(0xFF6B4E31)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              
              // 6 OTP Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 56,
                    height: 68,
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFE67E22), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          if (index < 5) {
                            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                          } else {
                            _verifyOTP();
                          }
                        }
                      },
                    ),
                  );
                }),
              ),
              
              SizedBox(height: 60),
              
              // Submit + Resend UI
              Column(
                children: [
                  // Submit Button
                  GestureDetector(
                    onTap: _isLoading ? null : _verifyOTP,
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xFFE67E22), Color(0xFFFD7E14)]),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFE67E22).withOpacity(0.3),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                                ),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Resend Code Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Back to forgot password
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1.5)
                        )
                      ),
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
