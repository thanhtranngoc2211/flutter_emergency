import 'package:flutter/material.dart';
import 'package:flutter_emergency/models/contact_model.dart';

class SpecificInfo extends StatelessWidget {
  final ContactModel contactData;

  SpecificInfo({super.key, required this.contactData});

  @override
  Widget build(BuildContext context) {
    print(contactData.birth);
    return Scaffold(
      backgroundColor: const Color(0xffeff2f9),
      appBar: appBar(),
      body: Column(children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 580,
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    print('Edit Pressed');
                  },
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        contactData.avatarPath ?? 'No path',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const Positioned(
                      bottom: 5,
                      right: 5,
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(contactData.name,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 10,
                ),
                Text(contactData.birth ?? 'Unknown',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 17)),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Table(
                    border: TableBorder(
                        horizontalInside: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 2.0),
                        verticalInside: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 2.0),
                        top: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 2.0),
                        bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 2.0)),
                    children: [
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text('Tuổi:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.grey)),
                                    Spacer(),
                                    Icon(Icons.date_range_outlined,
                                        color: Colors.green)
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(contactData.birth ?? 'Unknown',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text('Nhóm máu:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.grey)),
                                    Spacer(),
                                    Icon(Icons.bloodtype_outlined,
                                        color: Colors.red)
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(contactData.blood ?? 'Unknown',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text('Số điện thoại:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.grey)),
                                    Spacer(),
                                    Icon(Icons.phone_android_rounded,
                                        color: Colors.amber)
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(contactData.phone ?? 'Unknown',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text('Mối quan hệ:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.grey)),
                                    Spacer(),
                                    Icon(Icons.people_alt_outlined,
                                        color: Colors.purple)
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(contactData.relation ?? 'Unknown',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text('Địa chỉ:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.grey)),
                                    Spacer(),
                                    Icon(Icons.location_on_outlined,
                                        color: Colors.blue)
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(contactData.address ?? 'Unknown',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text('Công việc:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.grey)),
                                    Spacer(),
                                    Icon(Icons.cases_outlined,
                                        color: Colors.brown)
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(contactData.job ?? 'Unknown',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 2.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text('Ghi chú:',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.grey)),
                            Spacer(),
                            Icon(Icons.note_alt_outlined)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(contactData.note ?? 'Nothing...',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ]),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: const Color(0xffeff2f9),
      title: const Column(
        children: [
          Text('Contacts',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
        ],
      ),
      centerTitle: true,
      actions: [
        TextButton(
          child: const Row(
            children: [
              Text('Delete',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
                size: 20,
              )
            ],
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
