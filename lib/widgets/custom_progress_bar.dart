import 'package:flutter/material.dart';

class CustomProgressBar extends StatefulWidget {
  @override
  _CustomProgressBarState createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..addListener(() {
      setState(() {
        _progress = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.5) {
      return Color.lerp(Colors.red, Colors.orange, progress * 2)!;
    } else {
      return Color.lerp(Colors.orange, Colors.green, (progress - 0.5) * 2)!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          size: Size(300, 20),
          painter: ProgressBarPainter(
            progress: _progress,
            color: _getProgressColor(_progress),
          ),
        ),
        SizedBox(height: 10),
        Text('${(_progress * 100).toStringAsFixed(1)}%'),
        SizedBox(height: 10),
        ElevatedButton(
          child: Text('Animate to 100%'),
          onPressed: () {
            _controller.animateTo(1.0);
          },
        ),
      ],
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  final double progress;
  final Color color;

  ProgressBarPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint =
        Paint()
          ..color = Colors.grey[300]!
          ..style = PaintingStyle.fill;

    final progressPaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    // Draw background
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(10),
      ),
      backgroundPaint,
    );

    // Draw progress
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * progress, size.height),
        Radius.circular(10),
      ),
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
