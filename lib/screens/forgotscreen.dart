import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'otpverification.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleForgotPassword() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      final phoneNumber = '+91${phoneController.text.trim()}';
      final payload = {"mobile": phoneNumber};

      print('🔥 FORGOT PASSWORD PAYLOAD: ${jsonEncode(payload)}');

      final response = await http.post(
        Uri.parse('https://swlab.com/assignment/user/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      print('🔥 FORGOT PASSWORD RESPONSE: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP sent to $phoneNumber!'), backgroundColor: Colors.green),
        );
        // ✅ FIXED - No phone parameter needed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OTPVerificationScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP'), backgroundColor: Colors.red),
        );
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
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    SizedBox(width: 8),
                    Text(
                      'FarmerEats',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 60),

                // Title + Back
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, size: 20, color: Color(0xFF6B4E31)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D1B14),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 40),
                
                // Subtitle
                Text(
                  'Enter your phone number to receive OTP',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9B7A5A),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60),

                // Phone Input Container
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Country Code
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.flag, size: 20, color: Color(0xFF9B7A5A)),
                            SizedBox(width: 8),
                            Text('+91', style: TextStyle(color: Color(0xFF9B7A5A), fontWeight: FontWeight.w500)),
                            Icon(Icons.arrow_drop_down, color: Color(0xFF9B7A5A)),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      // Phone Number Input
                      Expanded(
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter phone number';
                            }
                            if (value.length < 10) {
                              return 'Enter valid phone number';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 18),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 40),

                // Send Code Button
                GestureDetector(
                  onTap: _isLoading ? null : _handleForgotPassword,
                  child: Container(
                    width: double.infinity,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFFE67E22), Color(0xFFFD7E14)]),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE67E22).withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Send Code',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: 60),
                
                // Back to Login
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Remember your password? Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9B7A5A),
                      fontWeight: FontWeight.w500,
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
