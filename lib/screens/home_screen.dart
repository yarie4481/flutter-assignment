import 'package:flutter/material.dart';
import 'package:flutter_assignment_app/widgets/api_screen.dart';
import 'package:flutter_assignment_app/widgets/app_drawer.dart';
import 'package:flutter_assignment_app/widgets/todo_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_progress_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeContentScreen(),
    TodoScreen(),
    ApiScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Flutter ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: 'Assignment',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.blue.shade700),
            ),
            content: Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                child: Text('Cancel', style: TextStyle(color: Colors.grey)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                ),
                child: Text('Logout', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
              ),
            ],
          ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      selectedItemColor: Colors.blue.shade700,
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_outlined),
          activeIcon: Icon(Icons.list),
          label: 'To-Do',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud_outlined),
          activeIcon: Icon(Icons.cloud),
          label: 'API',
        ),
      ],
    );
  }
}

class HomeContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWelcomeCard(context),
          SizedBox(height: 24),
          _buildProgressBarCard(),
          SizedBox(height: 24),
          _buildStringReversalCard(),
        ],
      ),
    );
  }

  Card _buildWelcomeCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.flutter_dash, size: 60, color: Colors.blue.shade700),
            SizedBox(height: 16),
            Text(
              'Welcome to Flutter Assignment App',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Explore the features below to get started',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Card _buildProgressBarCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timeline, color: Colors.blue.shade700),
                SizedBox(width: 8),
                Text(
                  'Custom Progress Bar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            CustomProgressBar(),
            SizedBox(height: 8),
            Text(
              'This shows a custom animated progress indicator',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildStringReversalCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.text_fields, color: Colors.blue.shade700),
                SizedBox(width: 8),
                Text(
                  'String Reversal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            StringReversalWidget(),
          ],
        ),
      ),
    );
  }
}

class StringReversalWidget extends StatefulWidget {
  @override
  _StringReversalWidgetState createState() => _StringReversalWidgetState();
}

class _StringReversalWidgetState extends State<StringReversalWidget> {
  final _controller = TextEditingController();
  String _reversed = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Enter text to reverse',
            labelStyle: TextStyle(color: Colors.blue.shade700),
            hintText: 'Type something...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
            ),
            filled: true,
            fillColor: Colors.blue.shade50,
            prefixIcon: Icon(Icons.text_fields, color: Colors.blue.shade700),
            suffixIcon:
                _controller.text.isNotEmpty
                    ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.blue.shade700),
                      onPressed: () {
                        _controller.clear();
                        setState(() => _reversed = '');
                      },
                    )
                    : null,
          ),
          onChanged: (text) {
            setState(() {
              _reversed = reverseString(text);
            });
          },
        ),
        SizedBox(height: 16),
        if (_reversed.isNotEmpty) ...[
          Text(
            'Reversed Text:',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Text(
              _reversed,
              style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
            ),
          ),
        ],
      ],
    );
  }

  String reverseString(String input) {
    return input.split('').reversed.join();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
