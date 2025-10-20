import 'package:flutter/material.dart';

// --- 1. COLOR DEFINITIONS ---
// Primary Color: #eb4c32
const Color exceleratePrimary = Color(0xFFEB4C32);
// Secondary/Accent Color: #4be2f5
const Color excelerateAccent = Color(0xFF4BE2F5);
// Dark Background Color: #04444c
const Color excelerateDark = Color(0xFF04444C);

void main() {
  runApp(const ExcelerateApp());
}

// --- 2. MOCK DATA MODELS ---
class CourseMaterial {
  final String title;
  bool isCompleted;
  CourseMaterial({required this.title, this.isCompleted = false});
}

class Course {
  final String id;
  final String title;
  final String author;
  final String description;
  final String category;
  double progress; // 0.0 to 1.0
  bool isCertified;
  List<CourseMaterial> materials;
  double rating; // Course Rating (e.g., 4.5)

  Course({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.category,
    this.progress = 0.0,
    this.isCertified = false,
    required this.materials,
    this.rating = 0.0,
  });

  double get calculatedProgress {
    if (materials.isEmpty) return 0.0;
    int completed = materials.where((m) => m.isCompleted).length;
    return completed / materials.length;
  }
}

// User Profile Model
class UserProfile {
  String firstName;
  String lastName;
  String otherName;
  String gender;
  String email;
  String countryCode;
  String phoneNumber;

  UserProfile({
    this.firstName = 'userFirstName',
    this.lastName = 'userLastName',
    this.otherName = '',
    this.gender = 'Not Specified',
    this.email = 'user@excelerate.com',
    this.countryCode = '+254',
    this.phoneNumber = '0712345678',
  });

  String get fullName => '$firstName $lastName';
}

// Mock Database/State
UserProfile mockUserProfile = UserProfile(); // Mock User Profile State

List<Course> mockCourses = [
  Course(
    id: 'C101',
    title: 'Advanced UI/UX with Flutter',
    author: 'Prof.Mary Nyandia',
    description: 'Master custom widgets, implicit animations, and responsive design patterns in Flutter.',
    category: 'Development',
    progress: 0.6,
    rating: 4.7,
    materials: [
      CourseMaterial(title: 'Introduction to Custom Painters', isCompleted: true),
      CourseMaterial(title: 'Implicit Animations Deep Dive', isCompleted: true),
      CourseMaterial(title: 'Building Responsive Layouts', isCompleted: false),
      CourseMaterial(title: 'State Management with Provider', isCompleted: false),
    ],
  ),
  Course(
    id: 'C102',
    title: 'Data Science with Python',
    author: 'Sir.Benedict Okang',
    description: 'A comprehensive guide to data cleaning, analysis, and visualization using Python and Pandas.',
    category: 'Data Science',
    progress: 1.0,
    isCertified: true,
    rating: 4.9,
    materials: [
      CourseMaterial(title: 'Setting up the Environment', isCompleted: true),
      CourseMaterial(title: 'Pandas for Data Manipulation', isCompleted: true),
      CourseMaterial(title: 'Data Visualization with Matplotlib', isCompleted: true),
      CourseMaterial(title: 'Introduction to Machine Learning', isCompleted: true),
    ],
  ),
  Course(
    id: 'C103',
    title: 'Digital Marketing Fundamentals',
    author: 'Dr.Antonina Obillo',
    description: 'Learn the essentials of SEO, SEM, and social media strategy.',
    category: 'Business',
    progress: 0.2,
    rating: 4.2,
    materials: [
      CourseMaterial(title: 'What is Digital Marketing?', isCompleted: true),
      CourseMaterial(title: 'SEO Basics', isCompleted: false),
      CourseMaterial(title: 'Creating Ad Campaigns', isCompleted: false),
    ],
  ),

  Course(
    id: 'C104',
    title: '7 Fundamental Recipes of Success',
    author: 'Business Mogul Enock',
    description: 'How to transform your life from rags to riches using 7 tried and tested principles of success.',
    category: 'Business',
    progress: 0.0,
    rating: 5.0,
    materials: [
      CourseMaterial(title: 'My Life in the Slums of Nairobi', isCompleted: false),
      CourseMaterial(title: 'How I Overcame Poverty Mentality', isCompleted: false),
      CourseMaterial(title: 'Climbing the Ladder of Success', isCompleted: false),
      CourseMaterial(title: '7 Lessons that became 7 Recipes of Success', isCompleted: false),
      CourseMaterial(title: 'How You Can Apply the 7 Principles as a Recipe to Your Success', isCompleted: false),
    ],
  ),
];

// Utility Widget for Course Rating
class CourseRating extends StatelessWidget {
  final double rating;
  final double size;
  const CourseRating({super.key, required this.rating, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: Colors.amber, size: size);
        } else if (index < rating && rating % 1 != 0) {
          return Icon(Icons.star_half, color: Colors.amber, size: size);
        } else {
          return Icon(Icons.star_border, color: Colors.amber, size: size);
        }
      }),
    );
  }
}

// --- 3. MAIN APPLICATION WIDGET ---
class ExcelerateApp extends StatelessWidget {
  const ExcelerateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate Learning',
      theme: ThemeData(
        primaryColor: exceleratePrimary,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: excelerateDark,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: exceleratePrimary,
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: excelerateDark,
          displayColor: excelerateDark,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: excelerateAccent,
          primary: exceleratePrimary,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/listing': (context) => const CourseListingScreen(),
        '/mfa': (context) => const MfaVerificationScreen(),
        '/profile': (context) => const UserProfileScreen(),
      },
    );
  }
}

// Custom Widget for Branded App Name
class ExcelerateLogo extends StatelessWidget {
  final double fontSize;
  final Color color;
  const ExcelerateLogo({super.key, this.fontSize = 32.0, this.color = excelerateDark});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          color: color,
        ),
        children: const <TextSpan>[
          TextSpan(text: 'E'),
          TextSpan(
            text: 'excelerate',
            style: TextStyle(color: exceleratePrimary),
          ),
        ],
      ),
    );
  }
}

// --- 4. AUTHENTICATION SCREENS (Including MFA and Google Login) ---

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _showAuthMessage(BuildContext context, String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? excelerateAccent : exceleratePrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const ExcelerateLogo(fontSize: 50),
              const Text(
                'Excelerate Your Learning',
                style: TextStyle(
                  color: excelerateDark,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 60),

// Email/Password Fields
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: exceleratePrimary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: exceleratePrimary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),

// Standard Login Button -> MFA Screen
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: exceleratePrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
// Simulate setting user profile after successful login
                    mockUserProfile.email = 'testuser@flutter.dev';
                    Navigator.pushNamed(context, '/mfa');
                  },
                  child: const Text('Log In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 30),
// Divider for Social Login
              Row(
                children: [
                  const Expanded(child: Divider(color: excelerateDark)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                        'OR',
                        style: TextStyle(color: excelerateDark.withValues(alpha: 179))
                    ),
                  ),
                  const Expanded(child: Divider(color: excelerateDark)),
                ],
              ),
              const SizedBox(height: 30),

// Google Sign-In Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png',
                    height: 24.0,
                    width: 24.0,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, color: Colors.blue, size: 30),
                  ),
                  label: const Text('Continue with Google', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: excelerateDark)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(color: excelerateDark, width: 1.5),
                  ),
                  onPressed: () {
                    mockUserProfile.firstName = 'Google';
                    mockUserProfile.lastName = 'User';
                    _showAuthMessage(context, 'Signed in with Google successfully!');
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
              ),
              const SizedBox(height: 20),

// Navigate to Sign Up
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: excelerateDark, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _selectedGender;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _otherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController(text: '+254');
  final TextEditingController _phoneController = TextEditingController();

  void _showAuthMessage(BuildContext context, String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? excelerateAccent : exceleratePrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleSignUp(BuildContext context) {
// Mock user profile update with form data
    mockUserProfile.firstName = _firstNameController.text;
    mockUserProfile.lastName = _lastNameController.text;
    mockUserProfile.otherName = _otherNameController.text;
    mockUserProfile.gender = _selectedGender ?? 'Not Specified';
    mockUserProfile.email = _emailController.text;
    mockUserProfile.countryCode = _countryCodeController.text;
    mockUserProfile.phoneNumber = _phoneController.text;

    _showAuthMessage(context, 'Account created successfully! Welcome to Excelerate.');
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const ExcelerateLogo(fontSize: 40),
              const SizedBox(height: 30),

// Name Fields
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        prefixIcon: const Icon(Icons.person, color: exceleratePrimary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        prefixIcon: const Icon(Icons.person_outline, color: exceleratePrimary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _otherNameController,
                decoration: InputDecoration(
                  labelText: 'Other Name(s) (Optional)',
                  prefixIcon: const Icon(Icons.badge, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),

// Gender Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: const Icon(Icons.face, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                initialValue: _selectedGender,
                hint: const Text('Select Gender'),
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),

// Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),

// Phone Number Fields
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: TextFormField(
                      controller: _countryCodeController, // Controller handles initial value, replacing the deprecated 'value'
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Code',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: const Icon(Icons.phone, color: exceleratePrimary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

// Password Field
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: exceleratePrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 30),

// Standard Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: excelerateAccent,
                    foregroundColor: excelerateDark,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _handleSignUp(context),
                  child: const Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),

// Divider for Social Login
              Row(
                children: [
                  const Expanded(child: Divider(color: excelerateDark)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                        'OR',
                        style: TextStyle(color: excelerateDark.withValues(alpha: 179))
                    ),
                  ),
                  const Expanded(child: Divider(color: excelerateDark)),
                ],
              ),
              const SizedBox(height: 30),

// Google Sign-Up Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png',
                    height: 24.0,
                    width: 24.0,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, color: Colors.blue, size: 30),
                  ),
                  label: const Text('Sign Up with Google', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: excelerateDark)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(color: excelerateDark, width: 1.5),
                  ),
                  onPressed: () {
                    mockUserProfile.firstName = 'Google';
                    mockUserProfile.lastName = 'User';
                    _showAuthMessage(context, 'Signed up with Google successfully! Welcome.');
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
              ),
              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Already have an account? Log In',
                  style: TextStyle(color: excelerateDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 5. MFA VERIFICATION SCREEN ---

class MfaVerificationScreen extends StatelessWidget {
  const MfaVerificationScreen({super.key});

  void _showAuthMessage(BuildContext context, String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? excelerateAccent : exceleratePrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MFA Verification'),
        backgroundColor: excelerateDark,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.security, size: 80, color: exceleratePrimary),
              const SizedBox(height: 20),
              const Text(
                'Two-Factor Authentication',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: excelerateDark),
              ),
              const SizedBox(height: 10),
              Text(
                'Please enter the 6-digit code sent to your registered email or authenticator app.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: excelerateDark.withValues(alpha: 204)),
              ),
              const SizedBox(height: 40),

// Code Input Field
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 10),
                decoration: InputDecoration(
                  hintText: '• • • • • •',
                  counterText: "",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: exceleratePrimary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 40),

// Verify Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: exceleratePrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    _showAuthMessage(context, 'Verification successful. Welcome!');
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  },
                  child: const Text('Verify and Log In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  _showAuthMessage(context, 'New code requested. Check your email.', success: false);
                },
                child: const Text(
                  'Resend Code',
                  style: TextStyle(color: excelerateDark, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 6. HOME SCREEN ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inProgressCourses = mockCourses.where((c) => c.progress > 0 && c.progress < 1.0).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: excelerateDark,
        title: const ExcelerateLogo(fontSize: 24, color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              _showSimpleMessage(context, 'Notifications', 'No new notifications.');
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome Back, ${mockUserProfile.firstName}!',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: excelerateDark),
            ),
            const SizedBox(height: 10),
            const Text(
              'What would you like to excelerate today?',
              style: TextStyle(fontSize: 16, color: excelerateDark),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ActionCard(
                    icon: Icons.school,
                    label: 'My Learning',
                    color: exceleratePrimary,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyLearningScreen()));
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ActionCard(
                    icon: Icons.card_membership,
                    label: 'My Certificates',
                    color: excelerateAccent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCertificatesScreen()));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              'Continue Learning',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: excelerateDark),
            ),
            const SizedBox(height: 15),
            inProgressCourses.isEmpty
                ? const Text('You currently have no courses in progress. Start a new one below!', style: TextStyle(fontStyle: FontStyle.italic))
                : Column(
              children: inProgressCourses
                  .map((course) => CourseProgressCard(course: course))
                  .toList(),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text('Explore All Courses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pushNamed(context, '/listing');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: excelerateDark,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSimpleMessage(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(color: exceleratePrimary, fontWeight: FontWeight.bold)),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: exceleratePrimary)),
          ),
        ],
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: excelerateDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseProgressCard extends StatelessWidget {
  final Course course;
  const CourseProgressCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDescriptionScreen(course: course),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: excelerateDark),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CourseRating(rating: course.rating, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    course.rating.toStringAsFixed(1), // Removed unnecessary interpolation
                    style: TextStyle(fontSize: 14, color: excelerateDark.withValues(alpha: 179)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: course.progress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(exceleratePrimary),
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(height: 8),
              Text(
                '${(course.progress * 100).toStringAsFixed(0)}% Complete',
                style: TextStyle(color: excelerateDark.withValues(alpha: 179)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 7. MY LEARNING & MY CERTIFICATES ---

class MyLearningScreen extends StatelessWidget {
  const MyLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final learningCourses = mockCourses.where((c) => c.progress > 0).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Learning Progress'),
        backgroundColor: excelerateDark,
      ),
      body: learningCourses.isEmpty
          ? const Center(
        child: Text(
          'You haven\'t started any courses yet!',
          style: TextStyle(fontSize: 18, color: excelerateDark),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: learningCourses.length,
        itemBuilder: (context, index) {
          final course = learningCourses[index];
          return CourseProgressCard(course: course);
        },
      ),
    );
  }
}

class MyCertificatesScreen extends StatelessWidget {
  const MyCertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final certifiedCourses = mockCourses.where((c) => c.isCertified).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Certificates'),
        backgroundColor: excelerateDark,
      ),
      body: certifiedCourses.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 80, color: excelerateAccent),
            const SizedBox(height: 10),
            const Text(
              'No certificates earned yet.',
              style: TextStyle(fontSize: 18, color: excelerateDark),
            ),
            const Text(
              'Keep learning to earn your first one!',
              style: TextStyle(fontSize: 16, color: excelerateDark),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: certifiedCourses.length,
        itemBuilder: (context, index) {
          final course = certifiedCourses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: const Icon(Icons.verified, color: excelerateAccent, size: 30),
              title: Text(
                'Certificate of Completion: ${course.title}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: excelerateDark),
              ),
              subtitle: Text('Issued by Excelerate\nInstructor: ${course.author}'),
              trailing: const Icon(Icons.download, color: exceleratePrimary),
              onTap: () {
                _showSimpleMessage(context, 'Certificate Download', 'Simulating download of certificate for ${course.title}.');
              },
            ),
          );
        },
      ),
    );
  }

  void _showSimpleMessage(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(color: exceleratePrimary, fontWeight: FontWeight.bold)),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: exceleratePrimary)),
          ),
        ],
      ),
    );
  }
}

// NEW SCREEN: User Profile with Log Out
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: excelerateDark,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: excelerateAccent,
              child: Text(
                mockUserProfile.fullName.substring(0, 1),
                style: const TextStyle(fontSize: 40, color: excelerateDark, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              mockUserProfile.fullName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: excelerateDark),
            ),
            const SizedBox(height: 30),

// User Details Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Account Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: exceleratePrimary),
              ),
            ),
            const Divider(color: excelerateDark),
            _buildProfileDetail(context, Icons.email, 'Email', mockUserProfile.email),
            _buildProfileDetail(context, Icons.phone, 'Phone', '${mockUserProfile.countryCode} ${mockUserProfile.phoneNumber}'), // Kept interpolation for formatting
            _buildProfileDetail(context, Icons.person_outline, 'Gender', mockUserProfile.gender),
            _buildProfileDetail(context, Icons.badge, 'Other Name(s)', mockUserProfile.otherName.isEmpty ? 'N/A' : mockUserProfile.otherName),

            const SizedBox(height: 50),

// Log Out Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Log Out', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: exceleratePrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _handleLogout(context),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                _showSimpleMessage(context, 'Edit Profile', 'Simulating navigation to profile edit page.');
              },
              child: const Text('Edit Profile Details', style: TextStyle(color: excelerateDark)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: exceleratePrimary, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: excelerateDark.withValues(alpha: 153)),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: excelerateDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Log Out'),
        content: const Text('Are you sure you want to log out of your Excelerate account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: excelerateDark)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
// Navigate back to login screen, removing all previous routes
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            child: const Text('Log Out', style: TextStyle(color: exceleratePrimary)),
          ),
        ],
      ),
    );
  }

  void _showSimpleMessage(BuildContext context, String title, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: excelerateAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// --- 8. COURSE LISTING SCREEN ---

class CourseListingScreen extends StatefulWidget {
  const CourseListingScreen({super.key});

  @override
  State<CourseListingScreen> createState() => _CourseListingScreenState();
}

class _CourseListingScreenState extends State<CourseListingScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> categories = ['All', 'Development', 'Data Science', 'Business', 'Design', 'Marketing'];

  List<Course> get _filteredCourses {
    return mockCourses.where((course) {
      final matchesSearch = course.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || course.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Courses'),
        backgroundColor: excelerateDark,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search, color: exceleratePrimary),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                contentPadding: const EdgeInsets.all(15.0),
              ),
            ),
          ),

          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 16.0 : 8.0, right: index == categories.length - 1 ? 16.0 : 0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    selectedColor: exceleratePrimary,
                    disabledColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : excelerateDark,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            child: _filteredCourses.isEmpty
                ? const Center(
              child: Text(
                'No courses found for your search criteria.',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: excelerateDark),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _filteredCourses.length,
              itemBuilder: (context, index) {
                return CourseListItem(course: _filteredCourses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CourseListItem extends StatelessWidget {
  final Course course;
  const CourseListItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDescriptionScreen(course: course),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: excelerateDark),
              ),
              const SizedBox(height: 4),
              Text(
                'By ${course.author}',
                style: TextStyle(fontSize: 14, color: excelerateDark.withValues(alpha: 179)),
              ),
              const SizedBox(height: 4),
              Row( // NEW: Display Rating
                children: [
                  CourseRating(rating: course.rating, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    course.rating.toStringAsFixed(1), // Removed unnecessary interpolation
                    style: const TextStyle(fontSize: 14, color: excelerateDark, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                course.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
// Progress Indicator for courses already started
              if (course.progress > 0)
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: course.progress,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(exceleratePrimary),
                        minHeight: 5,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${(course.progress * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(color: exceleratePrimary, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
// Status badge for completed courses
              if (course.isCertified)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: excelerateAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'CERTIFIED',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: excelerateDark),
                  ),
                ),
              if (course.progress == 0)
                Text(
                  '${course.materials.length} lessons',
                  style: TextStyle(fontSize: 14, color: excelerateDark.withValues(alpha: 179)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 9. COURSE DESCRIPTION SCREEN ---

class CourseDescriptionScreen extends StatefulWidget {
  final Course course;
  const CourseDescriptionScreen({super.key, required this.course});

  @override
  State<CourseDescriptionScreen> createState() => _CourseDescriptionScreenState();
}

class _CourseDescriptionScreenState extends State<CourseDescriptionScreen> {

  void _showSimpleMessage(BuildContext context, String message, {bool success = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? excelerateAccent : exceleratePrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

// Helper to force a UI update on the mock data (in a real app, this would update state management)
  void _toggleMaterialCompletion(CourseMaterial material) {
    setState(() {
// Find the material in the mock course and toggle its state
      final courseMaterial = widget.course.materials.firstWhere((m) => m.title == material.title);
      courseMaterial.isCompleted = !courseMaterial.isCompleted;

// Recalculate and update the course's overall progress
      widget.course.progress = widget.course.calculatedProgress;

// Check for completion/certification (simplified logic)
      if (widget.course.progress == 1.0 && !widget.course.isCertified) {
        widget.course.isCertified = true;
// L1547 fix applied (The previous structure of the function call was already clean)
        _showSimpleMessage(context, 'Congratulations! ${widget.course.title} is complete! You are now certified!');
      } else if (widget.course.progress < 1.0 && widget.course.isCertified) {
        widget.course.isCertified = false;
// L1550 fix applied (The previous structure of the function call was already clean)
        _showSimpleMessage(context, 'Certification removed as course progress dropped.', success: false);
      }
    }); // L1553: Ensure the setState block is correctly closed and followed by a semicolon if necessary.
  }

  @override
  Widget build(BuildContext context) {
    final progressPercentage = (widget.course.progress * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
        backgroundColor: excelerateDark,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Author: ${widget.course.author}',
                        style: TextStyle(fontSize: 16, color: excelerateDark.withValues(alpha: 179), fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 5),
                      Row( // NEW: Rating in Description Screen
                        children: [
                          CourseRating(rating: widget.course.rating, size: 22),
                          const SizedBox(width: 10),
                          Text(
                            '${widget.course.rating.toStringAsFixed(1)} (Based on reviews)',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: exceleratePrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.course.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),

// Progress Bar Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Course Progress',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: excelerateDark),
                          ),
                          Text(
                            '$progressPercentage%',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: exceleratePrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: widget.course.progress,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(exceleratePrimary),
                        minHeight: 12,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      const SizedBox(height: 20),

// Certification Badge
                      if (widget.course.isCertified)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: excelerateAccent.withValues(alpha: 38),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: excelerateAccent, width: 2),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.emoji_events, color: excelerateAccent, size: 24),
                              SizedBox(width: 10),
                              Text(
                                'Certified! Download Certificate',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: excelerateDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),

                      const Text(
                        'Course Materials',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: excelerateDark),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
// Course Materials List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return CourseMaterialListItem(
                  material: widget.course.materials[index],
                  index: index,
                  onTap: _toggleMaterialCompletion,
                );
              },
              childCount: widget.course.materials.length,
            ),
          ),
        ],
      ),
// Action button for the course
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (widget.course.progress < 1.0) {
                _showSimpleMessage(context, 'Start ${widget.course.title}!');
              }
              else if (widget.course.progress == 1.0) {
                _showSimpleMessage(context, 'continue ${widget.course.title}!');
              }
              else {
                _showSimpleMessage(context, 'You have completed ${widget.course.title}!');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.course.progress < 1.0 ? exceleratePrimary : excelerateDark,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              widget.course.progress == 0.0 ? 'Start Course' : (widget.course.progress < 1.0 ? 'Continue Learning' : 'Course Completed'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

// --- 10. COURSE MATERIAL LIST ITEM WIDGET ---

class CourseMaterialListItem extends StatelessWidget {
  final CourseMaterial material;
  final int index;
  final Function(CourseMaterial) onTap;

  const CourseMaterialListItem({
    super.key,
    required this.material,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () => onTap(material),
        leading: CircleAvatar(
          backgroundColor: material.isCompleted ? excelerateAccent : exceleratePrimary.withValues(alpha: 25),
          child: Text(
            (index + 1).toString(), // Removed unnecessary interpolation
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: material.isCompleted ? excelerateDark : exceleratePrimary,
            ),
          ),
        ),
        title: Text(
          material.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: excelerateDark,
            decoration: material.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: material.isCompleted
            ? const Icon(Icons.check_circle, color: excelerateAccent)
            : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
      ),
    );
  }
}