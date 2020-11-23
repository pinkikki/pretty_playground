// GENERATED CODE - DO NOT MODIFY BY HAND

// Currently loading model from "JSON" which always encodes with double quotes
// ignore_for_file: prefer_single_quotes

import 'package:objectbox/objectbox.dart';
export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file
import 'main_objectbox.dart';

ModelDefinition getObjectBoxModel() {
  final model = ModelInfo.fromMap({
    "entities": [
      {
        "id": "1:2891452183234823207",
        "lastPropertyId": "2:4961487430046520575",
        "name": "Task",
        "properties": [
          {"id": "1:3016343159538246930", "name": "id", "type": 6, "flags": 1},
          {"id": "2:4961487430046520575", "name": "name", "type": 9}
        ]
      }
    ],
    "lastEntityId": "1:2891452183234823207",
    "lastIndexId": "0:0",
    "lastRelationId": "0:0",
    "lastSequenceId": "0:0",
    "modelVersion": 5
  }, check: false);

  final bindings = <Type, EntityDefinition>{};
  bindings[Task] = EntityDefinition<Task>(
      model: model.findEntityByUid(2891452183234823207),
      reader: (Task inst) => {'id': inst.id, 'name': inst.name},
      writer: (Map<String, dynamic> members) {
        final r = Task();
        r.id = members['id'];
        r.name = members['name'];
        return r;
      });

  return ModelDefinition(model, bindings);
}

class Task_ {
  static final id =
      QueryIntegerProperty(entityId: 1, propertyId: 1, obxType: 6);
  static final name =
      QueryStringProperty(entityId: 1, propertyId: 2, obxType: 9);
}
