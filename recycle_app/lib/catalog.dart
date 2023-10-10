import 'package:flutter/material.dart';
class catalog extends StatefulWidget {
  const catalog({super.key});

  @override
  State<catalog> createState() => _catalogState();
}

class _catalogState extends State<catalog> {
  List<Map<String, dynamic>> record = [
    {
      "title": "Home Waste",
      "desc": "Description for Note 1",
      "image": "assets/images/recycle-296463_1280.png"
    },
    {
      "title": "Metal Waste",
      "desc": "Description for Note 2",
      "image": "assets/images/recycle-bin-155904_1280.png"
    },
    {
      "title": "Plastic Waste",
      "desc": "Description for Note 3",
      "image": "assets/images/plastic-bag-4858198_1280.png"
    },
    {
      'title': 'Earth Waste',
      'desc': 'Description for Note 4',
      "image": "assets/images/earth-575528_1280.png"
    },
    {
      'title': 'Food Waste',
      'desc': 'Description for Note 5',
      "image": "assets/images/compost-7808401_1280.png"
    },
    {
      'title': 'Paper Waste',
      'desc': 'Description for Note 6',
      "image": "assets/images/recycle-296463_1280.png"
    },
    {
      'title': 'Glass Waste',
      'desc': 'Description for Note 7',
      "image": "assets/images/recycle-29231_1280.png"
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
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 128, 70), fontSize: 20),
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
                            ],
                          ),
                          trailing: Image.asset(
                            '${filteredItems[index]["image"]}', // Replace with the path to your image
                            width: 50, // Adjust the width as needed
                            height: 50, // Adjust the height as needed
                          ),
                        ))))
          ],
        ),
        );
  }
}
