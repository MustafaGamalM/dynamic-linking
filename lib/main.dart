import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:linking/details.dart';
import 'package:linking/firebase_dynamic_link_controller.dart';
import 'package:linking/profile.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// init dynamic link
  // FirebaseDynamicLinkController().initDynamicLink();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  checkCustomScreenDynamicLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    // if (initialLink != null) {
    //   final Uri deepLink = initialLink.link;
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const Profile(),
    //       ));
    // }
    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        Map<String, List<String>> c =
            pendingDynamicLinkData.link.queryParametersAll;
        print(c);

        print(pendingDynamicLinkData.link.queryParameters['appScreenPath']);
        print(pendingDynamicLinkData.link.queryParameters['id']);

        if (pendingDynamicLinkData != null) {
          final Uri deepLink = pendingDynamicLinkData.link;

          print('====');
          if (pendingDynamicLinkData.link.queryParameters['appScreenPath']!
              .contains('profile')) {
            print('proooooooooooooo');
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ));
          } else {
            print('proooooooooooooo error');

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailsView(),
                ));
          }
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCustomScreenDynamicLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton.icon(
              onPressed: () {
                FirebaseDynamicLinkController()
                    .craeteDynamicLink('details', 123)
                    .then((value) {
                  Share.share(value);
                });
              },
              icon: Icon(Icons.share),
              label: Text('Share to details'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseDynamicLinkController()
              .craeteDynamicLink('profile', 99)
              .then((value) {
            Share.share(value);
          });
        },
        tooltip: 'share',
        child: const Icon(Icons.share),
      ),
    );
  }
}
