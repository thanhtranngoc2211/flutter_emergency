class savedNumberModel {
  String name;
  String number;

  savedNumberModel({required this.name, required this.number});

  static List<savedNumberModel> getContact() {
    List<savedNumberModel> contacts = [];

    contacts
        .add(savedNumberModel(name: 'Trần Ngọc Thành', number: '0822455477'));
    return contacts;
  }

  static List<String> getNumber() {
    List<String> numbers =
        getContact().map((contact) => contact.number).toList();
    return numbers;
  }
}
