import '../structures/PBData.dart';

final Map<String, PBData> _phonebook = Map();

class DB {
  static upsert(PBData data) {
    final this_key = '${data.last_name}_${data.first_name}';

    _phonebook.update(this_key, (value) {
      value.phone_numbers.add(data.phone_numbers.first);
      return value;
    }, ifAbsent: () {
      return data;
    });
  }

  static List<PBData> pull() {
    return [..._phonebook.values];
  }
}
