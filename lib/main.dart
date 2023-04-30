import 'dart:async';
import 'dart:io';
// @dart=2.9
import 'package:bookmyshow/Activities.dart';
import 'package:bookmyshow/Buzz.dart';
import 'package:bookmyshow/Home.dart';
import 'package:bookmyshow/Music.dart';
import 'package:bookmyshow/Plays.dart';
import 'package:bookmyshow/Profile.dart';
import 'package:bookmyshow/Sports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'Movie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bookmyshow/Events.dart';
import 'package:bookmyshow/Search.dart';
// import 'loginPage.dart';
// void main() => runApp(new MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Splash(
//     )));

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      // home: MyApp(),
      home: BookMyShowLoginPage(),
    ),
  );
}
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var duration=const Duration(seconds: 3);
    Timer(duration,(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyApp()));
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BookMyShowLoginPage()));


    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: new BoxDecoration(
          image: new DecorationImage(image: AssetImage("Assets/bg.jpeg"))
      ),
      child: new Padding(padding: EdgeInsets.only(bottom: 50.0),child:
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late TabController controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=new TabController(length: 5, vsync: this);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return new WillPopScope(child:  Scaffold(

      bottomNavigationBar: new Container(
          height: 50.0,

          color: Colors.white24,
          child:
          new TabBar(
              controller: controller,
              indicatorColor: Colors.transparent,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,

              tabs: [ new Icon(Icons.home),
                new IconButton(icon:new Icon( Icons.search), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>new Search()));}),
                new Icon(Icons.headset),
                new IconButton(icon:new Icon(Icons.trending_up), onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>new Buzz()));}),
                new Icon(Icons.menu)

              ])),

      body: new TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children:[
            new Home(),
            new Home(),
            new Music(),
            new Music(),
            new Profile(),


          ]
      ),
    ),onWillPop: () {
      exit(0);
    },);
  }
}


// ******************************************
// ******************************888
class BookMyShowLoginPage extends StatefulWidget {
  @override
  _BookMyShowLoginPageState createState() => _BookMyShowLoginPageState();
}

// // *********Google sign in COde***********************8
// Future<void> logout() async {
//   await GoogleSignIn().disconnect();
//   FirebaseAuth.instance.signOut();
// }
// //
// googleLogin() async {
//   print("googleLogin method Called");
//   GoogleSignIn _googleSignIn = GoogleSignIn();
//   try {
//     var reslut = await _googleSignIn.signIn();
//     if (reslut == null) {
//       return;
//     }
//
//     final userData = await reslut.authentication;
//     final credential = GoogleAuthProvider.credential(
//         accessToken: userData.accessToken, idToken: userData.idToken);
//     var finalResult =
//     await FirebaseAuth.instance.signInWithCredential(credential);
//     print("Result $reslut");
//     print(reslut.displayName);
//     print(reslut.email);
//     print(reslut.photoUrl);
//
//   } catch (error) {
//     print(error);
//   }
// }

// ************************************************************************


class _BookMyShowLoginPageState extends State<BookMyShowLoginPage> {


  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255,221,60,60),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80.0),
            Center(
              child: Image.asset
                (
                'assets/bookmyshow_logo.png',
                height: 100.0,
              ),
            ),
            SizedBox(height: 80.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email address',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      // onPressed: () {  },
                      child: Text(
                        'Google ++++++ LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed:() {
                        googleLogin(); // here you can also use async-await
                      },
                      // {
                      //   // if (_formKey.currentState!.validate()) {
                      //   //   _formKey.currentState!.save();
                      //   //   // TODO: Add your login logic here
                      //   // }
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => MyApp()),
                      //   );
                      // },
                    ),
                    SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to forgot password page
                      },
                      child: Text(
                        'Forgot Password?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
