// To parse this JSON data, do
//
//     final functions = functionsFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

Functions functionsFromJson(String str) => Functions.fromJson(json.decode(str));

String functionsToJson(Functions data) => json.encode(data.toJson());

class Functions {
    Functions({
        required this.definitions,
    });

    List<Definition> definitions;

    factory Functions.fromJson(Map<String, dynamic> json) => Functions(
        definitions: List<Definition>.from(json["Definitions"].map((x) => Definition.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Definitions": List<dynamic>.from(definitions.map((x) => x.toJson())),
    };
}

class Definition {
    Definition({
        required this.name,
        required this.since,
        required this.deprecated,
    });

    String name;
    String since;
    Deprecated? deprecated;

    factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        name: json["Name"],
        since: json["Since"],
        deprecated: deprecatedValues.map[json["Deprecated"]],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Since": since,
        "Deprecated": deprecatedValues.reverse![deprecated],
    };
}

enum Deprecated { NO, THE_280, THE_290, THE_300, THE_350, THE_430, THE_390, THE_370, THE_470, THE_330, THE_340, THE_450, THE_220, THE_250, THE_440, THE_200, THE_260, THE_210, THE_320, THE_400, THE_310, THE_270, THE_151, THE_380, THE_360, MU, THE_120, THE_230, THE_460, THE_150, THE_0710, THE_480, THE_341 }

final deprecatedValues = EnumValues({
    "MU": Deprecated.MU,
    "No": Deprecated.NO,
    "0.71.0": Deprecated.THE_0710,
    "1.2.0": Deprecated.THE_120,
    "1.5.0": Deprecated.THE_150,
    "1.5.1": Deprecated.THE_151,
    "2.0.0": Deprecated.THE_200,
    "2.1.0": Deprecated.THE_210,
    "2.2.0": Deprecated.THE_220,
    "2.3.0": Deprecated.THE_230,
    "2.5.0": Deprecated.THE_250,
    "2.6.0": Deprecated.THE_260,
    "2.7.0": Deprecated.THE_270,
    "2.8.0": Deprecated.THE_280,
    "2.9.0": Deprecated.THE_290,
    "3.0.0": Deprecated.THE_300,
    "3.1.0": Deprecated.THE_310,
    "3.2.0": Deprecated.THE_320,
    "3.3.0": Deprecated.THE_330,
    "3.4.0": Deprecated.THE_340,
    "3.4.1": Deprecated.THE_341,
    "3.5.0": Deprecated.THE_350,
    "3.6.0": Deprecated.THE_360,
    "3.7.0": Deprecated.THE_370,
    "3.8.0": Deprecated.THE_380,
    "3.9.0": Deprecated.THE_390,
    "4.0.0": Deprecated.THE_400,
    "4.3.0": Deprecated.THE_430,
    "4.4.0": Deprecated.THE_440,
    "4.5.0": Deprecated.THE_450,
    "4.6.0": Deprecated.THE_460,
    "4.7.0": Deprecated.THE_470,
    "4.8.0": Deprecated.THE_480
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
