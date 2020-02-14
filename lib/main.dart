import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home:MyApp()));
List<Offset> _points = <Offset>[];
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
    body: Signature(),
    floatingActionButton: FloatingActionButton(
      onPressed: clear,
      tooltip: 'Clear All',   
      child: Icon(Icons.clear_all),
      backgroundColor: Colors.blue,
      focusColor: Colors.green,
      foregroundColor: Colors.grey,
      ));
}

class Signature extends StatefulWidget {
  SignatureState createState() => SignatureState();
}

void clear() {
  _points.clear();
}

class SignatureState extends State<Signature> {


  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details){
        setState(() {
          RenderBox referenceBox = context.findRenderObject();
          Offset localPosition =
          referenceBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),
      child: CustomPaint(painter: SignaturePainter(_points), size: Size.infinite,)
    );
  }     
}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);
  final List<Offset> points;
  void paint(Canvas canvas, Size size) {
    var paint = Paint()

    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0;
    for (int i=0; i < points.length -1; i++){
      if(points[i] != null && points[i+1] != null)
        canvas.drawLine(points[i], points[i+1], paint);
    }
  }
  bool shouldRepaint(SignaturePainter other) => other.points != points;
}