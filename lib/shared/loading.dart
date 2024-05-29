import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/widgets.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SpinKitRotatingCircle(
  color: Color.fromARGB(255, 65, 59, 1),
  size: 50.0,
);
  }
}
