import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import '../timer/pomodoro_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentPageIndex = signal<int>(0);
  final _controller = PageController(initialPage: 0);

  final _pages = [
    const PomodoroPage(),
    const Center(child: Text('Notifications')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      // ),
      body: PageView(
        controller: _controller,
        children: _pages,
      ),
      // bottomNavigationBar: NavigationBar(
      //   onDestinationSelected: (int index) {
      //     _controller.animateToPage(index,
      //         duration: const Duration(milliseconds: 100),
      //         curve: Curves.easeInOut);
      //     currentPageIndex.value = index;
      //   },
      //   selectedIndex: currentPageIndex.value,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.home),
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //       icon: Badge(child: Icon(Icons.notifications_sharp)),
      //       label: 'Notifications',
      //     ),
      //   ],
      // ),
    );
  }
}
