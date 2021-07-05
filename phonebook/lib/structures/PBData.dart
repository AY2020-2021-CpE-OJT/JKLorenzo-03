class PBData {
  String first_name;
  String last_name;
  List<String> phone_numbers;

  PBData(this.first_name, this.last_name, this.phone_numbers);

  @override
  String toString() {
    return 'fn: $first_name \nln: $last_name \npn: ${phone_numbers.join(', ')}';
  }
}
