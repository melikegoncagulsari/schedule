import 'package:flutter/material.dart';
import 'package:schedule_app/homepage.dart';
import 'package:schedule_app/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MyHomePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}


//*****homepage.dart*****


import 'package:flutter/material.dart';
import 'package:schedule_app/details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Home'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  //Navigator.pushNamed(context, '/profile');
                },
              )
            ]),
        body: Column(
          children: [
            const Text(
              'Welcome the Schedule App',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const Image(
              image: AssetImage("images/myimage.jpeg"),
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
            Container(
              color: Colors.amber,
              alignment: Alignment.center,
              child: const Text(
                'See your schedule for the week',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const Expanded(child: MyListview())
          ],
        ));
  }
}

class MyListview extends StatefulWidget {
  const MyListview({super.key});

  @override
  State<MyListview> createState() => _MyListviewState();
}

class _MyListviewState extends State<MyListview> {
  @override
  Widget build(BuildContext context) {
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    return ListView.separated(
      itemCount: days.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(days[index]),
          leading: const Icon(Icons.calendar_month),
          trailing: const Icon(
            Icons.arrow_forward,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(
                          day: 'days$index',
                        )));
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}


//*****settings.dart*****


import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool theme = false;
  bool notification = false;
  String dropdownValue = 'Daily';
  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings Page')),
        body: ListView(
          children: <Widget>[
            SwitchListTile(
              title: const Text('Theme Settings'),
              subtitle: const Text('Dark theme'),
              value: theme,
              onChanged: (bool value) {
                setState(() {
                  theme = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Notification Settings'),
              subtitle: const Text('Enable'),
              value: notification,
              onChanged: (bool value) {
                setState(() {
                  notification = value;
                });
              },
            ),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: ((String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              }),
              items: const [
                DropdownMenuItem(
                  value: 'Daily',
                  child: Text('Daily'),
                ),
                DropdownMenuItem(
                  value: 'Weekly',
                  child: Text('Weekly'),
                ),
                DropdownMenuItem(
                  value: 'Monthly',
                  child: Text('Monthly'),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ///Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
            //Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
          child: const Icon(Icons.arrow_back),
        ));
  }
}


//*****details.dart*****


import 'package:flutter/material.dart';
import 'dart:math';

class DetailsPage extends StatelessWidget {
  final String day;
  final List<String> tasks = [
    'Task 1',
    'Task 2',
    'Task 3',
  ];

  DetailsPage({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    List<String> randomTasks = [];
    for (int i = 0; i < tasks.length; i++) {
      if (Random().nextBool()) {
        randomTasks.contains(tasks[i]);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('details for $day'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tasks for $day:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            for (String task in randomTasks)
              Text(
                '-$task',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

