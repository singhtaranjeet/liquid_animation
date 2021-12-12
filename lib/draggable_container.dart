import 'package:flutter/material.dart';

class DraggableContainer extends StatefulWidget {
  const DraggableContainer({Key? key}) : super(key: key);

  @override
  _DraggableContainerState createState() => _DraggableContainerState();
}

class _DraggableContainerState extends State<DraggableContainer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // _controller.addListener(() {
    //   setState(() {
    //     _offset += _animation.value;
    //   });
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable'),
      ),
      body: Stack(children: [
        Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: Draggable(
            onDragUpdate: (details) {
              setState(() {
                _offset += details.delta;
              });
            },
            data: 'Draggable',
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
              child: CustomPaint(
                painter: BallPainter(),
              ),
            ),
            feedback: Container(),
          ),
        ),
      ]),
    );
  }
}

class BallPainter extends CustomPainter {
  BallPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawOval(Rect.fromLTRB(size.width, size.height, 0, 0), paint);
  }

  @override
  bool shouldRepaint(BallPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(BallPainter oldDelegate) => false;
}
