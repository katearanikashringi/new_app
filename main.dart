import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My DIARY',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleHomePage(title: 'MY DIARY'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  ExampleHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('text here'),
            _defaultLockScreenButton(context),
            



          ],
        ),
      ),
    );
  }

  _defaultLockScreenButton(BuildContext context) => MaterialButton(
        color: Theme.of(context).primaryColor,
        child: Text('ENTER THE PASSWORD'),
        onPressed: () {
            Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Page2() ));
          _showLockScreen(
            context,
            opaque: false,
            cancelButton: Text(
              'Cancel',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Cancel',
            ),
          );
        },
      );

  
  _showLockScreen(BuildContext context,
      {bool opaque,
      CircleUIConfig circleUIConfig,
      KeyboardUIConfig keyboardUIConfig,
      Widget cancelButton,
      List<String> digits}) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) => PasscodeScreen(
            title: Text(
              'Enter App Passcode',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: Text(
              'Delete',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Delete',
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
            digits: digits,
          ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = '123456' == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
    
  }
}

    
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu),color: Colors.white, onPressed: null,),
        title: Text('DIARY'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.card_giftcard), onPressed: null),
        ],),
      body:GridView.count(crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 0.9,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: <Widget>[
        myGridItems("ROMANTIC DAY ","https://bit.ly/2Etddzy",),
        myGridItems("ADVENTURE DAY","https://bit.ly/31wMg6T",),
        myGridItems("SAD DAY","https://bit.ly/2YUCJoH",),
        myGridItems("OLD MEMORIES","https://bit.ly/3jnfxXT",),
        myGridItems("PLANNIG","https://bit.ly/32tynWn",),
        myGridItems("DREAM","https://bit.ly/2D3e2OV",),
       
      ],
      ),
      
    );
  }
   Widget  myGridItems( String gridName,String gridImage,){
     return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
             
             gradient: new LinearGradient(colors: [Colors.blue,Colors.white38,],
             begin: Alignment.centerLeft,
             
             end: Alignment(1.0, 1.0,),
             ),
           ),
           child: Stack(
             children: <Widget>[
               Opacity(opacity: 0.3,
               child: Container(
                  decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          image: DecorationImage(image: new NetworkImage(gridImage),
          fit: BoxFit.fill
          ),

               ),),
               ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child:Text("MY",style: TextStyle(color:Colors.black,fontSize: 16),),
                      ),
                      SizedBox(width: 10.0,),
                      Container(child: Icon(Icons.calendar_today,color:Colors.white,),
                      ),
                       SizedBox(width: 10.0,),
                      Container(child:Text("DIARY",style: TextStyle(color: Colors.black,fontSize: 16.0),
                      ),),
                
                

                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Padding(padding: const EdgeInsets.only(left:16.0),
                child: Text(gridName,
                style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
              ],
            ),
            
            
            
            
            
             ],
     ),
     );
   }
}