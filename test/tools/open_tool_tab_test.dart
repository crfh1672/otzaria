import 'package:flutter_test/flutter_test.dart';
import 'package:otzaria/tools/open_tool_tab.dart';
import 'package:otzaria/tools/tool_catalog_entry.dart';
import 'package:otzaria/tabs/models/tool_tab.dart';

void main() {
  const entry = ToolCatalogEntry(
    toolId: 'com.example.plugin',
    label: 'תוסף',
    order: 1,
  );

  group('newToolTabInstance', () {
    test('הטאב נבנה בלי dedupeKey — פתיחתו לא תמקד טאב קיים', () {
      final tab = newToolTabInstance(entry);
      expect(tab.toolId, 'com.example.plugin');
      expect(tab.title, 'תוסף');
      expect(tab.allowMultipleInstances, isTrue);
      expect(tab.dedupeKey, isNull);
    });

    test('כל קריאה מייצרת מופע ריצה חדש', () {
      final a = newToolTabInstance(entry);
      final b = newToolTabInstance(entry);
      expect(a.instanceId, isNot(b.instanceId));
    });

    test('openToolInstanceCount counts only matching tool IDs', () {
      final a = newToolTabInstance(entry);
      final b = newToolTabInstance(entry);
      final other = ToolTab(
        toolId: 'com.example.other',
        title: 'תוסף אחר',
        allowMultipleInstances: true,
      );

      expect(openToolInstanceCount([a, b, other], entry.toolId), 2);
      expect(openToolInstanceCount([a, b, other], 'com.example.other'), 1);
    });
  });
}
