import 'package:annotations/annotations.dart';

part 'operator.g.dart';

@OperatorsAnnotation(false, false, true, true)
class Operator {
  late int a;
  late int b;
}
