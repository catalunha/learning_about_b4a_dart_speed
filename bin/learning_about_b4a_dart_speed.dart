import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void main(List<String> arguments) async {
  print('Start');
  await initialize();
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject('Table3'));
  // query.keysToReturn(['colA']);
  query.keysToReturn(['colA', 'typePointerTable4.colA']);
  // query.includeObject(['typePointerTable4']);
  // query.selectKeys('colA', '3a');
  var parseResponse = await query.query();

  if (parseResponse.success && parseResponse.results != null) {
    for (var element in parseResponse.results!) {
      ParseObject parseObject = element as ParseObject;
      print(parseObject);
      print(parseObject.get('colA'));
      print(parseObject.get('typePointerTable4'));
      print('=-=-=');
    }
  }
  print('End');
}

Future<void> initialize() async {
  String appId = 'x4uHx8hJECtAPiKo4Z2f8IK9OUKRtcuUBBaUBHM9';
  String clientKey = 'GoHjfXQ1fIClRQ6K9Gg9hc1dpKj90HJGRXcHeSrs';
  String serverUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(
    appId,
    serverUrl,
    clientKey: clientKey,
    debug: false,
  );
  if ((await Parse().healthCheck()).success) {
    print('Back4app Connected.');
  } else {
    print('Back4app NOT Connected.');
    print('Exit app.');
    exit(0);
  }
}
