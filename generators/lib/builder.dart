import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/subclass_generator.dart';
import 'src/sum_generator.dart';

Builder generateSubclass(BuilderOptions options) =>
    SharedPartBuilder([SubclassGenerator()], 'subclass_generator');

Builder sumBuilder(BuilderOptions options) =>
    SharedPartBuilder([OperatorGenerator()], 'sum');
