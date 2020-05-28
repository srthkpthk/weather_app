import 'package:flutter/material.dart';

/// General utility widget used to render a cell divided into three rows
/// First row displays [label]
/// second row displays [imageData]
/// third row displays [value]
class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final String imageData;

  ValueTile(this.label, this.value, {this.imageData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.blue.shade100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            this.label,
            style: TextStyle(color: Colors.blue),
          ),
          SizedBox(
            height: 5,
          ),
          this.imageData != null
              ? Image.network(
                  imageData,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          SizedBox(
            height: 10,
          ),
          Text(
            this.value,
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
