import 'dart:collection';

class ICal {
  static Map<String, dynamic> toJson(String calData) {
    var cal = <String, dynamic>{};

    var currentMap = cal;
    var currentPath = Queue();

    // Lines, but exclude continuations (followed by a whitespace)
    var lines = calData.split(RegExp(r'\n(?!\s)'));

    for (var line in lines) {
      // Remove \n\s in case of continuations from the string
      line = line.replaceAll(RegExp(r'\n\s'), '');
      var index = line.indexOf(':');
      if (index < 0) {
        print('Invalid line: ' + line);
        continue;
      }

      var key = line.substring(0, index);

      // I'm not quite sure why we need trim(), but we do.
      var value = line.substring(index + 1).trim();
      // print('Key: $key');
      // print('Value: |$value|');

      if (key == 'BEGIN') {
        // Skip
        if (value == 'VCALENDAR') {
          continue;
        }

        // Create array
        if (!currentMap.containsKey(value)) {
          currentMap[value] = [];
        }

        // Add new object
        var list = currentMap[value] as List;
        list.add(<String, dynamic>{});

        // Set new current position
        currentMap = list.last;
        currentPath.add(value);
      } else if (key == 'END') {
        if (value == 'VCALENDAR') return cal;

        // cd ./
        currentPath.removeLast();
        currentMap = _processPath(cal, currentPath);
      } else {
        currentMap[key] = value;
      }
    }

    return cal;
  }

  static Map<String, dynamic> _processPath(
      Map<String, dynamic> map, Queue path) {
    for (var p in path) {
      map = map[p];
    }

    return map;
  }
}
