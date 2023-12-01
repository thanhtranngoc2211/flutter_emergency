class PhoneModel {
  String name;
  String number;
  String longtitude;
  String latitude;

  PhoneModel(
      {required this.name,
      required this.number,
      required this.longtitude,
      required this.latitude});

  static List<PhoneModel> getPhone() {
    List<PhoneModel> phones = [];

    phones.add(PhoneModel(
        name: 'Ba Dinh, Ha Noi',
        number: '0912501959',
        latitude: '21.04255',
        longtitude: '105.84319'));

    phones.add(PhoneModel(
        name: 'Hai Ba Trung, Ha Noi',
        number: '0915513077',
        latitude: '21.01357',
        longtitude: '105.84791'));

    return phones;
  }
}
