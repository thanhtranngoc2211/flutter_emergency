class ContactModel {
  String name;
  String? birth;
  String? relation;
  String? avatarPath;
  String? blood;
  String? phone;
  String? address;
  String? job;
  String? note;

  ContactModel(
      {required this.name,
      this.birth,
      required this.relation,
      required this.avatarPath,
      this.blood,
      this.phone,
      this.address,
      this.job,
      this.note});

  static List<ContactModel> getContact() {
    List<ContactModel> contacts = [];

    contacts.add(ContactModel(
      name: 'Đỗ Thu Hiền',
      birth: '12 August 2000',
      relation: 'Bản thân',
      avatarPath: 'assets/images/avatar.png',
      address: 'Từ Sơn, Bắc Linh',
      job: 'Công nhân xưởng in',
    ));

    contacts.add(
      ContactModel(
          name: 'Trần Ngọc Thành',
          birth: '22 November 2000',
          relation: 'Người iu',
          avatarPath: 'assets/images/7309693.jpg',
          blood: 'O',
          address: '160 Lac Long Quan, Tay Ho, Ha Noi',
          job: 'Thất nghiệp',
          note: 'Alo alo alo alo alo alo alo alo alo alo'),
    );

    contacts.add(
      ContactModel(
          name: 'Bố Hải',
          birth: '22 November 2000',
          relation: 'Bố ruột',
          avatarPath: 'assets/images/boHai.jpg',
          blood: 'A',
          address: 'Tu Son, Bac Linh',
          job: 'Sắt thép',
          note: 'Alo alo alo alo alo alo alo alo alo alo'),
    );

    contacts.add(
      ContactModel(
          name: 'Mẹ Hanh',
          birth: '22 November 2000',
          relation: 'Mẹ ruột',
          avatarPath: 'assets/images/meHanh.jpg',
          blood: 'O',
          address: 'Tu Son, Bac Linh',
          job: 'May mặc',
          note: 'Alo alo alo alo alo alo alo alo alo alo'),
    );

    contacts.add(
      ContactModel(
          name: 'Anh zai Hậu',
          birth: '22 November 1998',
          relation: 'Anh ruột',
          avatarPath: 'assets/images/aHau.jpg',
          blood: 'B',
          address: 'Tu Son, Bac Linh',
          job: 'Logistic',
          note: 'Alo alo alo alo alo alo alo alo alo alo'),
    );

    contacts.add(
      ContactModel(
          name: 'Em cu zai Huy',
          birth: '22 November 2004',
          relation: 'Em ruột',
          avatarPath: 'assets/images/cuHuy.jpg',
          blood: 'B',
          address: 'Tu Son, Bac Linh',
          job: 'Xây dựng',
          note: 'Alo alo alo alo alo alo alo alo alo alo'),
    );

    contacts.add(ContactModel(
      name: 'Em cu gái Linh',
      birth: '10 November 2003',
      relation: 'Em gái chồng',
      avatarPath: 'assets/images/avatar.png',
      address: '160 Lac Long Quan, Tay Ho, Ha Noi',
      job: 'Sinh viên ',
    ));

    return contacts;
  }
}
