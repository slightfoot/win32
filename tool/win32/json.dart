import 'dart:convert';
import 'dart:io';

import 'shared.dart';

void main() {
  loadCsv('tool/win32/win32api.csv');
  final writer = File('prototypes.json').openSync(mode: FileMode.write);

  writer.writeStringSync(jsonEncode(prototypes));
  writer.closeSync();
}
