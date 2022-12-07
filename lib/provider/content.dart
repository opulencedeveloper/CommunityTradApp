import "dart:convert";

import 'package:http/http.dart' as http;
import "package:flutter/widgets.dart";

class Content {
  String id;
  String name;
  String details;
  String image;
  String link;
  String videoType;

  Content({
    required this.id,
    required this.name,
    required this.details,
    required this.image,
    required this.link,
    required this.videoType,
  });
}

class Music {
  String audioId;
  String audioName;
  String audioText;
  String audioLink;
  String audioDate;

  Music({
    required this.audioId,
    required this.audioName,
    required this.audioText,
    required this.audioLink,
    required this.audioDate,
  });
}

class Contents extends ChangeNotifier {
  List<Content> _content = [];
  List<Music> _music = [];

  List<Content> get content {
    return [..._content];
  }

  List<Music> get music {
    return [..._music];
  }

  Content findContentById(String id) {
    return _content.firstWhere((food) => food.id == id);
  }

  Future<void> fetchAndSetAllContent() async {
    final url =
        Uri.parse("https://promensil.com.ng/victor/ndienuani/api/all_content");
    try {
      final response = await http.get(url);
      //print(json.decode(response.body));
      final extractedContent = (json.decode(response.body))["content"];
      final extractedMusic = (json.decode(response.body))["music"];
      if (extractedContent == null ||
          extractedContent.isEmpty ||
          extractedMusic == null ||
          extractedMusic.isEmpty) {
        return;
      }
      //print(response.body);
      final List<Content> loadedContent = [];
      for (Map contentData in extractedContent) {
        loadedContent.add(Content(
            id: contentData['content_id'],
            name: contentData['content_name'],
            details: contentData['content_details'],
            image: contentData['content_img'],
            link: contentData['content_link'],
            videoType: contentData['content_type']));
      }

      final List<Music> loadedMusic = [];
      for (Map musicData in extractedMusic) {
        loadedMusic.add(Music(
          audioId: musicData['audio_id'],
          audioName: musicData['audio_name'],
          audioText: musicData['audio_text'],
          audioLink: musicData['audio_link'],
          audioDate: musicData['audio_date'],
        ));
      }

      print('loaded: ');
      print(loadedContent[1].name);
      print(loadedMusic[1].audioName);
      _content = loadedContent;
      _music = loadedMusic;
      notifyListeners();
    } catch (error) {
      print('erroe ');
      rethrow;
    }
  }
}
