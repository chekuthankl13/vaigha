// To parse this JSON data, do
//
//     final hooks = hooksFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

Hooks hooksFromJson(String str) => Hooks.fromJson(json.decode(str));

String hooksToJson(Hooks data) => json.encode(data.toJson());

class  Hooks {
    Hooks({
        required this.hooks,
    });

    List<Hook> hooks;

    factory Hooks.fromJson(Map<String, dynamic> json) => Hooks(
        hooks: List<Hook>.from(json["hooks"].map((x) => Hook.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "hooks": List<dynamic>.from(hooks.map((x) => x.toJson())),
    };
}

class Hook {
    Hook({
        required this.name,
        required this.file,
        required this.type,
        required this.doc,
    });

    String? name;
    String? file;
    Type? type;
    Doc doc;

    factory Hook.fromJson(Map<String, dynamic> json) => Hook(
        name: json["name"],
        file: json["file"],
        type: typeValues.map[json["type"]],
        doc: Doc.fromJson(json["doc"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "file": file,
        "type": typeValues.reverse![type],
        "doc": doc.toJson(),
    };
}

class Doc {
    Doc({
        required this.description,
        required this.longDescription,
        required this.tags,
        required this.longDescriptionHtml,
    });

    String description;
    String longDescription;
    List<Tag> tags;
    String longDescriptionHtml;

    factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        description: json["description"],
        longDescription: json["long_description"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        longDescriptionHtml: json["long_description_html"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "long_description": longDescription,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "long_description_html": longDescriptionHtml,
    };
}

class Tag {
    Tag({
        required this.name,
        required this.content,
        required this.types,
        required this.variable,
        required this.description,
        required this.refers,
        required this.link,
    });

    Name? name;
    String? content;
    List<String>? types;
    String? variable;
    String? description;
     String? refers;
    String? link;

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: nameValues.map[json["name"]],
        content: json["content"],
        types: json["types"] == null ? null : List<String>.from(json["types"].map((x) => x)),
        variable: json["variable"],
        description: json["description"],
        refers: json["refers"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "name": nameValues.reverse![name],
        "content": content,
        "types": types == null ? null : List<dynamic>.from(types!.map((x) => x)),
        "variable": variable,
        "description": description,
        "refers": refers,
        "link": link,
    };
}

enum Name { PRIVATE, SINCE, PARAM, SEE, DEPRECATED, LINK, TODO }

final nameValues = EnumValues({
    "deprecated": Name.DEPRECATED,
    "link": Name.LINK,
    "param": Name.PARAM,
    "private": Name.PRIVATE,
    "see": Name.SEE,
    "since": Name.SINCE,
    "todo": Name.TODO
});

enum Type { ACTION, ACTION_REFERENCE }

final typeValues = EnumValues({
    "action": Type.ACTION,
    "action_reference": Type.ACTION_REFERENCE
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
