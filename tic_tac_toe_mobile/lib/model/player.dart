class Player {
  String name;
  int sign;

  Player(Map<String, dynamic> map) {
    if (map == null) return;
    name = map["name"];
    sign = map["sign"];
  }
}
