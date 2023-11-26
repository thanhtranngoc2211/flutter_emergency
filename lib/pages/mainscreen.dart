import 'package:flutter_svg/svg.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _currentIndex = 0;
  bool isPressed = false;

  String _locationName = 'Unknown';

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  _checkPermission() async {
    var status = await Permission.location.status;
    print('Checking....');
    if (status == PermissionStatus.denied) {
      await Permission.location.request();
    } else if (status == PermissionStatus.granted) {
      _getCurrentLocation();
    } else {
      // Handle other cases (like PermissionStatus.permanentlyDenied)
    }
  }

  _getCurrentLocation() async {
    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Perform reverse geocoding to get the location name
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
      );

      Placemark place = placemarks[0];
      String locationName =
          "${place.name}, ${place.locality}, ${place.country}";

      setState(() {
        _locationName = locationName;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                print('Profile Pressed');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    8), // Adjust the borderRadius as needed
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
              onTap: () {
                print('Location Button Pressed');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _locationName != null
                      ? Container(
                          width: 100,
                          child: Text('${_locationName}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 13.0)),
                        )
                      : const Text('Getting location...',
                          style: TextStyle(color: Colors.grey, fontSize: 13.0)),
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
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            _mainMessageHomePage(),
            const SizedBox(
              height: 50,
            ),
            // _callNowSection(distance: distance),
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
      // bottomNavigationBar: bottomNavigationBar(),
    );
  }

  NeumorphicButton _mainButton() {
    return NeumorphicButton(
      padding: const EdgeInsets.all(100),
      onPressed: () {
        print("Calling...");
      },
      style: const NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
          shape: NeumorphicShape.convex,
          lightSource: LightSource(0, 30),
          depth: 18,
          intensity: 0.07,
          surfaceIntensity: 0.07,
          color: Colors.red),
      child: const Center(
        child: Text(
          'Gọi ngay!',
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.w700, color: Colors.white),
        ),
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

//   AppBar appBar() {
//     return AppBar(
//       title: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               print('Profile Pressed');
//             },
//             child: ClipRRect(
//               borderRadius:
//                   BorderRadius.circular(8), // Adjust the borderRadius as needed
//               child: const Image(
//                 image: AssetImage('assets/images/avatar.png'),
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Xin chào, Hiền thúi!',
//                 style: TextStyle(fontSize: 13.0),
//               ),
//               Text(
//                 'Hoàn tất hồ sơ',
//                 style: TextStyle(fontSize: 13.0, color: Colors.red),
//               )
//             ],
//           ),
//           const Spacer(),
//           GestureDetector(
//             onTap: () {
//               print('Location Button Pressed');
//             },
//             child: const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Lat: , Long: ',
//                     style: TextStyle(color: Colors.grey, fontSize: 13.0)),
//                 Text(
//                   'Địa điểm hiện tại',
//                   style: TextStyle(color: Colors.red, fontSize: 13.0),
//                 ),
//               ],
//             ),
//           ),
//           SvgPicture.asset(
//             'assets/svg/location.svg',
//             height: 20,
//             width: 20,
//           )
//         ],
//       ),
//     );
//   }
// }
}
