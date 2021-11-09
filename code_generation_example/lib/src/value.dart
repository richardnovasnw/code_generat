import 'package:annotations/annotations.dart';

part 'value.g.dart';

@DefaultMethod()
abstract class Value {
  @DefaultValue(10)
  int get count;
}
