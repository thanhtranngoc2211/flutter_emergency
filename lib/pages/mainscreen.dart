import 'package:flutter_emergency/models/contact_model.dart';
import 'package:flutter_emergency/models/phone_numbers.dart';
import 'package:flutter_emergency/pages/specificInfo.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.userInfo}) : super(key: key);
  final ContactModel userInfo;

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _currentIndex = 0;
  bool isPressed = false;
  String _locationName = 'Unknown';
  late Position _currentLocation;
  Future<void> _refresh() async {
    await _getLocation();
  }

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _makePhoneCall(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  _checkPermission() async {
    var status = await Permission.location.status;
    print('Checking....');
    if (status == PermissionStatus.denied) {
      await Permission.location.request();
    } else if (status == PermissionStatus.granted) {
      _getLocation();
    } else {
      // Handle other cases (like PermissionStatus.permanentlyDenied)
    }
  }

  Future<void> _getLocation() async {
    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _updateLocationInfo(currentPosition);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _updateLocationInfo(Position position) async {
    // Perform reverse geocoding to get the location name
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks[0];
    String locationName = "${place.name}, ${place.locality}, ${place.country}";

    setState(() {
      _locationName = locationName;
      _currentLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              _mainMessageHomePage(),
              const SizedBox(
                height: 30,
              ),
              _mainButton(),
              const SizedBox(
                height: 50,
              ),
              _middleText(),
              const SizedBox(
                height: 20,
              ),
              _situationCarousel(),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SpecificInfo(contactData: widget.userInfo)));
            },
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(8), // Adjust the borderRadius as needed
              child: const Image(
                image: AssetImage('assets/images/avatar.png'),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xin chào, Hiền thúi!',
                style: TextStyle(fontSize: 13.0),
              ),
              Text(
                'Hoàn tất hồ sơ',
                style: TextStyle(fontSize: 13.0, color: Colors.red),
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  child: Text(_locationName,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 13.0)),
                ),
                const Text(
                  'Địa điểm hiện tại',
                  style: TextStyle(color: Colors.red, fontSize: 13.0),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/svg/location.svg',
            height: 20,
            width: 20,
          )
        ],
      ),
    );
  }

  Center _mainButton() {
    return Center(
      child: Table(
        defaultColumnWidth: const FixedColumnWidth(150.0),
        children: [
          TableRow(
            children: [
              GestureDetector(
                  onTap: () {
                    _makePhoneCall(calculateLocation._bestPhone(
                        calculateLocation._getLocationData(1),
                        _currentLocation));
                  },
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 120,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.local_police,
                        size: 50,
                      ))),
              GestureDetector(
                  onTap: () {
                    _makePhoneCall("114");
                  },
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 120,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.fire_truck_outlined,
                        size: 50,
                      ))),
            ],
          ),
          TableRow(
            children: [
              GestureDetector(
                  onTap: () {
                    _makePhoneCall("115");
                  },
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 120,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.medical_services_outlined,
                        size: 50,
                      ))),
              GestureDetector(
                  onTap: () {
                    _makePhoneCall("0912501959");
                  },
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 120,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.family_restroom_outlined,
                        size: 50,
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: 'Contact',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: 'Guideline',
        ),
      ],
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      selectedItemColor: Colors.red,
    );
  }

  SizedBox _situationCarousel() {
    return SizedBox(
        height: 150,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                10,
                (index) => Container(
                  width: 180.0,
                  height: 120.0,
                  margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 9)
                      ]),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Item $index',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          SvgPicture.asset('assets/svg/arrow.svg')
                        ]),
                  ),
                ),
              ),
            )));
  }

  Column _middleText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Chưa biết phải xử lý như thế nào?',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Chọn tình huống để biết thêm cách giải quyết',
          style: TextStyle(color: Colors.grey, fontSize: 15),
        )
      ],
    );
  }

  Container _mainMessageHomePage() {
    return Container(
      margin: const EdgeInsets.only(left: 60, right: 60),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Cần cuộc gọi',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700)),
          Text('khẩn cấp?',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700)),
          SizedBox(
            height: 15,
          ),
          Text(
            'Nhấn nút đỏ phía dưới để gọi',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

class calculateLocation {
  static List<PhoneModel> _getLocationData(int type) {
    List<PhoneModel> phones = [];
    // Get all phones in database
    switch (type) {
      case 1:
        {
          phones = PhoneModel.getPhone();
        }
      case 2:
      case 3:
      case 4:
    }

    // get only phones in city

    return phones;
  }

  static String _bestPhone(List<PhoneModel> phones, Position position) {
    String bestPhone = '';

    double minDistance = double.infinity;
    const R = 6371.0;
    for (var i = 0; i < phones.length; i++) {
      double lat1 = double.parse(phones[i].latitude);
      double lat2 = position.latitude;
      double lon1 = double.parse(phones[i].longtitude);
      double lon2 = position.longitude;
      lat1 = lat1 * (pi / 180.0);
      lon1 = lon1 * (pi / 180.0);
      lat2 = lat2 * (pi / 180.0);
      lon2 = lon2 * (pi / 180.0);
      // Haversine formula
      var dlat = double.parse(phones[i].latitude) - position.latitude;
      var dlon = double.parse(phones[i].longtitude) - position.longitude;
      var a =
          pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
      var c = 2 * atan2(sqrt(a), sqrt(1 - a));
      var distance = R * c;

      if (distance < minDistance) {
        minDistance = distance;
        bestPhone = phones[i].number;
      }
    }

    return bestPhone;
  }
}
