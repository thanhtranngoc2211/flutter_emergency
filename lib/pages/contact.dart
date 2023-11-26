import 'package:flutter/material.dart';
import 'package:flutter_emergency/pages/specificInfo.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import '../models/contact_model.dart';

class ContactPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  final List<ContactModel> contacts;

  ContactPage({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff2f9),
      appBar: appBar(),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: _bodyMain()),
    );
  }

  CustomScrollView _bodyMain() {
    return CustomScrollView(slivers: [
      SliverStickyHeader(
        header: Column(
          children: [
            Container(
              color: const Color(0xffeff2f9),
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10, bottom: 40),
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 3,
                          color: Colors.grey.withOpacity(0.3))
                    ]),
                child: TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      print('Search query: $value');
                    },
                    decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.mic,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            print('Voice Button Pressed');
                          },
                        ),
                        border: InputBorder.none)),
              ),
            ),
          ],
        ),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('OK ${contacts[index].birth}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpecificInfo(
                                    contactData: contacts[index])));
                      },
                      child: Container(
                        height: 80,
                        width: 360,
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  color: Colors.grey.withOpacity(0.3))
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                              contacts[index].avatarPath ??
                                                  'No path',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(contacts[index].name,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              contacts[index].relation ??
                                                  'Unknown',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward,
                                        size: 17, color: Colors.red)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            childCount: contacts.length,
          ),
        ),
      ),
    ]);
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
              Text('Add',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.add,
                color: Colors.red,
                size: 15,
              )
            ],
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
