import 'package:flutter/material.dart';
import 'package:smart_task_pro/screens/verification1.dart';

class BusinessHoursScreen extends StatefulWidget {
  @override
  _BusinessHoursScreenState createState() => _BusinessHoursScreenState();
}

class _BusinessHoursScreenState extends State<BusinessHoursScreen> {
  List<bool> daySelected = [false, false, true, false, false, false, false]; // W selected
  List<bool> timeSlotsSelected = [true, true, false, false, false]; // First 2 selected

  final days = ['M', 'T', 'W', 'T', 'F', 'S', 'Su'];
  final timeSlots = ['8:00am - 10:00am', '10:00am - 1:00pm', '1:00pm - 4:00pm', '4:00pm - 7:00pm', '7:00pm - 10:00pm'];

  // Helper method - defined BEFORE build()
  Widget _buildTimeSlot(int index, bool isSelected) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFFFD700) : Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Color(0xFFFFD700) : Color(0xFFE8E8E8),
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        timeSlots[index],
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? Colors.black87 : Colors.black54,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

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
                Row(
                  children: [
                  
                    const SizedBox(width: 8),
                    const Text(
                      'FarmerEats',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                 SizedBox(height: 16),
              Text(
                'Business Hours',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Choose hours your farm is open for pickups.\nThis will allow customers to order deliveries.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 32),

              // Days row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: days.asMap().entries.map((entry) {
                    int index = entry.key;
                    return Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          daySelected[index] = !daySelected[index];
                        }),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          decoration: BoxDecoration(
                            color: daySelected[index] ? Color(0xFFFF4D4D) : Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: daySelected[index] ? Color(0xFFFF4D4D) : Color(0xFFE0E0E0),
                              width: 2,
                            ),
                            boxShadow: daySelected[index]
                                ? [BoxShadow(color: Color(0x1AFFFF4D), blurRadius: 8, spreadRadius: 0)]
                                : [],
                          ),
                          child: Text(
                            days[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: daySelected[index] ? FontWeight.bold : FontWeight.w500,
                              color: daySelected[index] ? Colors.white : Color(0xFF666666),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 40),

             

              // Time slot buttons
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => timeSlotsSelected[0] = !timeSlotsSelected[0]),
                          child: _buildTimeSlot(0, timeSlotsSelected[0]),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => timeSlotsSelected[1] = !timeSlotsSelected[1]),
                          child: _buildTimeSlot(1, timeSlotsSelected[1]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => timeSlotsSelected[2] = !timeSlotsSelected[2]),
                          child: _buildTimeSlot(2, timeSlotsSelected[2]),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => timeSlotsSelected[3] = !timeSlotsSelected[3]),
                          child: _buildTimeSlot(3, timeSlotsSelected[3]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => setState(() => timeSlotsSelected[4] = !timeSlotsSelected[4]),
                    child: _buildTimeSlot(4, timeSlotsSelected[4]),
                  ),
                ],
              ),

              Spacer(),

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
        MaterialPageRoute(builder: (context) => Verification1Screen()),
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
}
