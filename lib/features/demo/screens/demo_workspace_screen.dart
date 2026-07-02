import 'package:flutter/material.dart';
import '../../inventory/services/inventory_service.dart';
import '../../home/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class DemoWorkspaceScreen extends StatefulWidget {
  const DemoWorkspaceScreen({Key? key}) : super(key: key);

  @override
  _DemoWorkspaceScreenState createState() => _DemoWorkspaceScreenState();
}

class _DemoWorkspaceScreenState extends State<DemoWorkspaceScreen> {
  @override
  void initState() {
    super.initState();
    // Enable Demo Mode
    InventoryService.isDemoMode = true;
  }

  @override
  void dispose() {
    // Disable Demo Mode when leaving
    InventoryService.isDemoMode = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Banner
          Container(
            width: double.infinity,
            color: Colors.orange.shade700,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.info_outline, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'This is a temporary sandbox session. Data will not be saved.',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white24,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    minimumSize: Size.zero,
                  ),
                  child: Text(
                    'Exit Demo',
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // Wrap the HomePage in Expanded so it takes the rest of the screen
          // We wrap it in a nested Navigator or just Expanded?
          // Since HomePage provides its own Scaffold with AppBar, putting it inside a Column
          // might cause layout issues (Scaffold inside Column inside Scaffold).
          // Let's use Expanded.
          Expanded(
            child: ClipRect(
              child: const HomePage(),
            ),
          ),
        ],
      ),
    );
  }
}
