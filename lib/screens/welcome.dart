import 'package:flutter/material.dart';
import 'package:smart_task_pro/screens/farminfo.dart';

class FarmerEatsSignupScreen extends StatefulWidget {
  @override
  _FarmerEatsSignupScreenState createState() => _FarmerEatsSignupScreenState();
}

class _FarmerEatsSignupScreenState extends State<FarmerEatsSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                // App bar-like title
                Row(
                  children: [
                    const SizedBox(width: 8),
                    const Text(
                      'FarmerEats',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Welcome text
                const Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
               
                const SizedBox(height: 40),
                // Social login buttons
Row(
  children: [
    Expanded(child: _socialIconButton(Colors.blue, Icons.g_mobiledata)),
    const SizedBox(width: 16),
    Expanded(child: _socialIconButton(Colors.black, Icons.apple)),
    const SizedBox(width: 16),
    Expanded(child: _socialIconButton(Colors.blue, Icons.facebook)),
  ],
),

                const SizedBox(height: 32),
                // Or text
                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: Colors.grey[300])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('or sign up with', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                    ),
                    Expanded(child: Container(height: 1, color: Colors.grey[300])),
                  ],
                ),
                const SizedBox(height: 32),
                // Form fields
                _textField('Full Name', Icons.person_outline, _nameController),
                const SizedBox(height: 20),
                _textField('Email Address', Icons.email_outlined, _emailController),
                const SizedBox(height: 20),
                _textField('Phone Number', Icons.phone_outlined, _phoneController),
                const SizedBox(height: 20),
                _textField('Password', Icons.lock_outline, _passwordController, obscureText: true),
                const SizedBox(height: 20),
                _textField('Re-enter Password', Icons.lock_outline, _confirmPasswordController, obscureText: true),
                const SizedBox(height: 40),
                // Login and Continue buttons
                // Login (TEXT with underline - NO BUTTON)
Row(
  children: [
    // Login Text (Left side)
    Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Login',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: Colors.grey[600],
              decorationThickness: 1.5,
            ),
          ),
        ),
      ),
    ),
    
    // 50px GAP
    SizedBox(width: 50),
    
    // Continue Button (Right side)
   SizedBox(
  height: 48,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FarmInfoScreen()),
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
          ),
        ),
      ),
    );
  }

  Widget _socialIconButton(Color iconColor, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey[300]!),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Icon(icon, color: iconColor, size: 28),
  );
}


  Widget _textField(String label, IconData icon, TextEditingController controller, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter $label';
        if (label.contains('Email') && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter valid email';
        }
        if (label.contains('Password') && value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (label.contains('Re-enter') && value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
    );
  }

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      // Handle signup logic
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signup successful!')));
    }
  }
}
