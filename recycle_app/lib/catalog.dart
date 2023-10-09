import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class view extends StatefulWidget {
  const view({super.key});

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List<Map<String, dynamic>> record = [
    {
      "title": "Note 1",
      "desc": "Description for Note 1",
      "date": "2023-10-09T12:34:56",
      "image":"assets/images/recycle.png"
    },
    {
      "title": "Note 2",
      "desc": "Description for Note 2",
      "date": "2023-10-10T14:45:30",
      "image":"assets/images/rapidNotes.png"
    }
  ];
  List<Map<String, dynamic>> results = [];
  bool is_loading = true;
  bool is_empty = true;

  void filter(String enteredKeyword) {
    is_empty = false;
    // empty the list results
    results = [];
    print(enteredKeyword);
    print("llllllllllll");
    if (enteredKeyword.isEmpty) {
      results = record;
      // print resuts to console
      print(results);
    } else {
      results = record
          .where((note) => note['title']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // print results to console
      print(results);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredItems;
    if (is_empty) {
      filteredItems = record;
    } else {
      filteredItems = record
          .where((item1) =>
              results.any((item2) => item1["title"] == item2["title"]))
          .toList();
    }
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 133, 198, 137),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 4, 72, 23),
          title: const Text("Catalog"),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (value) => filter(value),
                decoration: const InputDecoration(
                    labelText: 'Search',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 0, 128, 70), fontSize: 20),
                    suffixIcon: Icon(Icons.search),
                    suffixIconColor: Color.fromARGB(255, 0, 128, 70)),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.all(15),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              filteredItems[index]["title"],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 128, 70),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredItems[index]["desc"],
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  DateFormat('dd MMM y –').add_jm().format(
                                      DateTime.parse(
                                          filteredItems[index]["date"])),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff0818A8),
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                          trailing: Image.asset(
                                '${filteredItems[index]["image"]}', // Replace with the path to your image
                                width: 50, // Adjust the width as needed
                                height: 50, // Adjust the height as needed
                              ),
                        ))))
          ],
        ));
  }
}
