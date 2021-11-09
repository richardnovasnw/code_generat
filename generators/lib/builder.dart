import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:generators/src/defaultvalue_generator.dart';
import 'package:source_gen/source_gen.dart';

import 'src/subclass_generator.dart';
import 'src/operator_generator.dart';

Builder generateSubclass(BuilderOptions options) =>
    SharedPartBuilder([SubclassGenerator()], 'subclass_generator');

Builder sumBuilder(BuilderOptions options) =>
    SharedPartBuilder([OperatorGenerator()], 'sum');

Builder DefaultValueBuilder(BuilderOptions options) =>
    SharedPartBuilder([DefaultGenerator()], 'default_value_generator');

Builder valueBuilder(BuilderOptions options) =>
    SharedPartBuilder([], 'value_generator');
