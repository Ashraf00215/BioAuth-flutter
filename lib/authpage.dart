/*  objective :this page is the Authentication page of App it shows:
      - if the device support AuthBiometric
      - Avaliable Biometrics
      - Authintication check and open homepage after valid Authentication
    date Created:24/10
    last Edit DAte: 11/11
    Developer name : Ashraf
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:project_bioauth/homepage.dart';

class setAuth extends StatefulWidget {
  const setAuth({super.key});

  @override
  State<setAuth> createState() => _setAuthState();
}

class _setAuthState extends State<setAuth> {
  LocalAuthentication auth = LocalAuthentication();
  bool _supportstate = false;

  @override
  void initState() {
    super.initState();

    auth.isDeviceSupported().then((bool issupported) => setState(
          () {
            _supportstate = issupported;
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 100, color: Colors.white),
                ),
                Container(
                  height: 100,
                ),
                _issupprot(), // this func return text that shows if the device support bioauthentication or not
                Container(
                  height: 50,
                ),
                ElevatedButton(
                    // this button return available biometrics of device and show in showdialog
                    onPressed: () {
                      _getavailablebiometrics();
                    },
                    child: Text('available biometrics')),
                Container(
                  height: 50,
                ),
                //this button help user to authenticate
                ElevatedButton(
                    onPressed: _authenticate,
                    child: const Text('Authenticate')),
              ]),
        ),
      ),
    );
  }

//this function for the actual authentication , if it is done it will go to the home page
  Future<void> _authenticate() async {
    try {
      bool authenticate = await auth.authenticate(
        localizedReason: 'touch the sensor',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          sensitiveTransaction: true,
          useErrorDialogs: false,
        ),
      );

      if (authenticate) {
        // This navigator goes to the homepage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return home();
          }),
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  // this function return text that shows if your device support bioauthentcation or not
  Widget _issupprot() {
    if (_supportstate)
      return const Text(
        'your device support bioauthentcation',
        style: TextStyle(fontSize: 20, color: Colors.white),
        textAlign: TextAlign.center,
      );
    else
      return const Text(
        'your device does not support bioauthentcation',
        style: TextStyle(fontSize: 20, color: Colors.white),
        textAlign: TextAlign.center,
      );
  }

  //this function return a show dialog contain available Biometrics
  Future<dynamic> _getavailablebiometrics() async {
    bool ch = await auth.canCheckBiometrics;
    List<BiometricType> type = await auth.getAvailableBiometrics();
    // ignore: use_build_context_synchronously
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('available biometric :'),
            content: Container(
              height: 50,
              width: 100,
              child: ListView.builder(
                  // this listview return text of available biometrics
                  itemCount: 1,
                  itemBuilder: (BuildContext context, index) {
                    return Text('$type');
                  }),
            ),
          );
        });
  }
}
