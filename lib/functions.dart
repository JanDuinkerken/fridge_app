// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//////////////////// Common Functions ////////////////////

String subnetIP = "localhost:5000";

void createDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text(text),
        actions: <Widget>[
          ElevatedButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

SizedBox createInputText(BuildContext context, TextEditingController controller, String labelText, width) {

  return SizedBox(
    width: (MediaQuery.of(context).size.width)*width,
    child: TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      cursorHeight: 20,
      cursorWidth: 1.4,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
    ),
  );
}

SizedBox createSelectDate(context, onTap, text) {
  return SizedBox(
    width: (MediaQuery.of(context).size.width)*0.4,
    child: InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      )
    ),
  );
}

ElevatedButton createButton(context, buttonText, onPressed) {
  return ElevatedButton(
    style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              side: BorderSide(color: Colors.green)
          ),
        ),
        fixedSize: MaterialStateProperty.all(Size((MediaQuery.of(context).size.width)*0.6, (MediaQuery.of(context).size.height)*0.06))
    ),
    child: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 20)),
    onPressed: onPressed,
  );
}

Container createDropdown(String dropdownValue, List<String> listValues, onChanged) {
  return Container(
    padding: EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 1,
          offset: Offset(2.0, 2.0),
        ),
      ],
      borderRadius: BorderRadius.all(Radius.circular(8.0))
    ),
    child: DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 30,
      menuMaxHeight: 200,
      style: TextStyle(color: Colors.black),
      underline: Container(height: 0),
      onChanged: onChanged,
      items: listValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 18)),
        );
      }).toList(),
    ),
  );
}

InkWell createEventCard(context, event, onTap) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      margin: EdgeInsets.only(top:5, left: 10, right: 10, bottom:5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Icon(Icons.info, color: Colors.black, size: 25),
                SizedBox(width: 5),
                Text(event["name"], style: TextStyle(fontSize: 25, color: Colors.black)),
                Spacer(),
                Icon(Icons.person, color: Colors.black, size: 25),
                SizedBox(width: 5),
                Text(event["participants"].length.toString(), style: TextStyle(fontSize: 25, color: Colors.black)),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Icon(Icons.place, color: Colors.black, size: 25),
                SizedBox(width: 5),
                Text(event["facility"], style: TextStyle(fontSize: 25, color: Colors.black)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Icon(Icons.access_time_filled, color: Colors.black, size: 25),
                SizedBox(width: 5),
                Text("From: " + DateFormat("dd-MM-yyyy").format(event["startDate"]) + " ", style: TextStyle(fontSize: 25, color: Colors.black)),
                Text(event["startHour"].toString().split("(")[1].replaceAll(")", ""), style: TextStyle(fontSize: 25, color: Colors.black)),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Icon(Icons.access_time_outlined, color: Colors.black, size: 25),
                SizedBox(width: 5),
                Text("To: " + DateFormat("dd-MM-yyyy").format(event["endDate"]) + " ", style: TextStyle(fontSize: 25, color: Colors.black)),
                Text(event["endHour"].toString().split("(")[1].replaceAll(")", ""), style: TextStyle(fontSize: 25, color: Colors.black)),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    )
  );
}

Card createParticipant(context, participant) {
  return Card(
    elevation: 0,
    color: Colors.transparent,
    child: Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Icon(Icons.person, color: Colors.black, size: 25),
              SizedBox(width: 5),
              Text(participant["name"] + " " + participant["surname"], style: TextStyle(fontSize: 25, color: Colors.black)),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Icon(Icons.info, color: Colors.black, size: 25),
              SizedBox(width: 5),
              Text(participant["uuid"], style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
          ),
        ],
      ),
    ),
  );
}

InkWell createFacilityCard(context, facility, onTap) {
  return InkWell (
      onTap: onTap,
      child: Card (
        elevation: 0,
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        child: Container(
          width: (MediaQuery.of(context).size.width),
          padding: EdgeInsets.only(top: 25, bottom: 25),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(height: 10),
              SizedBox(width: 20),
              Icon(Icons.place, color: Colors.black, size: 25),
              SizedBox(width: 5),
              Text(facility, style: TextStyle(fontSize: 20, color: Colors.black)),
              SizedBox(height: 10),
            ],
          ),
        ),
      )
  );
}
