import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void classfrase1() async {
  print('Start');
  await initialize();
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject('Phrase'));
  // query.keysToReturn(['colA']);
  query.keysToReturn(['user.profile']);
  query.includeObject(['user']);
  query.orderByAscending('objectId');
  query.setLimit(1000);

  // query.selectKeys('colA', '3a');
  var parseResponse = await query.query();

  if (parseResponse.success && parseResponse.results != null) {
    for (var element in parseResponse.results!) {
      ParseObject parseObject = element as ParseObject;
      print(parseObject.objectId);
      // print(parseObject.get('colA'));
      print(parseObject.get('user').get('profile').objectId);

      final parseObjectPhrase = ParseObject('Phrase');
      parseObjectPhrase.objectId = parseObject.objectId;
      parseObjectPhrase.set(
          'userProfile',
          (ParseObject('UserProfile')
                ..objectId = parseObject.get('user').get('profile').objectId)
              .toPointer());
      await parseObjectPhrase.save();
      print('=-=-=');
    }
  }
  print('End');
}

Future<void> initialize() async {
  String appId = 'Y1ngM4pkO6KRQpHVxYbzTMUGcbDsvoGJtQFODxVY';
  String clientKey = 'ukQGO74fIqFGP2xoBwiZGLSNpFnNzItLIluoVjDa';
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
