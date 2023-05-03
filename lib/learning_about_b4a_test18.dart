import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void learningAboutB4aTest180() async {
  print('Start');
  await initialize();
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject('Table3'));
  query.selectKeys('colB', 'a');
  var parseResponse = await query.query();

  if (parseResponse.success && parseResponse.results != null) {
    for (var element in parseResponse.results!) {
      ParseObject parseObject = element as ParseObject;
      print('+++');
      print(parseObject);
      print('---');
    }
  }
  print('End');
}

Future<void> initialize() async {
  String applicationId = 'x4uHx8hJECtAPiKo4Z2f8IK9OUKRtcuUBBaUBHM9';
  String clientKey = 'GoHjfXQ1fIClRQ6K9Gg9hc1dpKj90HJGRXcHeSrs';
  String serverUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(
    applicationId,
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
