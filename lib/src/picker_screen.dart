import 'package:flutter/material.dart';

import 'countries_data.dart';
import 'country.dart';

class PickerScreen extends StatefulWidget {
  final Color backgroundColor;
  final Color accentColor;
  final Color textColor;
  final double fontSize;
  const PickerScreen({
    super.key,
    required this.accentColor,
    required this.backgroundColor,
    required this.textColor,
    required this.fontSize,
  });

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  TextEditingController searchController = TextEditingController();
  List<Country> searchedResults = [];

  //Holds the loaded Countries after processing from Map to Country type
  List<Country> countries = [];
  //process countriesData from Map to Country
  loadCountries() {
    for (var country in countriesData) {
      setState(() {
        countries.add(
          Country(
            name: country['name'],
            flag: country['flag'],
            code: country['code'],
            dial: country['dial_code'],
          ),
        );
      });
    }
  }

  search({required String text}) {
    setState(() {
      searchedResults.clear();
    });
    for (var country in countries) {
      //Search by Country's name
      if (country.name
          .toLowerCase()
          .contains(text.toLowerCase().replaceAll(" ", ""))) {
        if (searchedResults.contains(country) == false) {
          setState(() {
            searchedResults.add(country);
          });
        }
      }
      //Search by Country's dial code
      if (country.dial
          .toLowerCase()
          .contains(text.toLowerCase().replaceAll(" ", ""))) {
        if (searchedResults.contains(country) == false) {
          setState(() {
            searchedResults.add(country);
          });
        }
      }
    }
  }

  @override
  void initState() {
    loadCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: AppBar(
        backgroundColor: widget.backgroundColor,
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: widget.textColor,
          ),
        ),
        title: searchInputWidget(),
        actions: [
          if (searchController.text.trim().isNotEmpty)
            IconButton(
              onPressed: () {
                setState(() {
                  searchController.clear();
                });
              },
              icon: Icon(
                Icons.close_rounded,
                color: widget.textColor,
              ),
            ),
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: searchedResults.isNotEmpty
            ? searchedResults.length
            : countries.length,
        itemBuilder: (context, index) {
          //depending on if searchResults is empty or not
          Country countryModel = searchedResults.isNotEmpty
              ? searchedResults[index]
              : countries[index];
          return countryWidget(countryModel: countryModel);
        },
      ),
    );
  }

  Widget searchInputWidget() => TextField(
        autofocus: true,
        controller: searchController,
        onChanged: (value) {
          search(text: value);
        },
        style: TextStyle(
          fontSize: widget.fontSize,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search Country or Dial Code",
          hintStyle: TextStyle(
            fontSize: widget.fontSize,
            color: widget.textColor.withOpacity(
              0.3,
            ),
          ),
        ),
      );

  Widget countryWidget({required Country countryModel}) => ListTile(
        onTap: () {
          Navigator.pop(context, countryModel);
        },
        leading: Text(
          countryModel.flag,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        title: Text(
          countryModel.name,
          style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.textColor,
          ),
        ),
        trailing: Text(
          countryModel.dial,
          style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.accentColor,
          ),
        ),
      );
}
