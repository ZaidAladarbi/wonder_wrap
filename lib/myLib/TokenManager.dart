// ignore_for_file: file_names, unnecessary_getters_setters

class TokenManager {
  String _token = '';

  static final TokenManager _instance = TokenManager._internal();

  factory TokenManager() {
    return _instance;
  }

  TokenManager._internal();

  String get token => _token;

  set token(String newToken) {
    _token = newToken;
  }
}

class EntryManager {
  double _entryid = 0;

  static final EntryManager _instance = EntryManager._internal();

  factory EntryManager() {
    return _instance;
  }

  EntryManager._internal();

  double get entryid => _entryid;

  set entryid(double newEntryId) {
    _entryid = newEntryId;
  }
}
