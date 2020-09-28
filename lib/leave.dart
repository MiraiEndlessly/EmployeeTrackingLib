import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "";

  @override
  DropDownState createState() => DropDownState();
}

class leavecase {
  int id;
  String name;

  leavecase(this.id, this.name);

  static List<leavecase> getCompanies() {
    return <leavecase>[
      leavecase(1, 'ลากิจ'),
      leavecase(2, 'ลาป่วย'),
      leavecase(3, 'พักร้อน'),
      leavecase(4, 'การลาหยุดเพื่อดูแลครอบครัว'),
      leavecase(5, 'ลาคลอด'),
      leavecase(6, 'ลาไปเรียนต่อ'),
      leavecase(7, 'ลาไปแต่งงาน'),
    ];
  }
}

class DropDownState extends State<DropDown> {
  //
  List<leavecase> _companies = leavecase.getCompanies();
  List<DropdownMenuItem<leavecase>> _dropdownMenuItems;
  leavecase _selectedleave;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedleave = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<leavecase>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<leavecase>> items = List();
    for (leavecase company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(leavecase selectedCompany) {
    setState(() {
      _selectedleave = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("หน้าลางาน"),
        ),
        body: new Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(""),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton(
                  value: _selectedleave,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Selected: ${_selectedleave.name}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}