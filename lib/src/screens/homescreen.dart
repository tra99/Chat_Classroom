import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> imageList = [
    {"id": "1", "image_path": 'assets/icons/student1.webp'},
    {"id": "2", "image_path": 'assets/icons/student2.jpg'},
    {"id": "3", "image_path": 'assets/icons/student3.webp'},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                CarouselSlider(
                  items: imageList.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          item['image_path']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                    );
                  }).toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 2,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 7 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: currentIndex == entry.key
                                ? const Color.fromARGB(255, 35, 31, 32)
                                : Colors.grey.shade500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),      
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
              child: GridView.count(
                childAspectRatio: 12 / 8,
                crossAxisSpacing: 2,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                children: List.generate(ch.length, (index) {
                  return SelectCard(
                    key: ValueKey(index),
                    ch: ch[index],
                  );
                }),
              ),
            ),
                )
        ],
      ),
      Column(
        children: const [Text('Bonjour'), Text('Ni hao')],
      ),
      Column(
        children: const [Text('Bonjour'), Text('Ni hao')],
      ),
      Column(
        children: const [Text('Bonjour'), Text('Ni hao')],
      ),
      Column(
        children: const [Text('Bonjour'), Text('Ni hao')],
      ),
    ];
  }

  void _onTabItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/logo.png',
              width: 50,
            ),
            const SizedBox(width: 8),
            Text(
              'ITC Students',
              style: GoogleFonts.getFont('Coiny', textStyle: const TextStyle(color: Color.fromARGB(255, 105, 114, 106))),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 163, 255, 161),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 163, 255, 161),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 36,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.chartBar, size: 36),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add_outlined, size: 36),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership_outlined, size: 36),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 36),
            label: "Profile",
          ),
        ],
        onTap: _onTabItem,
      ),
    );
  }
}
class choices {
  const choices({required this.name, required this.image});
  final String name;
  final ImageProvider image;
}
List<choices> ch = const <choices>[
  choices(name: 'Bank', image: AssetImage('assets/icons/bank.png')),
  choices(name: 'Classroom', image: AssetImage('assets/icons/classroom.png')),
  choices(name: 'Forum', image: AssetImage('assets/icons/library.png')),
  choices(name: 'Service', image: AssetImage('assets/icons/chatgpt.png')),
];

class SelectCard extends StatelessWidget {
  const SelectCard({required Key? key, required this.ch}) : super(key: key);
  final choices ch;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: ch.image, width: 80),
            Text(
              ch.name,
              style: GoogleFonts.getFont('Coiny', textStyle: const TextStyle(color: Color.fromARGB(255, 105, 114, 106),fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
