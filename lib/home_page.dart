import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'todo.dart';
import 'dart:async';
import 'provider_widget.dart';
import 'Maps.dart';
import 'leave.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final databaseReference = Firestore.instance;
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  /* Query _todoQuery;

  //bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    //_checkEmailVerification();

    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("todo")
        .orderByChild("userId")
        .equalTo(widget.userId);
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =
        _todoQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] =
          Todo.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Todo.fromSnapshot(event.snapshot));
    });
  } */

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }



  logoutpopout(BuildContext context) {
    return showDialog(context: context,builder: (context){
      return AlertDialog (
        title: Text("แน่จะว่าจะออกจากระบบ ?"),
        actions: <Widget>[
          MaterialButton(
          elevation: 5.0,
          child: Text('ไม่'),
          onPressed: () {
            Navigator.of(context).pop();
          }),
          MaterialButton(
          elevation: 5.0,
          child: Text('ใช่'),
          onPressed: signOut,
          ),
        ],
      );
    });
  }

  checkoutpopout(BuildContext context) {
    return showDialog(context: context,builder: (context){
      return AlertDialog (
        title: Text("Checkout Confirm"),
        actions: <Widget>[
          MaterialButton(
              elevation: 5.0,
              child: Text('ไม่'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          MaterialButton(
            elevation: 5.0,
            child: Text('ใช่'),
            onPressed: () {
          Navigator.of(context).pop();
          },
          ),
        ],
      );
    });
  }

  addNewTodo(String todoItem) {
    if (todoItem.length > 0) {
      Todo todo = new Todo(todoItem.toString(), widget.userId, false);
      _database.reference().child("todo").push().set(todo.toJson());
    }
  }

  updateTodo(Todo todo) {
    //Toggle completed
    todo.completed = !todo.completed;
    if (todo != null) {
      _database.reference().child("todo").child(todo.key).set(todo.toJson());
    }
  }

  deleteTodo(String todoId, int index) {
    _database.reference().child("todo").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    });
  }

  showAddTodoDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new todo',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    addNewTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

/*  Widget showTodoList() {
    if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = _todoList[index].key;
            String subject = _todoList[index].subject;
            bool completed = _todoList[index].completed;
            String userId = _todoList[index].userId;
            return Dismissible(
              key: Key(todoId),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                deleteTodo(todoId, index);
              },
              child: ListTile(
                title: Text(
                  subject,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: IconButton(
                    icon: (completed)
                        ? Icon(
                            Icons.done_outline,
                            color: Colors.green,
                            size: 20.0,
                          )
                        : Icon(Icons.done, color: Colors.grey, size: 20.0),
                    onPressed: () {
                      updateTodo(_todoList[index]);
                    }),
              ),
            );
          });
    } else {
      return Center(
          child: Text(
        "Welcome. Your list is empty",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }
  }*/

  Widget AppLogo(){
    return Container(width: 100.0, height: 100.0, child: Image.asset('assets/kmutnb.png'),);
  }

  Widget HeaderName(){
    return DrawerHeader (
        child: Column(
        children: <Widget>[
        AppLogo(),SizedBox(height:10.0,),
        LoginName(),SizedBox(height:2.0,),
      ],
    ),
    );
  }

  Widget LoginName(){
          return Text("data");
      }


  /*Widget LoginName(){
    FutureBuilder(future: Provider.of(context).auth.getCurrentUID(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return Text(
          'Login By : ("${snapshot.data}")', style: TextStyle(fontSize: 18),);
      }
      else {
        return CircularProgressIndicator();
      }
    }
    );
  }*/

  Widget TimeList(){
    return Text('Server Time',style: TextStyle(fontSize: 18),);
  }

  Widget DayServer(){
    return Text('วันนี้เป็นวันที่ : 29/07/2540',style: TextStyle(fontSize: 15),);
  }

  Widget TimeServer(){
    return Text('ตอนนี้เป็นเวลา : 00.00.00 AM',style: TextStyle(fontSize: 15),);
  }

  Widget SaveTime(){
    return Text('บัททึกเวลา',style: TextStyle(fontSize: 18),);
  }

  @override

  Widget build(BuildContext context) {
    /*StreamBuilder(
      stream: Firestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
                Text("Loading . . . "),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                                snapshot.data.documents[index].documentID),
                            subtitle: Text(snapshot
                                .data.documents[index].data["firstName"]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }*/
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Checkin App'),
          actions: <Widget>[
          ],
        ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            InkWell(
              onTap: (){ Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (context) => DropDown())); },
              child: ListTile(
                title: Text('ลางาน'),
                leading: Icon(Icons.edit_location),
              ),
            ),

            InkWell(
              onTap: (){ Navigator.pop(context); logoutpopout(context);  },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),

        body: SafeArea(

      child: ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[

        HeaderName(),SizedBox(height:2.5,),

        TimeList(),SizedBox(height:10.0,),
        DayServer(),
        TimeServer(),SizedBox(height:10.0,),

        SaveTime(),SizedBox(height:2.5,),

        RaisedButton.icon(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyMapApp()));
    },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          label: Text('Check In',
            style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.check, color:Colors.white,),
          textColor: Colors.white,
          color: Colors.green,),

        SizedBox(width: 25),

      RaisedButton.icon(
        onPressed: (){ checkoutpopout(context); },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        label: Text('Check Out',
          style: TextStyle(color: Colors.white),),
        icon: Icon(Icons.close, color:Colors.white,),
        textColor: Colors.white,
        color: Colors.red,),
      ],
    ),
    ),
    );
  }
}