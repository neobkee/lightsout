import 'package:flutter/material.dart';
import 'models.dart';
import 'color_helper.dart';

class TrayWidget extends StatefulWidget {
  final Tray tray;

  const TrayWidget({super.key, required this.tray});

  @override
  State<TrayWidget> createState() => _TrayWidgetState();
}

class _TrayWidgetState extends State<TrayWidget> {

  @override
  Widget build(BuildContext context) {
    final tray = widget.tray;

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tray: ${tray.trayId}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  tray.status,
                  style: TextStyle(
                    color: tray.status == "ok"
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Grid 2x3
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final box = tray.positions[index];
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: getColor(box.color),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${box.position}",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            // Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummary("R", tray.summary.red, Colors.red),
                _buildSummary("G", tray.summary.green, Colors.green),
                _buildSummary("B", tray.summary.blue, Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(String label, int count, Color color) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        Text("$count"),
      ],
    );
  }
}
