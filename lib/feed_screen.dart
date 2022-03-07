import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      floatingActionButton: _getFloatingActionButton(),
      body: _getBody(),
    );
  }

  /// Gets the Appbar for the screen
  AppBar _getAppBar() {
    return AppBar(
      title: const Text(
        "Feed",
      ),
      centerTitle: true,
    );
  }

  /// Gets the floating action button which will redirect to create new screen
  Widget _getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }

  /// Gets the main body for the app which contains a searchbar and a listview
  Widget _getBody() {
    return Stack(
      children: [
        Positioned(
          child: _getSearchField(),
          left: 0,
          right: 0,
          top: 0,
        ),
        Positioned(
          child: _getFeedItems(),
          left: 0,
          right: 0,
          top: 120,
          bottom: 0,
        )
      ],
    );
  }

  Widget _getSearchField() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 120,
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search",
          border: _getBorder(Colors.black),
          enabledBorder: _getBorder(Colors.black),
          errorBorder: _getBorder(Colors.red),
        ),
      ),
    );
  }

  InputBorder _getBorder(final Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _getFeedItems() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 100,
            color: Colors.red,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 10);
  }
}
