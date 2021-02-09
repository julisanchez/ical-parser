# ical_parser

A parser for ICalendar files (.ics)

## Usage

A simple usage example:

```dart
import 'package:ical-parser/ical-parser.dart';

main() {
  var calendar = '''
  BEGIN:VCALENDAR
  ...
  END:VCALENDAR
  '''

  var json = ICal.toJson(calendar);
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/julisanchez/ical-parser/issues
