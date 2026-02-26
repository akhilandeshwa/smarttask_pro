import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_task_pro/screens/auth_screen.dart';


void main() => runApp(SmartTaskProApp());

class SmartTaskProApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Task Pro',
      theme: ThemeData(useMaterial3: true),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// SPLASH SCREEN
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE91E63),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.agriculture, size: 120, color: Colors.white),
            SizedBox(height: 20),
            Text('Smart Task Pro', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10),
            Text('Farm to Table', style: TextStyle(fontSize: 18, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

// ONBOARDING SCREEN (Quality → Convenient → Local)
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Quality',
      'desc': 'Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain.',
      'color': Color(0xFF4CAF50),
      'image': 'assets/quality.png'
    },
    {
      'title': 'Convenient',
      'desc': 'Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.',
      'color': Color(0xFFFF9800),
      'image': 'assets/convenient.png'
    },
    {
      'title': 'Local',
      'desc': 'We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time.',
      'color': Color(0xFFFFC107),
      'image': 'assets/local.png'
    }
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) => setState(() => currentIndex = index),
        itemCount: 3,
        itemBuilder: (context, index) {
          final page = pages[index];
          return Stack(
            children: [
              // BACKGROUND PNG
              Positioned.fill(
                child: Image.asset(
                  page['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [page['color'], page['color'].withOpacity(0.6)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),
              // BOTTOM CARD
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 40,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Progress Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (i) => Container(
                          width: currentIndex == i ? 12 : 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: currentIndex == i ? Colors.black87 : Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                        )),
                      ),
                      SizedBox(height: 50),
                      // Title
                      Text(
                        page['title'],
                        style: TextStyle(fontSize: 44, fontWeight: FontWeight.w800, color: Colors.black87),
                      ),
                      SizedBox(height: 24),
                      // Description
                      Text(
                        page['desc'],
                        style: TextStyle(fontSize: 18, height: 1.5, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 48),
                      // Main Button
                      Container(
                        width: double.infinity,
                        height: 68,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [page['color'], page['color'].withOpacity(0.8)]),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: page['color'].withOpacity(0.3), blurRadius: 24, offset: Offset(0, 12))],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              if (currentIndex == 2) {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => LoginRegisterScreen())
                                );
                              } else {
                                _controller.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubic,
                                );
                              }
                            },
                            child: Center(
                              child: Text(
                                'Join the movement!',
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Login Button
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => LoginRegisterScreen())
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: page['color'], fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
