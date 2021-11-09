import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:generators/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class OperatorGenerator extends GeneratorForAnnotation<OperatorsAnnotation> {
  @override
  List<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final add = annotation.peek('add').boolValue;
    final sub = annotation.peek('sub').boolValue;
    final multiply = annotation.peek('multiply').boolValue;
    final divide = annotation.peek('divide').boolValue;

    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final className = '${visitor.className}Impl'; // EX: 'ModelGen' for 'Model'.

    //Addition

    final classBufferAdd = StringBuffer();

    classBufferAdd
        .writeln('class ${className}Add extends ${visitor.className} {');

    classBufferAdd.writeln('int add(');

    for (final field in visitor.fields.keys) {
      classBufferAdd.writeln('${field}, ');
    }

    classBufferAdd.writeln(') { return a + b;');

    classBufferAdd.writeln('}}');

    //Subtraction
    final classBufferSub = StringBuffer();

    classBufferSub
        .writeln('class ${className}Sub extends ${visitor.className} {');

    classBufferSub.writeln('int subtract(');

    for (final field in visitor.fields.keys) {
      classBufferSub.writeln('${field}, ');
    }

    classBufferSub.writeln(') { return a - b;');

    classBufferSub.writeln('}}');

    //Multiplication

    final classBufferMultiply = StringBuffer();

    classBufferMultiply
        .writeln('class ${className}Multiply extends ${visitor.className} {');

    classBufferMultiply.writeln('int multiply(');

    for (final field in visitor.fields.keys) {
      classBufferMultiply.writeln('${field}, ');
    }

    classBufferMultiply.writeln(') { return a * b;');

    classBufferMultiply.writeln('}}');

    //Division

    final classBufferDivision = StringBuffer();

    classBufferDivision
        .writeln('class ${className}Divide extends ${visitor.className} {');

    classBufferDivision.writeln('int divide(');

    for (final field in visitor.fields.keys) {
      classBufferDivision.writeln('${field}, ');
    }

    classBufferDivision.writeln(') { return a / b;');

    classBufferDivision.writeln('}}');

    final list = <String>[
      '${(add == true) ? '${classBufferAdd.toString()} ' : 
      '//addition set to false'}',
      '${(sub == true) ? '${classBufferSub.toString()} ' : 
      '//subtraction set to false'}',
      '${(multiply == true) ? '${classBufferMultiply.toString()} ' 
      : '//multiplication set to false'}',
      '${(divide == true) ? '${classBufferDivision.toString()} '
       : '//division set to false'}',
    ];
    return list;
  }
}
