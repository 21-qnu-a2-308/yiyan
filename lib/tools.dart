import 'dart:convert' as cvt;
import 'package:http/http.dart' as http;

final class WordsClient {
  late String _currentWho;
  late String _currentFrom;
  late String _currentWords;
  late String _currentStyle;

  WordsClient() {
    _currentStyle = 'i';
    _currentWho = '王勃';
    _currentFrom = '滕王阁序';
    _currentWords = '三尺书生，一介微命';
  }

  Future fetch() async {
    final url = Uri.https('v1.hitokoto.cn', '', {'c': _currentStyle});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonDoc = cvt.jsonDecode(response.body);
      _currentWho = jsonDoc['from_who'] ?? '';
      _currentFrom = jsonDoc['from'] ?? '';
      _currentWords = jsonDoc['hitokoto'] ?? '';
    }
  }

  String getWho() => _currentWho;
  String getFrome() => _currentFrom;
  String getWords() => _currentWords;
  void setStyle(String style) => _currentStyle = style;
}
