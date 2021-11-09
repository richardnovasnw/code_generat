import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:generators/src/operator_generator.dart';
import 'package:source_gen/source_gen.dart';

import 'package:annotations/annotations.dart';

import 'model_visitor.dart';

class DefaultGenerator extends GeneratorForAnnotation<DefaultMethod> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final className = '${visitor.className}Impl';
    final classBuffer = StringBuffer();
    classBuffer.writeln('class ${className} extends ${visitor.className} {');

    _generateSetters(element as ClassElement, annotation, classBuffer);
    classBuffer.writeln('}');
    return classBuffer.toString();
  }
}

extension _ElementAnnotationUtils on ElementAnnotation {
  bool get isDefaultValue {
    var displayString =
        computeConstantValue().type.getDisplayString(withNullability: false);
    return isConstantEvaluated && displayString == '$DefaultValue';
  }
}

extension _PropertyAccessorElementUtils on PropertyAccessorElement {
  ElementAnnotation get DefaultValueAnnotation => metadata.firstWhere(
        (e) => e.isDefaultValue,
        orElse: () => null,
      );
}

void _generateSetters(
    ClassElement element, ConstantReader annotation, StringBuffer classBuffer) {
  for (final e in element.accessors) {
    if (e.metadata.isEmpty) {
      return null;
    }

    final annotate = e.DefaultValueAnnotation;
    if (e.isGetter) {
      final value =
          annotate.computeConstantValue().getField('defaultValue').toIntValue();

      classBuffer.writeln('@override');
      classBuffer.writeln('${e.type.returnType} get ${e.name} => $value;');
    }
  }
}
