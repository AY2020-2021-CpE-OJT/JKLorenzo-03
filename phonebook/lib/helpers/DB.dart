import '../structures/PBData.dart';
import '../managers/API.dart';

var _updated = true;
Map<String, PBData> _phonebook = Map();

class DB {
  static String _generateKey(PBData data) {
    return '${data.last_name}_${data.first_name}';
  }

  static PBData _update(PBData data) {
    return _phonebook.update(_generateKey(data), (value) {
      value.phone_numbers.add(data.phone_numbers.first);
      return value;
    }, ifAbsent: () {
      return data;
    });
  }

  static contains(String key) {
    if (_phonebook.containsKey(key)) return true;
    return false;
  }

  static upsert(PBData data) async {
    final exists = contains(_generateKey(data));
    final this_data = _update(data);
    final similar = this_data.equals(data);
    if (!exists || !similar) {
      await API.upsert(this_data);
      _updated = true;
    }
  }

  static Future<List<PBData>> fetchAll() async {
    if (_updated) {
      final new_data = await API.fetch();
      _phonebook = Map();
      new_data.forEach((data) => _update(data));
      _updated = false;
    }
    return [..._phonebook.values];
  }
}
