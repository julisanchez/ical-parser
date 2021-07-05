import 'package:ical_parser/ical_parser.dart';
import 'package:test/test.dart';
import 'dart:io';

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
 t. This line may include a ":".
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
          'Arman and Adrian released their SRT-file parser library for Dart. This line may include a ":".');
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

    test('3-level with VALARM', () {
      var calendar = '''
BEGIN:VCALENDAR
VERSION:2.0
CALSCALE:GREGORIAN
BEGIN:VTODO
UID:fc5f888a-f03f-47fa-a8a4-72bfb8e17a64
DTSTAMP:20180223T164650Z
CREATED:20180223T164650Z
LAST-MODIFIED:20180223T164650Z
DTSTART;TZID=Europe/Zurich:20150921T210000
SUMMARY:summary
SEQUENCE:0
STATUS:COMPLETED
CLASS:PUBLIC
COMPLETED:20180223T164650Z
ATTENDEE;PARTSTAT=NEEDS-ACTION;ROLE=REQ-PARTICIPANT;CUTYPE=INDIVIDUAL;RSVP=
 TRUE:mailto:lskdjflfds@sldfj.ch
ORGANIZER;CN=John Doe:mailto:doe@test.com
BEGIN:VALARM
ACTION:DISPLAY
TRIGGER:+PT1M
DESCRIPTION:description of this todo
DURATION:PT5S
REPEAT:0
END:VALARM
END:VTODO
END:VCALENDAR
''';

      var json = ICal.toJson(calendar);

      expect(json['VTODO'] is List, true);
      expect((json['VTODO'] as List).length, 1);
      expect(json['VTODO'][0]['DTSTART;TZID=Europe/Zurich'], '20150921T210000');
    });

    test('Very Long attachment', () async {
      final file = new File('test/verylong.ical');
      var calendar = await file.readAsString();
      var json = ICal.toJson(calendar);
      expect(json['VEVENT'] is List, true);
      expect((json['VEVENT'] as List).length, 1);
      expect(json['VEVENT'][0]['UID'],
          'FC6B162CBC756D4E2A6B721FAB76E46F-EE2A0FE17AA33F02');
      expect(
          json['VEVENT'][0][
                  'ATTACH;VALUE=BINARY;ENCODING=BASE64;FMTTYPE=image/jpeg;X-LABEL=20161203_194341.jpg']
              .length,
          3380152);
    });
  });
}
