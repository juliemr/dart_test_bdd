library guinness2;

import 'package:test/test.dart' as dartTest;
import 'package:collection/equality.dart';
import 'dart:async' as async;
import 'dart:mirrors' as mirrors;
import 'dart:math' as math;

export 'package:test/test.dart' show TestOn;

part 'src/common/model.dart';
part 'src/common/context.dart';
part 'src/common/syntax.dart';
part 'src/common/expect.dart';
part 'src/common/spy.dart';
part 'src/common/interfaces.dart';
part 'src/common/guinness_config.dart';
part 'src/common/test_backend.dart';
part 'src/common/exclusive_visitor.dart';
part 'src/common/suite_info.dart';

class _Undefined {
  const _Undefined();
}
const _u = const _Undefined();

final Guinness guinness = new Guinness(
    matchers: new TestMatchers(),
    initSpecs: testInitSpecs);
