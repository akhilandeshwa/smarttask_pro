import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_task_pro/screens/auth_screen.dart';  // Your login screen

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  
  // Token from OTP (your example: "895642")
  final String _token = "895642";

  Future<void> _submitPassword() async {
    if (!_formKey.currentState!.validate()) return;
    
    // Check password match
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Passwords do not match'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 🔥 EXACT RESET PASSWORD API PAYLOAD
      final payload = {
        "token": _token,  // "895642" from OTP
        "password": _newPasswordController.text.trim(),
        "cpassword": _confirmPasswordController.text.trim(),
      };

      print('🔥 RESET PASSWORD PAYLOAD: ${jsonEncode(payload)}');

      final response = await http.post(
        Uri.parse('https://swlab.com/assignment/user/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      print('🔥 RESET PASSWORD RESPONSE: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Password reset successful! Please login.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginRegisterScreen()), // Your login screen
        );
      } else {
        throw Exception('Reset failed');
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
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
                
                // Back Button + Header
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, size: 20, color: Color(0xFF6B4E31)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Reset Password',
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
                  'Enter your new password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9B7A5A),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60),

                // New Password Field
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter new password';
                    if (value.length < 6) return 'Password must be 6+ characters';
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'New Password *',
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF9B7A5A)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF9B7A5A),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Color(0xFFE67E22)),
                    ),
                  ),
                ),
                
                SizedBox(height: 16),

                // Confirm Password Field
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirm password';
                    if (value != _newPasswordController.text) return 'Passwords do not match';
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm Password *',
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF9B7A5A)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF9B7A5A),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Color(0xFFE67E22)),
                    ),
                  ),
                ),
                
                SizedBox(height: 40),

                // Submit Button
                GestureDetector(
                  onTap: _isLoading ? null : _submitPassword,
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
                    child: Material(
                      color: Colors.transparent,
                      child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
