import 'package:demo/feed_model.dart';
import 'package:demo/screens/add_new_feed_post_screen.dart';
import 'package:demo/utils/constants.dart';
import 'package:demo/widgets/feed_child_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewFeedPostScreen(),
            ));
      },
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
          //Todo check error for int conversion
          bottom: 0,
        )
      ],
    );
  }

  Widget _getSearchField() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: Constants.FEED_SEARCH_BAR_HEIGHT,
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
    return ValueListenableBuilder(
        valueListenable: Hive.box<FeedModel>(Constants.FEED_DB).listenable(),
        builder: (context, Box<FeedModel> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("No data"),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              return FeedChildWidget(
                key: UniqueKey(),
                feedModel: box.getAt(index)!,
              );
            },
          );
        });
    /*return ListView.separated(
        itemBuilder: (context, index) {
          return FeedChildWidget(
            key: UniqueKey(),
            feedModel: _feeds[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: _feeds.length);*/
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
