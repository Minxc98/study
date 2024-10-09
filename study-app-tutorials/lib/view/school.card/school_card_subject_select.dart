import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tutorials/component/log/logs.dart';
import 'package:tutorials/locale/translations.dart';
import 'package:tutorials/utils/app_utils.dart';


class SchoolCardSubjectSelect extends StatefulWidget {
  const SchoolCardSubjectSelect({Key? key}) : super(key: key);


  @override
  State<SchoolCardSubjectSelect> createState() => _SchoolCardSubjectSelectState();
}

class _SchoolCardSubjectSelectState extends State<SchoolCardSubjectSelect> {

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: _isSearching ? _buildSearchField() : Text(Translations.textOf(context, "school.card.select.subject.title")),
        actions: _buildActions(),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: List.generate(10, (index) {
                  return ListItem();
                }),
              )
            ],
          ),
        );
      }),
    );

  }


  Widget _buildSearchField() {
    return
    TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: Translations.textOf(context, "all.search.hint"),
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (value) {
        // place submit function here
        Logs.info("onFieldSubmitted=$value");
      },
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _searchQueryController.clear();
              _isSearching = false;
            });
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          setState(() {
            _isSearching = true;
          });
        },
      ),
    ];
  }
}

class ListItem extends StatelessWidget {
  const ListItem({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var random = Random().nextInt(100).toString();
    return GestureDetector(
      onTap: () {
        AppUtils.pop(context,random);
        Logs.info("random=$random");
      },
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/school-logo.png'),
        ),
        title: Text("专业${random}" ),
      ),
    );


  }
}