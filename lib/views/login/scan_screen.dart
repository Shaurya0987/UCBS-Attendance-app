import 'dart:async';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? cameraController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    var status = await Permission.camera.request();
    if (!status.isGranted) return;

    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
    );

    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController!.initialize();
    if (!mounted) return;

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Stack(
              children: [
                /// 🔥 Full screen camera
                Positioned.fill(child: CameraPreview(cameraController!)),

                /// 🔥 Frosted instruction panel with typing effect
                Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white30),
                        ),
                        child: const TypingInstructionText(
                          fullText:
                              "⚠ FACE SCAN INSTRUCTIONS:\n\n"
                              "• Keep your face inside the frame\n"
                              "• Look straight into the camera\n"
                              "• Avoid backlight for accuracy\n"
                              "• Hold still for 1–2 seconds\n"
                              "• AI will capture 512-D facial embedding",
                        ),
                      ),
                    ),
                  ),
                ),

                /// 🔥 Capture button (bottom)
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        HapticFeedback.mediumImpact();

                        if (cameraController != null &&
                            cameraController!.value.isInitialized) {
                          final file = await cameraController!.takePicture();

                          // TODO: send file.path to face recognition model
                          print("Captured: ${file.path}");
                        }
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

/// ===============================================================
///  🔥 TYPING INSTRUCTION TEXT WIDGET (With vibration each letter)
/// ===============================================================

class TypingInstructionText extends StatefulWidget {
  final String fullText;
  final Duration speed;

  const TypingInstructionText({
    super.key,
    required this.fullText,
    this.speed = const Duration(milliseconds: 35),
  });

  @override
  State<TypingInstructionText> createState() => _TypingInstructionTextState();
}

class _TypingInstructionTextState extends State<TypingInstructionText> {
  String displayedText = "";
  int index = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTyping();
  }

  void startTyping() {
    timer = Timer.periodic(widget.speed, (t) {
      if (index < widget.fullText.length) {
        setState(() {
          displayedText += widget.fullText[index];
        });

        HapticFeedback.selectionClick(); // 🔥 vibrate per character

        index++;
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayedText,
      style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
    );
  }
}
