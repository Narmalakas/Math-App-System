import 'package:flutter/material.dart';

class Lvl1AddingSimpleFractions extends StatefulWidget {
  const Lvl1AddingSimpleFractions({super.key});

  @override
  State<Lvl1AddingSimpleFractions> createState() => _Lvl1AddingSimpleFractionsState();
}

class _Lvl1AddingSimpleFractionsState extends State<Lvl1AddingSimpleFractions> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Track which sub-lesson the user is currently playing
  // 1 = Without Regrouping, 2 = With Regrouping in the Sum, 3 = Simple Fractions & Mixed Numbers with Regrouping
  int _currentLessonModule = 1;

  // Game Runtime States
  List<Map<String, dynamic>> _activeQuestions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _lives = 5; 
  bool _hasAnswered = false;
  int _selectedAnswerIndex = -1;

  // --- LESSON 1 POOL (Without Regrouping) ---
  final List<Map<String, dynamic>> _lesson1Pool = [
    {"type": "drill", "num1": 1, "den1": 3, "num2": 5, "den2": 9, "text": "Add the fractions and simplify if needed:", "options": ["6/9", "8/9", "5/9", "2/3"], "correct": "8/9"},
    {"type": "drill", "num1": 2, "den1": 4, "num2": 3, "den2": 8, "text": "Find the sum in lowest terms:", "options": ["5/8", "6/8", "7/8", "1/2"], "correct": "7/8"},
    {"type": "drill", "num1": 4, "den1": 10, "num2": 1, "den2": 5, "text": "Add and reduce to simplest form:", "options": ["5/10", "3/5", "6/10", "2/5"], "correct": "3/5"},
    {"type": "drill", "num1": 1, "den1": 6, "num2": 3, "den2": 6, "text": "Identify the total sum value:", "options": ["4/12", "2/6", "4/6", "5/6"], "correct": "4/6"},
    {"type": "drill", "num1": 2, "den1": 5, "num2": 2, "den2": 5, "text": "Add the similar fractions:", "options": ["4/10", "4/5", "0/5", "1/5"], "correct": "4/5"},
    {"type": "drill", "num1": 3, "den1": 12, "num2": 5, "den2": 12, "text": "Find the direct summation result:", "options": ["8/24", "2/12", "8/12", "7/12"], "correct": "8/12"},
    {"type": "drill", "num1": 1, "den1": 2, "num2": 1, "den2": 4, "text": "Compute the sum using common denominators:", "options": ["2/6", "3/4", "2/4", "1/4"], "correct": "3/4"},
    {"type": "word_problem", "text": "Analie worked in her backyard garden. If she worked 2/7 hour on Saturday and 3/7 hour on Sunday, how many hours did she work in two days?", "options": ["5/14 hours", "6/7 hours", "5/7 hours", "1 hour"], "correct": "5/7 hours"},
    {"type": "word_problem", "text": "Michelle spent 2/6 hour on Monday and 3/6 hour on Tuesday reading short stories. How many hours did she spend reading in total?", "options": ["5/6 hours", "5/12 hours", "1/6 hours", "1 hour"], "correct": "5/6 hours"},
    {"type": "word_problem", "text": "John ate 1/8 of a whole pizza in the afternoon, and Sarah finished another 3/8 of it in the evening. How much did they consume altogether?", "options": ["4/16 of the pizza", "1/2 of the pizza", "3/8 of the pizza", "5/8 of the pizza"], "correct": "1/2 of the pizza"}
  ];

  // --- LESSON 2 POOL (With Regrouping in the Sum) ---
  final List<Map<String, dynamic>> _lesson2Pool = [
    {"type": "drill", "num1": 7, "den1": 8, "num2": 2, "den2": 3, "text": "Add fractions and regroup improper sums to mixed numbers:", "options": ["1 13/24", "1 7/24", "37/24", "1 5/12"], "correct": "1 13/24"},
    {"type": "drill", "num1": 3, "den1": 4, "num2": 1, "den2": 2, "text": "Find the sum and express as a mixed fraction form:", "options": ["1 1/4", "1 3/4", "5/4", "1 1/2"], "correct": "1 1/4"},
    {"type": "drill", "num1": 5, "den1": 9, "num2": 1, "den2": 2, "text": "Solve and regroup the improper value:", "options": ["1 1/18", "1 5/18", "19/18", "1 1/9"], "correct": "1 1/18"},
    {"type": "drill", "num1": 1, "den1": 2, "num2": 5, "den2": 6, "text": "Add and reduce your regrouped calculation:", "options": ["1 1/3", "1 2/6", "4/3", "1 2/3"], "correct": "1 1/3"},
    {"type": "drill", "num1": 3, "den1": 7, "num2": 9, "den2": 10, "text": "Determine the combined terms in lowest parameters:", "options": ["1 23/70", "1 33/70", "93/70", "1 3/7"], "correct": "1 23/70"},
    {"type": "drill", "num1": 7, "den1": 10, "num2": 4, "den2": 5, "text": "Compute the sum total as a simplified mixed numeral:", "options": ["1 1/2", "1 5/10", "1 3/5", "1 2/5"], "correct": "1 1/2"},
    {"type": "drill", "num1": 3, "den1": 4, "num2": 5, "den2": 6, "text": "Add fractions using LCD and transform to mixed form:", "options": ["1 7/12", "1 5/12", "19/12", "1 3/4"], "correct": "1 7/12"},
    {"type": "word_problem", "text": "Rosemarie worked in her vegetable garden during the weekend. If she worked 4/5 hour on Saturday and 6/8 hour on Sunday, how many hours did she work in two days?", "options": ["1 11/20 hours", "1 3/20 hours", "1 14/40 hours", "2 hours"], "correct": "1 11/20 hours"},
    {"type": "word_problem", "text": "Juliet bought 3/4 meter of silk cloth and 5/8 meter of cotton cloth for her daughter's dress. How many meters of cloth did Juliet buy in all?", "options": ["1 3/8 meters", "1 5/8 meters", "11/8 meters", "1 1/4 meters"], "correct": "1 3/8 meters"},
    {"type": "word_problem", "text": "One morning, a restaurant served a total of 1/2 of a loaf of wheat bread and 7/8 of a loaf of white bread. How many loaves were served in all?", "options": ["1 3/8 loaves", "1 1/8 loaves", "1 5/8 loaves", "1 1/2 loaves"], "correct": "1 3/8 loaves"}
  ];

  // --- LESSON 3 POOL (Adding Simple Fractions and Mixed Numbers With Regrouping in the Sum) ---
  final List<Map<String, dynamic>> _lesson3Pool = [
    {"type": "drill", "num1": 2, "den1": 3, "num2": 4, "den2": 5, "text": "Find the sum of 2/3 and 4/5:", "options": ["1 7/15", "1 2/15", "1 4/15", "6/8"], "correct": "1 7/15"},
    {"type": "drill", "num1": 1, "den1": 2, "num2": 3, "den2": 4, "text": "Solve and regroup the sum of 1/2 and 3/4:", "options": ["1 1/4", "1 1/2", "4/6", "1 3/4"], "correct": "1 1/4"},
    {"type": "drill", "num1": 4, "den1": 5, "num2": 1, "den2": 2, "text": "What is the total of 4/5 and 1/2 converted to a mixed number?", "options": ["1 3/10", "1 1/10", "1 7/10", "5/7"], "correct": "1 3/10"},
    {"type": "drill", "num1": 5, "den1": 6, "num2": 2, "den2": 3, "text": "Find the summation value of 5/6 and 2/3:", "options": ["1 1/2", "1 1/3", "1 2/3", "7/9"], "correct": "1 1/2"},
    {"type": "drill", "num1": 3, "den1": 4, "num2": 5, "den2": 8, "text": "Compute the sum of 3/4 and 5/8:", "options": ["1 3/8", "1 1/8", "1 5/8", "8/12"], "correct": "1 3/8"},
    {"type": "drill", "num1": 2, "den1": 3, "num2": 5, "den2": 6, "text": "Add the fractions 2/3 and 5/6 and write as a mixed number:", "options": ["1 1/2", "1 1/6", "1 2/3", "7/9"], "correct": "1 1/2"},
    {"type": "drill", "num1": 3, "den1": 5, "num2": 2, "den2": 3, "text": "Find the total value of 3/5 and 2/3:", "options": ["1 4/15", "1 2/15", "1 1/15", "5/8"], "correct": "1 4/15"},
    {"type": "word_problem", "text": "Mother bought 3/4 kilogram of pork and 1/2 kilogram of beef. How many kilograms of meat did she buy in total?", "options": ["1 1/4 kilograms", "1 1/2 kilograms", "1 3/4 kilograms", "4/6 kilogram"], "correct": "1 1/4 kilograms"},
    {"type": "word_problem", "text": "Aling Nena used 4/5 cup of white sugar and 2/3 cup of brown sugar to cook native delicacies. How many cups of sugar did she use altogether?", "options": ["1 7/15 cups", "1 2/15 cups", "1 4/15 cups", "6/8 cups"], "correct": "1 7/15 cups"},
    {"type": "word_problem", "text": "Mang Tomas walked 5/6 kilometer to the market and 3/4 kilometer to the barangay hall. What is the total distance he walked?", "options": ["1 7/12 kilometers", "1 5/12 kilometers", "1 1/12 kilometers", "8/10 kilometer"], "correct": "1 7/12 kilometers"}
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeRandomSession();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initializeRandomSession() {
    List<Map<String, dynamic>> currentPool;
    if (_currentLessonModule == 1) {
      currentPool = _lesson1Pool;
    } else if (_currentLessonModule == 2) {
      currentPool = _lesson2Pool;
    } else {
      currentPool = _lesson3Pool;
    }

    List<Map<String, dynamic>> shuffledPool = List.from(currentPool)..shuffle();
    
    _activeQuestions = shuffledPool.take(10).map((q) {
      Map<String, dynamic> dynamicQuestion = Map.from(q);
      List<String> randomizedOptions = List<String>.from(dynamicQuestion['options'])..shuffle();
      dynamicQuestion['options'] = randomizedOptions;
      return dynamicQuestion;
    }).toList();
  }

  void _checkAnswer(int index) {
    if (_hasAnswered) return;

    setState(() {
      _selectedAnswerIndex = index;
      _hasAnswered = true;
      if (_activeQuestions[_currentQuestionIndex]['options'][index] == _activeQuestions[_currentQuestionIndex]['correct']) {
        _score += 10;
      } else {
        _lives--;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _activeQuestions.length - 1 && _lives > 0) {
        _currentQuestionIndex++;
        _hasAnswered = false;
        _selectedAnswerIndex = -1;
      }
    });
  }

  void _resetGame() {
    setState(() {
      _initializeRandomSession();
      _currentQuestionIndex = 0;
      _score = 0;
      _lives = 5; 
      _hasAnswered = false;
      _selectedAnswerIndex = -1;
    });
  }

  void _showRestartConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Restart Game?", style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text("Are you sure you want to restart? Your current score and progress will be lost."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _getPrimaryColor(),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.of(context).pop(); 
                _resetGame(); 
              },
              child: const Text("Yes, Restart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Color _getPrimaryColor() {
    if (_currentLessonModule == 1) return const Color(0xFF8E5BD9);
    if (_currentLessonModule == 2) return const Color(0xFF00796B);
    return const Color(0xFFE65100); // Orange/Amber Theme for Lesson 3
  }

  Color _getBgColor() {
    if (_currentLessonModule == 1) return const Color(0xFF5A9CF8);
    if (_currentLessonModule == 2) return const Color(0xFF4DB6AC);
    return const Color(0xFFFFB74D); // Soft Orange Background for Lesson 3
  }

  String _getLessonTitle() {
    if (_currentLessonModule == 1) return "Lesson 1: Simple Fractions";
    if (_currentLessonModule == 2) return "Lesson 2: Regrouping Sums";
    return "Lesson 3: Mixed Regrouping";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getBgColor(),
      appBar: AppBar(
        backgroundColor: _getPrimaryColor(),
        elevation: 0,
        title: Text(
          _getLessonTitle(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: const Color(0xFFFFDF3D),
          indicatorWeight: 4,
          tabs: const [
            Tab(icon: Icon(Icons.menu_book), text: "Learn Lesson"),
            Tab(icon: Icon(Icons.sports_esports), text: "Play Quest"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLessonTab(),
          _buildGameTab(),
        ],
      ),
    );
  }

  // =========================================================================
  // FIXED & ENHANCED LESSON RULES SHEET WITH WORKED EXAMPLES AND PRO-TIPS
  // =========================================================================
  Widget _buildLessonTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Adding Simple Fractions", 
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _getPrimaryColor())
                ),
                Text(
                  _currentLessonModule == 1 
                      ? "Without Regrouping (Similar & Dissimilar)" 
                      : _currentLessonModule == 2
                          ? "With Regrouping (Improper to Mixed Numbers)"
                          : "Simple Fractions and Mixed Numbers With Regrouping in the Sum", 
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey)
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Dynamic Steps Layout
          _buildStepCard(
            stepNumber: "1", 
            title: "Find the Common Denominator (LCD)", 
            description: _currentLessonModule == 1 
                ? "Look closely at the denominators (bottom numbers):\n• If they match (Similar), simply keep them!\n• If they differ (Dissimilar), find the Least Common Multiple (LCM) to make them match." 
                : "For fractions with different denominators, always calculate the Least Common Denominator (LCD) first before working out anything else.",
            tip: _currentLessonModule == 1 ? "Similar denominators mean you can skip searching for an LCD entirely!" : "Example: For denominators 4 and 3, counting up yields 4, 8, 12... and 3, 6, 9, 12... so 12 is your LCD!"
          ),
          
          _buildStepCard(
            stepNumber: "2", 
            title: "Convert to New Numerators", 
            description: _currentLessonModule == 1 
                ? "Change your fractions to look matching. Divide the new LCD by the old denominator, then multiply that result by your top numerator." 
                : "Adjust your top values accurately using the new denominator scale so that the value of the expressions doesn't change.",
            tip: _currentLessonModule == 1 ? "Formula: (LCD ÷ Old Denominator) × Old Numerator" : "Let's convert: For 3/4 and 1/2 with LCD 4:\n• (4 ÷ 4) × 3 = 3 → 3/4\n• (4 ÷ 2) × 1 = 2 → 2/4"
          ),

          // Dynamic Worked Sandbox Area Container
          _buildSandboxExampleCard(),
          const SizedBox(height: 14),

          _buildStepCard(
            stepNumber: "3", 
            title: "Add Numerators & Keep Bottom Same", 
            description: _currentLessonModule == 1 
                ? "Combine your modified top values together. Remember: Leave the bottom denominator untouched!" 
                : "Add your new top elements directly above the common shared base line. This often yields an improper fraction setup (top bigger than bottom).",
            tip: "Never add the denominators together! 1/4 + 1/4 equals 2/4, not 2/8!"
          ),
          
          _buildStepCard(
            stepNumber: "4", 
            title: _currentLessonModule == 1 ? "Simplify to Lowest Terms" : "Regroup Into a Mixed Number", 
            description: _currentLessonModule == 1 
                ? "Check if your final answer can be made smaller. Find the Greatest Common Divisor (GCD) to divide both the top and bottom cleanly." 
                : "To regroup an improper fraction, divide the numerator by the denominator. The whole number becomes your main score, and the remainder becomes the new fraction top.",
            tip: _currentLessonModule == 1 
                ? "Example: 4/6 can be simplified! Divide top and bottom by 2 to get 2/3!" 
                : "Example: 13/12 becomes 1 Whole with a remainder of 1, cleanly written out as 1 1/12."
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard({required String stepNumber, required String title, required String description, required String tip}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.95), borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: _getPrimaryColor(),
            child: Text(stepNumber, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 6),
                Text(description, style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.3)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: _getPrimaryColor().withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lightbulb_outline, size: 18, color: _getPrimaryColor()),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "💡 Pro-Tip: $tip", 
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _getPrimaryColor(), height: 1.3)
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSandboxExampleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFF59D), width: 1.5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calculate, color: Colors.amber, size: 22),
              SizedBox(width: 6),
              Text("WORKED EXAMPLE WALKTHROUGH", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 12),
          if (_currentLessonModule == 1) ...[
            const Text("Let's solve: 2/4 + 3/8 step-by-step:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildStaticFraction(2, 4),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                _buildStaticFraction(3, 8),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("→  LCD is 8  →", style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold))),
                _buildStaticFraction(4, 8),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                _buildStaticFraction(3, 8),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("=", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                _buildStaticFraction(7, 8),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Since 7/8 cannot be divided by any common number, it is already in its simplest form! ✨", style: TextStyle(fontSize: 13, color: Colors.black87, fontStyle: FontStyle.italic)),
          ] else if (_currentLessonModule == 2) ...[
            const Text("Let's solve: 3/4 + 5/6 step-by-step:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildStaticFraction(3, 4),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                _buildStaticFraction(5, 6),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("→  LCD is 12 →", style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold))),
                _buildStaticFraction(9, 12),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                _buildStaticFraction(10, 12),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("=", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                _buildStaticFraction(19, 12),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Regrouping execution:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.teal)),
            const SizedBox(height: 4),
            const Text("19 ÷ 12 = 1 with a remainder of 7.\nOur final answer transforms into the mixed number: 1 7/12 🎉", style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.3)),
          ] else ...[
            const Text("Let's solve: 2/3 + 4/5 step-by-step:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildStaticFraction(2, 3),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                _buildStaticFraction(4, 5),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("→  LCD is 15 →", style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold))),
                _buildStaticFraction(10, 15),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                _buildStaticFraction(12, 15),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("=", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                _buildStaticFraction(22, 15),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Regrouping execution:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.orange)),
            const SizedBox(height: 4),
            const Text("22 ÷ 15 = 1 with a remainder of 7.\nOur final answer transforms into the mixed number: 1 7/15 🎉", style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.3)),
          ]
        ],
      ),
    );
  }

  Widget _buildStaticFraction(int top, int bottom) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("$top", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
        Container(width: 24, height: 2, color: Colors.black87, margin: const EdgeInsets.symmetric(vertical: 2)),
        Text("$bottom", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54)),
      ],
    );
  }

  // =========================================================================
  // DYNAMIC QUEST LAYOUT
  // =========================================================================
  Widget _buildGameTab() {
    if (_lives <= 0) {
      return _buildEndScreen(title: "Game Over!", icon: Icons.heart_broken, color: Colors.redAccent, isWin: false);
    }
    if (_currentQuestionIndex >= _activeQuestions.length) {
      return _buildEndScreen(title: "Lesson $_currentLessonModule Cleared!", icon: Icons.workspace_premium, color: const Color(0xFFFFDF3D), isWin: true);
    }

    final currentQuestion = _activeQuestions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Text("Score: $_score", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      tooltip: 'Restart lesson math tasks',
                      onPressed: _showRestartConfirmation,
                    ),
                  ),
                ],
              ),
              Row(
                children: List.generate(5, (index) { 
                  return Icon(index < _lives ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 26);
                }),
              )
            ],
          ),
          const SizedBox(height: 16),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Challenge ${_currentQuestionIndex + 1} of ${_activeQuestions.length}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 12),
                  Text(currentQuestion['text'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87)),
                  const SizedBox(height: 24),
                  
                  if (currentQuestion['type'] == 'drill') ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFractionWidget(currentQuestion['num1'], currentQuestion['den1']),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text("+", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: _getPrimaryColor()))),
                        _buildFractionWidget(currentQuestion['num2'], currentQuestion['den2']),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],

                  Column(
                    children: List.generate(4, (index) {
                      String option = currentQuestion['options'][index];
                      bool isCorrect = option == currentQuestion['correct'];
                      Color btnColor = _getPrimaryColor();

                      if (_hasAnswered) {
                        if (isCorrect) {
                          btnColor = Colors.green;
                        } else if (_selectedAnswerIndex == index) {
                          btnColor = Colors.redAccent;
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: btnColor,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => _checkAnswer(index),
                          child: Text(option, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (_hasAnswered)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                if (_currentQuestionIndex == _activeQuestions.length - 1) {
                  setState(() { _currentQuestionIndex++; });
                } else {
                  _nextQuestion();
                }
              },
              icon: const Icon(Icons.arrow_forward),
              label: Text(_currentQuestionIndex == _activeQuestions.length - 1 ? "Finish Quest" : "Next Challenge", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildFractionWidget(int top, int bottom) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("$top", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87)),
        Container(width: 40, height: 3, color: Colors.black87),
        Text("$bottom", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black54)),
      ],
    );
  }

  Widget _buildEndScreen({required String title, required IconData icon, required Color color, required bool isWin}) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 80, color: color),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text("Final Score: $_score Points", style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 24),
            
            // Play / Refresh Button Layout
            GestureDetector(
              onTap: _resetGame,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isWin ? Colors.green : _getPrimaryColor(),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(isWin ? Icons.play_arrow : Icons.refresh, size: 36, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isWin ? "Play Again" : "Restart Game",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isWin ? Colors.green : _getPrimaryColor()),
                  )
                ],
              ),
            ),

            if (isWin) ...[
              const SizedBox(height: 24),
              const Divider(height: 1),
              const SizedBox(height: 20),
              if (_currentLessonModule == 1)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFDF3D),
                    foregroundColor: Colors.black87,
                    elevation: 2,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: Colors.orange, width: 1.5)
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _currentLessonModule = 2; 
                      _resetGame();
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next Lesson: Regrouping Sums", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.skip_next, color: Colors.black87),
                    ],
                  ),
                )
              else if (_currentLessonModule == 2)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9800),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: Colors.deepOrange, width: 1.5)
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _currentLessonModule = 3; 
                      _resetGame();
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next Lesson: Mixed Regrouping", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.skip_next, color: Colors.white),
                    ],
                  ),
                )
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black54,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: Colors.grey.shade400, width: 1)
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("All Quarter 1 fraction levels cleared! Amazing job!")),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "All Levels Completed!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.verified, color: Colors.green, size: 20),
                    ],
                  ),
                ),
            ]
          ],
        ),
      ),
    );
  }
}