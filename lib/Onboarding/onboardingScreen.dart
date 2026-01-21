import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:student_onboarding/components/Onboarding_components/onboardingscreenAppbar.dart';

class Onboardingscreen extends StatefulWidget {
  @override
  State<Onboardingscreen> createState() => OnboardingscreenState();
}

class OnboardingscreenState extends State<Onboardingscreen> {
  Map<String, dynamic>? jsonData;
  bool isUserNew = true;
  late SharedPreferences prefs;
  int currentQuestionIndex = 0;
  int currentOptionSelectedIndex = 0;
  int totalQuestions = 0;
  // user form data
  final TextEditingController nameController = TextEditingController();

  String? selectedCourse;
  String? selectedYear;

  final List<String> courses = ['IMCA', 'BCA', 'MCA', 'Bsc'];

  final List<String> years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];

  Future<void> _createUser() async {
    print("User : ${nameController.text} from $selectedCourse $selectedYear");
    Map<String, dynamic> userData = {
      "name": nameController.text,
      "course": selectedCourse,
      "year": selectedYear,
      "onboardingCompleted": false,
      "currentQuestionIndex": 0,
    };
    String jsonString = jsonEncode(userData);
    print(jsonString);
    await prefs.setString('user_data', jsonString);
    setState(() {
      isUserNew = false;
    });
  }

  //

  @override
  void initState() {
    super.initState();
    _init();
    // print(jsonData);
  }

  Future<void> _init() async {
    await _loadSharedPreferencesData();
    await loadJson();
  }

  Future<void> loadJson() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/onboarding-questions.json',
    );
    final data = json.decode(jsonString) as Map<String, dynamic>;

    setState(() {
      jsonData = data;
      totalQuestions = jsonData!["totalQuestions"];
    });
  }

  Future<void> _loadSharedPreferencesData() async {
    prefs = await SharedPreferences.getInstance();
    // daysComplete = prefs.getInt("flutterChallengeDaysCount") ?? 0;

    setState(() {});
    print("reloaded...................");
  }

  /// set currently selected option
  Future<void> selectedOption(int queId, int optionIndex) async {
    prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < 4; i++) {
      if (i == optionIndex) {
        currentOptionSelectedIndex = optionIndex;
        await prefs.setBool('question$queId&option$optionIndex', true);
      } else {
        await prefs.setBool('question$queId&option$i', false);
      }
    }

    setState(() {
      // isRead = true;
    });
  }

  bool _checkIsSelectedOption(int queId, int optionIndex) {
    final key = 'question$queId&option$optionIndex';

    if (prefs.containsKey(key)) {
      return prefs.getBool(key) ?? false;
    }

    return false; // always return a bool
  }

  // continue buton of onboarding
  void nextQuestion() {
    if (currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      if (prefs.containsKey("user_data")) {
        String? jsonString = prefs.getString("user_data");
        Map<String, dynamic> userData = jsonDecode(jsonString!);
        print(
          "before data when click on contine button \n$jsonString \n and \n $userData",
        );
        userData['currentQuestionIndex'] = currentQuestionIndex;

        print(
          "After data when click on contine button \n$jsonString \n and \n $userData",
        );
      }
    }
  }

  // save data to firebase
  Future<void> saveData() async {}

  @override
  Widget build(BuildContext context) {
    final bool selected = true;
    final Color primaryBlue = Colors.blue;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    if (jsonData == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: Onboardingscreenappbar(
          currentQuestion: currentQuestionIndex + 1,
          totalQuestion: totalQuestions,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: isUserNew ? _userDetails() : _onboardingQuestions(primaryBlue),
        ),
        bottomNavigationBar: isUserNew ? SizedBox() : _bottomButtonSection(),
      ),
    );
  }

  Widget _bottomButtonSection() {
    return Container(
      height: 90,
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button color
              foregroundColor: Colors.white, // Text color
              elevation: 5,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              nextQuestion();
            },
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
            child: Text("You can update your goal at any time in settings."),
          ),
        ],
      ),
    );
  }

  Widget _userDetails() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Basic Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tell us a bit about yourself to help\ncustomize your study journey.',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),

                      /// Full Name
                      const Text('Full Name'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'John Doe',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Course
                      const Text('Course'),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: selectedCourse,
                        hint: const Text('Select your course'),
                        items: courses
                            .map(
                              (course) => DropdownMenuItem(
                                value: course,
                                child: Text(course),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCourse = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Year of Study
                      const Text('Year of Study'),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: selectedYear,
                        hint: const Text('Select current year'),
                        items: years
                            .map(
                              (year) => DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedYear = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F66B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            // Handle continue
                            _createUser();
                          },
                          child: const Text(
                            'Continue →',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// Back
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('‹ Back'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Your data is used only to personalize your learning\nexperience and will not be shared.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _onboardingQuestions(Color primaryBlue) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: Container(
        key: ValueKey(currentQuestionIndex),
        margin: EdgeInsets.only(left: 20, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  const Spacer(),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.restart_alt,
                          color: const Color.fromARGB(255, 255, 0, 0),
                          size: 28,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                jsonData!["questions"][currentQuestionIndex]['question'],
                key: ValueKey(currentQuestionIndex),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                    jsonData!["questions"][currentQuestionIndex]['options']
                        .length,
                itemBuilder: (context, index) {
                  return optioncard(
                    _checkIsSelectedOption(
                      jsonData!["questions"][currentQuestionIndex]['id'],
                      index,
                    ),
                    primaryBlue,
                    jsonData?["questions"][currentQuestionIndex]['options'][index]['text'],
                    jsonData?["questions"][currentQuestionIndex]['options'][index]['subtitle'],
                    jsonData!["questions"][currentQuestionIndex]['id'],
                    index,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget optioncard(
    bool isSelected,
    Color primaryBlue,
    String option,
    String subTitle,
    int queId,
    int optionIndex,
  ) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(16),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? primaryBlue : Colors.grey,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.school_outlined, size: 20, color: Colors.blue.shade200),
          ],
        ),
      ),
      onTap: () {
        selectedOption(queId, optionIndex);
      },
    );
  }
}
