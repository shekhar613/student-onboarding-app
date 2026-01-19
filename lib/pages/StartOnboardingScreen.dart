import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_onboarding/Onboarding/onboardingScreen.dart';

class Startonboardingscreen extends StatefulWidget {
  @override
  State<Startonboardingscreen> createState() => StartonboardingscreenState();
}

class StartonboardingscreenState extends State<Startonboardingscreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF5FD),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Image
                        Container(
                          height: 220,
                          width: width * 0.6,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/Images/bg.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// Title
                        const Text(
                          "Unlock Your Potential",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// Subtitle
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6B7280),
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "Create a personalized study plan tailored to your goals in just ",
                              ),
                              TextSpan(
                                text: "2 minutes.",
                                style: TextStyle(
                                  color: Color(0xFF2563EB),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        /// Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Onboardingscreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                100,
                                149,
                                255,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Get Started",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// Page Indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _dot(isActive: true),
                            _dot(),
                            _dot(),
                            _dot(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Login Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),
                    Text(
                      "Log in",
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.w600,
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

  Widget _dot({bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 18 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF2563EB) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
