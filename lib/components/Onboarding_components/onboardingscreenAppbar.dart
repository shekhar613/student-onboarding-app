import 'package:flutter/material.dart';

class Onboardingscreenappbar extends StatelessWidget
    implements PreferredSizeWidget {
  const Onboardingscreenappbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(10),
        // color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "PERSONALIZING YOUR PLAN",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Steps 2 of 20",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.2,
                minHeight: 8,
                borderRadius: BorderRadius.circular(20),
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
