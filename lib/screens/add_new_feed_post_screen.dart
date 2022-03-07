import 'dart:io';

import 'package:demo/feed_model.dart';
import 'package:demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddNewFeedPostScreen extends StatefulWidget {
  const AddNewFeedPostScreen({Key? key}) : super(key: key);

  @override
  State<AddNewFeedPostScreen> createState() => _AddNewFeedPostScreenState();
}

class _AddNewFeedPostScreenState extends State<AddNewFeedPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  late Box _feedBox;

  final ImagePicker _picker = ImagePicker();
  String _filePath = "";

  @override
  void initState() {
    initializeBox();
    super.initState();
  }

  initializeBox() async {
    _feedBox = Hive.box<FeedModel>(Constants.FEED_DB);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
    );
  }

  /// Gets the Appbar for the screen
  AppBar _getAppBar() {
    return AppBar(
      title: const Text(
        "New Post",
      ),
      centerTitle: true,
    );
  }

  /// Get the body for UI
  Widget _getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formState,
          child: Column(
            children: [
              _getTitle(),
              _getSpacing(),
              _getDescription(),
              _getSpacing(),
              _getMediaPreview(),
              _getMediaButton(),
              _getSpacing(),
              _getSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSpacing() {
    return SizedBox(height: 8);
  }

  Widget _getTitle() {
    return TextFormField(
      controller: _titleController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter Title";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Enter title",
        border: _getBorder(Colors.black),
        enabledBorder: _getBorder(Colors.black),
        errorBorder: _getBorder(Colors.red),
      ),
    );
  }

  Widget _getDescription() {
    return TextFormField(
      controller: _discriptionController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter Description";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Enter Description",
        border: _getBorder(Colors.black),
        enabledBorder: _getBorder(Colors.black),
        errorBorder: _getBorder(Colors.red),
      ),
    );
  }

  InputBorder _getBorder(final Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _getMediaPreview() {
    return Visibility(
        visible: _filePath.isNotEmpty,
        child: Container(
          width: double.infinity,
          height: 200,
          padding: EdgeInsets.all(16),
          child: Image.file(
            File(_filePath),
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget _getMediaButton() {
    return ElevatedButton(
        onPressed: () async {
          final XFile? _xFile =
              await _picker.pickImage(source: ImageSource.gallery);
          if (_xFile != null) {
            setState(() {
              _filePath = _xFile.path;
            });
            print("Got file path = ${_xFile.path}");
          }
        },
        child: const Text("Get Media"));
  }

  Widget _getSaveButton() {
    return ElevatedButton(
        onPressed: () {
          if (_formState.currentState!.validate()) {
            if (_filePath.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please select an image"),
              ));
              return;
            }
            _feedBox.add(FeedModel(
                id: DateTime.now().millisecondsSinceEpoch,
                description: _discriptionController.text,
                title: _titleController.text,
                mediaPath: _filePath,
                isFavorite: 0,
                isLiked: 0));
            Navigator.pop(context);
          }
        },
        child: const Text("Save"));
  }

  @override
  void dispose() {
    _discriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }
}
