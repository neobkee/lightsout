class Metadata {
  final String line;
  final String description;
  final String timestamp;

  Metadata({
    required this.line,
    required this.description,
    required this.timestamp,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      line: json['line'],
      description: json['description'],
      timestamp: json['timestamp'],
    );
  }
}

class BoxPosition {
  final int position;
  final int color;

  BoxPosition({required this.position, required this.color});

  factory BoxPosition.fromJson(Map<String, dynamic> json) {
    return BoxPosition(
      position: json['position'],
      color: json['color'],
    );
  }
}

class Summary {
  final int red;
  final int green;
  final int blue;
  final int empty;

  Summary({
    required this.red,
    required this.green,
    required this.blue,
    required this.empty,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      red: json['red'],
      green: json['green'],
      blue: json['blue'],
      empty: json['empty'],
    );
  }
}

class Tray {
  final String trayId;
  final String location;
  final List<BoxPosition> positions;
  final Summary summary;
  final String status;

  Tray({
    required this.trayId,
    required this.location,
    required this.positions,
    required this.summary,
    required this.status,
  });

  factory Tray.fromJson(Map<String, dynamic> json) {
    return Tray(
      trayId: json['trayId'],
      location: json['location'],
      positions: (json['boxes']['positions'] as List)
          .map((e) => BoxPosition.fromJson(e))
          .toList(),
      summary: Summary.fromJson(json['summary']),
      status: json['status'],
    );
  }
}

class TrayResponse {
  final Metadata metadata;
  final List<Tray> trays;

  TrayResponse({
    required this.metadata,
    required this.trays,
  });

  factory TrayResponse.fromJson(Map<String, dynamic> json) {
    return TrayResponse(
      metadata: Metadata.fromJson(json['metadata']),
      trays: (json['trays'] as List)
          .map((e) => Tray.fromJson(e))
          .toList(),
    );
  }
}
