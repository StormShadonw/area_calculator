import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _area1 = TextEditingController();
  final TextEditingController _area2 = TextEditingController();
  final List<String> _shapes = ["Rectangule", "Triangle"];
  String _result = "";
  String _currentShape = "Rectangule";
  final GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Area Calculator"),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  child: DropdownButton(
                    value: _currentShape,
                    items: _shapes
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      _currentShape = value as String;
                    }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  child: CustomPaint(
                    size: const Size(100, 100),
                    painter: _currentShape == "Triangle"
                        ? TrianglePainter()
                        : RectanglePainter(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: _area1,
                    validator: (value) {
                      if (value!.isEmpty) return "Please provide a value.";
                      if (double.tryParse(value) == null)
                        return "Please provide a number value";
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                      Icons.calculate,
                    )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) return "Please provide a value.";
                      if (double.tryParse(value) == null)
                        return "Please provide a number value";
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: _area2,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                      Icons.calculate,
                    )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_form.currentState!.validate())
                        setState(() {
                          _result =
                              "The area is ${double.parse(_area1.value.text) * double.parse(_area2.value.text)}";
                        });
                    },
                    child: const Text("Calculate Area"),
                  ),
                ),
                if (_result.isNotEmpty)
                  Container(
                    child: Text(
                      _result,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.deepOrange;
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }
}

class RectanglePainter extends CustomPainter {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.deepPurple;
    Rect rect =
        Rect.fromLTRB(0, size.height / 4, size.width, size.height / 4 * 3);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }
}
