import 'package:flutter/material.dart';
import 'package:smart_task_pro/screens/verification.dart';

class FarmInfoScreen extends StatefulWidget {
  @override
  _FarmInfoScreenState createState() => _FarmInfoScreenState();
}

class _FarmInfoScreenState extends State<FarmInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedState;  // ✅ MOVED TO TOP

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
                
                // Farm Info Title
                Text(
                  'Farm Info',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Business Name
                _textField('Business Name', Icons.business_outlined),
                const SizedBox(height: 20),
                
                // Informal Name
                _textField('Informal Name', Icons.account_circle_outlined),
                const SizedBox(height: 20),
                
                // Street Address
                _textField('Street Address', Icons.home_outlined),
                const SizedBox(height: 20),
                _textField('City', Icons.location_city_outlined),
const SizedBox(height: 20),
                // City & State/Zipcode Row
                // Row(
                //   children: [
                //     Expanded(child: _textField('City', Icons.location_city_outlined)),
                //     const SizedBox(width: 12),
                //     Expanded(child: _dropdownField('State')),
                //     const SizedBox(width: 12),
                //     SizedBox(width: 100, child: _textField('Zipcode', Icons.local_post_office_outlined)),
                //   ],
                // ),
             // City (Full width)


// State + Zipcode (FIXED - Text fully visible)
LayoutBuilder(
  builder: (context, constraints) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _dropdownField('State'),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: constraints.maxWidth > 500 ? 140 : 
                 constraints.maxWidth > 360 ? 120 : 105,
          child: _textField('Zipcode', Icons.local_post_office_outlined),
        ),
      ],
    );
  },
),



                const SizedBox(height: 60),
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
   SizedBox(
  height: 48,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerificationScreen()),
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
  
  Widget _textField(String label, IconData icon, {TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFFF6B35)),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF6B35), width: 2),
        ),
      ),
    );
  }
  
  Widget _dropdownField(String label) {
    return DropdownButtonFormField<String>(
      value: selectedState,  // ✅ FIXED: Added value
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFFFF6B35)),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF6B35), width: 2),
        ),
      ),
      items: ['Andhra Pradesh', 'Telangana', 'Karnataka', 'Tamil Nadu']
          .map((state) => DropdownMenuItem(
                value: state, 
                child: Text(state)
              ))
          .toList(),
      onChanged: (String? newValue) {  // ✅ FIXED: Added onChanged
        setState(() {
          selectedState = newValue;
        });
      },
    );
  }
  
  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Farm info saved!')),
      );
    }
  }
}
