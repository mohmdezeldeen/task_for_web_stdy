class AuthResponse {
  int _type;
  String _accessToken;
  String _tokenType;
  String _expiresAt;
  int _id;
  bool _active;

  AuthResponse(
      {int type,
        String accessToken,
        String tokenType,
        String expiresAt,
        int id,
        bool active}) {
    this._type = type;
    this._accessToken = accessToken;
    this._tokenType = tokenType;
    this._expiresAt = expiresAt;
    this._id = id;
    this._active = active;
  }

  int get type => _type;
  set type(int type) => _type = type;
  String get accessToken => _accessToken;
  set accessToken(String accessToken) => _accessToken = accessToken;
  String get tokenType => _tokenType;
  set tokenType(String tokenType) => _tokenType = tokenType;
  String get expiresAt => _expiresAt;
  set expiresAt(String expiresAt) => _expiresAt = expiresAt;
  int get id => _id;
  set id(int id) => _id = id;
  bool get active => _active;
  set active(bool active) => _active = active;

  AuthResponse.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _accessToken = json['access_token'];
    _tokenType = json['token_type'];
    _expiresAt = json['expires_at'];
    _id = json['id'];
    _active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['access_token'] = this._accessToken;
    data['token_type'] = this._tokenType;
    data['expires_at'] = this._expiresAt;
    data['id'] = this._id;
    data['active'] = this._active;
    return data;
  }
}
