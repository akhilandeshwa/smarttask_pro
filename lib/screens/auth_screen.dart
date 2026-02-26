import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'forgotscreen.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  bool _isLogin = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _informalNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  String _deviceToken = '0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _businessNameController.dispose();
    _informalNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleAuth() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      if (_isLogin) {
        await _handleLogin();
      } else {
        await _handleRegister();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogin() async {
    // 🔥 EXACT LOGIN PAYLOAD
    final payload = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text,
      "role": "farmer",
      "device_token": _deviceToken,
      "type": "email",
      "social_id": _deviceToken
    };

    print('🔥 LOGIN PAYLOAD: ${jsonEncode(payload)}');

    final response = await http.post(
      Uri.parse('https://swlab.com/assignment/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    print('🔥 LOGIN RESPONSE: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login SUCCESS!'), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SuccessScreen()));
      }
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<void> _handleRegister() async {
    // 🔥 EXACT REGISTER PAYLOAD
    final payload = {
      "full_name": _fullNameController.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _phoneController.text.trim(),
      "password": _passwordController.text,
      "role": "farmer",
      "business_name": _businessNameController.text.trim(),
      "informal_name": _informalNameController.text.trim(),
      "address": _addressController.text.trim(),
      "city": _cityController.text.trim(),
      "state": _stateController.text.trim(),
      "zip_code": int.parse(_zipCodeController.text.trim()),
      "registration_proof": "my_proof.pdf",
      "business_hours": {
        "mon": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "tue": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "wed": ["8:00am - 10:00am", "10:00am - 1:00pm", "1:00pm - 4:00pm"],
        "thu": ["8:00am - 10:00am", "10:00am - 1:00pm", "1:00pm - 4:00pm"],
        "fri": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "sat": ["8:00am - 10:00am", "10:00am - 1:00pm"],
        "sun": ["8:00am -10:00am"]
      },
      "device_token": _deviceToken,
      "type": "email",
      "social_id": _deviceToken
    };

    print('🔥 REGISTER PAYLOAD: ${jsonEncode(payload)}');

    final response = await http.post(
      Uri.parse('https://swlab.com/assignment/user/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    print('🔥 REGISTER RESPONSE: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Register SUCCESS! Please login.'), backgroundColor: Colors.green),
        );
        setState(() => _isLogin = true); // Switch to login
      }
    } else {
      throw Exception('Register failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 50),
                Icon(Icons.agriculture, size: 80, color: Colors.redAccent),
                SizedBox(height: 20),
                Text(
                  _isLogin ? 'Welcome Back!' : 'Join FarmerEats',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  _isLogin ? 'Sign in to continue' : 'Complete your farmer profile',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 40),

                // FIELDS
                if (!_isLogin) ...[
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name *',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 16),
                ],

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email *',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                    if (!value.contains('@')) return 'Valid email required';
                    return null;
                  },
                ),
                SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password *',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                    if (value.length < 6) return 'Min 6 characters';
                    return null;
                  },
                ),

                if (!_isLogin) ...[
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone *',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _businessNameController,
                    decoration: InputDecoration(
                      labelText: 'Business Name *',
                      prefixIcon: Icon(Icons.store),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _informalNameController,
                    decoration: InputDecoration(
                      labelText: 'Informal Name',
                      prefixIcon: Icon(Icons.label),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            labelText: 'City',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _zipCodeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'ZIP *',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) return 'Required';
                            if (int.tryParse(value) == null) return 'Valid ZIP';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: 30),

                // BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _isLoading ? null : _handleAuth,
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            _isLogin ? 'LOGIN' : 'REGISTER',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),

                SizedBox(height: 20),

                // Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_isLogin ? "Don't have account?" : "Have account?"),
                    TextButton(
                      onPressed: _isLoading ? null : () => setState(() => _isLogin = !_isLogin),
                      child: Text(
                        _isLogin ? 'Register' : 'Login',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen())),
                  child: Text('Forgot Password?', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[400]!, Colors.green[600]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, size: 120, color: Colors.white),
              SizedBox(height: 30),
              Text('SUCCESS!', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 10),
              Text('API Integration Complete ✅', style: TextStyle(fontSize: 18, color: Colors.white70)),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.green[600]),
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: Text('Done', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
