import 'package:recycle_app/db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class view extends StatefulWidget {
  const view({super.key});

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  
  
  List<Map<String, dynamic>> record = [];
  List<Map<String, dynamic>> results = [];
  bool is_loading = true;
  bool is_empty = true;

  void refresh() async {
    final data = await database.getData();
    setState(() {
      record = data;
      is_loading = false;
    });
  }

  void filter(String enteredKeyword) {
    is_empty = false;
    // empty the list results
    results = [];
    refresh();
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
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  Future<void> update_data(int id) async {
    await database.update_record(
        id, _titleController.text, _descController.text);
    refresh();
  }

  Future<void> add_data() async {
    await database.records(_titleController.text, _descController.text);
    refresh();
  }

  void delete_data(int id) async {
    await database.delete_record(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Center(child: Text("Note has been Deleted")),
      ),
    );
    refresh();
  }


  void show_input_box(int? id) async {
    if (id != null) {
      final existingData =
          record.firstWhere((element) => element["id"] == id);
      _titleController.text = existingData["title"];
      _descController.text = existingData["desc"];
    }

    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 30,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 50,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
                      hintText: "Enter Title",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                      hintText: "Enter Description",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_titleController.text == "") {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error!'),
                              content: const Text('Title cannot be empty!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          if (id != null) {
                            await update_data(id);
                            _titleController.text = "";
                            _descController.text = "";

                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Updated Successful'),
                                content:
                                    const Text('Data Updated successfully!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0818A8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(id == null ? "Add Data" : "Update"),
                    ),
                  )
                ],
              ),
            ));
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
          title: const Text("All Notes"),
        ),
        body: is_loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                              TextStyle(color:  Color.fromARGB(255, 0, 128, 70), fontSize: 20),
                          suffixIcon: Icon(Icons.search),
                          suffixIconColor:  Color.fromARGB(255, 0, 128, 70)),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) => Card(
                              margin: const EdgeInsets.all(15),
                              child: ListTile(
                                title: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    filteredItems[index]["title"],
                                    style: const TextStyle(
                                      color:  Color.fromARGB(255, 0, 128, 70),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        DateFormat('dd MMM y –')
                                            .add_jm()
                                            .format(DateTime.parse(
                                                filteredItems[index]["date"])),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(255, 3, 79, 17),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          show_input_box(filteredItems[index]
                                              ["id"] as int?);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          delete_data(
                                              filteredItems[index]["id"]);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  ],
                                ),
                              ))))
                ],
              ),);
  }
}
