import 'package:ical_parser/ical_parser.dart';
import 'package:test/test.dart';

void main() {
  group('.toJson()', () {
    test('Basic calendar', () {
      var calendar = '''
BEGIN:VCALENDAR
VERSION:2.0
CALSCALE:GREGORIAN
BEGIN:VTODO
UID:132456762153245
SUMMARY:Do the dishes
DUE:20121028T115600Z
END:VTODO
END:VCALENDAR
      ''';

      var json = ICal.toJson(calendar);

      expect(json['VERSION'], '2.0');
      expect(json['VTODO'] is List, true);
      expect(json['VTODO'][0]['SUMMARY'], 'Do the dishes');
    });

    test('Basic calendar 2', () {
      var calendar = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//PYVOBJECT//NONSGML Version 1//EN
X-WR-CALNAME;VALUE=TEXT:Go
BEGIN:VEVENT
UID:test@example.com
DTSTART;VALUE=DATE:20190306
CLASS:PRIVATE
DESCRIPTION:Arman and Adrian released their SRT-file parser library for Dar
 t
DTSTAMP;X-VOBJ-FLOATINGTIME-ALLOWED=TRUE:20190306T000000
LOCATION:Heilbronn
PRIORITY:0
RRULE:FREQ=YEARLY
STATUS:CONFIRMED
SUMMARY:SRT-file Parser Release
URL:https://pub.dartlang.org/packages/srt_parser
END:VEVENT
END:VCALENDAR
''';

      var json = ICal.toJson(calendar);

      expect(json['PRODID'], '-//PYVOBJECT//NONSGML Version 1//EN');
      expect(json['X-WR-CALNAME;VALUE=TEXT'], 'Go');
      expect(json['VEVENT'] is List, true);
      expect(json['VEVENT'][0]['DESCRIPTION'],
          'Arman and Adrian released their SRT-file parser library for Dart');
    });

    test('Several VEVENT', () {
      var calendar = '''
BEGIN:VCALENDAR
VERSION:2.0
CALSCALE:GREGORIAN
BEGIN:VEVENT
CREATED:20151219T021727Z
DTEND;TZID=America/Toronto:20170515T110000
DTSTAMP:20151219T022251Z
DTSTART;TZID=America/Toronto:20170515T100000
EXDATE;TZID=America/Toronto:20170516T100000
EXDATE;TZID=America/Toronto:20170517T100000
LAST-MODIFIED:20151219T022251Z
RRULE:FREQ=DAILY;UNTIL=20170519T035959Z
SEQUENCE:0
SUMMARY:Meeting
TRANSP:OPAQUE
UID:21B97459-D97B-4B23-AF2A-E2759745C299
END:VEVENT
BEGIN:VEVENT
CREATED:20151219T022011Z
DTEND;TZID=America/Toronto:20170518T120000
DTSTAMP:20151219T022251Z
DTSTART;TZID=America/Toronto:20170518T110000
LAST-MODIFIED:20151219T022011Z
RECURRENCE-ID;TZID=America/Toronto:20170518T100000
SEQUENCE:0
SUMMARY:Final Meeting
TRANSP:OPAQUE
UID:21B97459-D97B-4B23-AF2A-E2759745C299
END:VEVENT
END:VCALENDAR
''';

      var json = ICal.toJson(calendar);

      expect(json['VEVENT'] is List, true);
      expect((json['VEVENT'] as List).length, 2);
      expect(
          json['VEVENT'][0]['DTEND;TZID=America/Toronto'], '20170515T110000');
      expect(json['VEVENT'][1]['UID'], '21B97459-D97B-4B23-AF2A-E2759745C299');
    });
  });
}
