import 'package:shared_preferences/shared_preferences.dart';

String stringKey = 'String';
String listKey = 'List';

class StoreData {
  static SharedPreferences? _preferences;

  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

//store

  static Future setList(List<String> listOfString) async =>
      await _preferences!.setStringList(listKey, listOfString);

  static Future setString(String string) async =>
      await _preferences!.setString(stringKey, string);

//retrive

  static List<String>? getList() => _preferences!.getStringList(listKey) ?? [];

  static String? getString() => _preferences!.getString(stringKey) ?? '';
}
