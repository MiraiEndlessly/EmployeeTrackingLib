import 'package:flutter/material.dart';
import 'home_page.dart';

class ConfrimPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => Comfrim();
}

class Comfrim extends State<ConfrimPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(''),
        actions: <Widget>[
        ],
      ),

      body: Center(

        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[

            RaisedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text('Sed law',
                style: TextStyle(color: Colors.white),),
              icon: Icon(Icons.check, color: Colors.white,),
              textColor: Colors.white,
              color: Colors.green,),

          ],
        ),
      ),
    );
  }
}
