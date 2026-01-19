import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_onboarding/components/Onboarding_components/onboardingscreenAppbar.dart';

class Onboardingscreen extends StatefulWidget {
  @override
  State<Onboardingscreen> createState() => OnboardingscreenState();
}

class OnboardingscreenState extends State<Onboardingscreen> {
  @override
  Widget build(BuildContext context) {
    final bool selected = true;
    final Color primaryBlue = Colors.blue;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: Onboardingscreenappbar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.rocket_launch,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "What is your primary study goal?",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  optioncard(
                    true,
                    primaryBlue,
                    "Ace my upcoming exams",
                    "Focused prep for high-stakes tests",
                  ),
                  const SizedBox(height: 20),
                  optioncard(
                    false,
                    primaryBlue,
                    "Master a new skill",
                    "Developing specific capabilities",
                  ),
                  const SizedBox(height: 20),
                  optioncard(
                    false,
                    primaryBlue,
                    "Build daily habits",
                    "Consistency in lifelong learning",
                  ),
                  const SizedBox(height: 20),
                  optioncard(
                    false,
                    primaryBlue,
                    "Improve my grades overall",
                    "Better academic performance",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 90,
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  foregroundColor: Colors.white, // Text color
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Continue", style: TextStyle(fontSize: 18)),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  "You can update your goal at any time in settings.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container optioncard(
    bool selected,
    Color primaryBlue,
    String option,
    String subTitle,
  ) {
    bool isSelected = selected;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? primaryBlue : Colors.grey.shade300,
          width: 1.5,
        ),
        color: isSelected
            ? const Color.fromARGB(255, 247, 252, 255)
            : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Radio
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isSelected ? primaryBlue : Colors.grey,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  option,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subTitle,
                  style: TextStyle(fontSize: 13, color: Colors.blue.shade300),
                ),
              ],
            ),
          ),

          // Right icon
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.school_outlined,
              size: 20,
              color: Colors.blue.shade200,
            ),
          ),
        ],
      ),
    );
  }
}
