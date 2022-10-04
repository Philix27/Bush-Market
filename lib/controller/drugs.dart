import 'package:bush_market/api/drugs.dart';
import 'package:bush_market/models/brandDrugs.dart';

class DrugsDb {
  static DrugsApi notesAPI = DrugsApi();

  static Future<List<BrandDrugs>> getAllBrands() async {
    List<BrandDrugs> _notes = [];
    try {
      var listOfMaps = await notesAPI.getAllBrands();
      for (var i in listOfMaps) {
        _notes.add(BrandDrugs.fromMap(i));
      }
    } catch (e) {
      // print(e);
    }

    return _notes;
  }
}
