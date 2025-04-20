import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgamekids/log/service/logManager.dart';
import 'package:vector_math/vector_math_64.dart';

/// AR oturumunu başlatıp, 3D modeli otomatik olarak sahneye ekleyen widget.
class CityARDisplay extends StatefulWidget {
  final String modelPath;
  const CityARDisplay({super.key, required this.modelPath});
  
  @override
  _CityARDisplayState createState() => _CityARDisplayState();
}

class _CityARDisplayState extends State<CityARDisplay> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARNode? modelNode;
  
  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Direkt ARView döndürerek ekrana tıkla tetikleme ihtiyacını kaldırdık.
    return ARView(
      onARViewCreated: onARViewCreated,
    );
  }
  
  void onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
    ARLocationManager locationManager,
  ) {
    try {
      arSessionManager = sessionManager;
      arObjectManager = objectManager;
      
      // AR oturumunu başlatıyoruz: düzlemleri, dünya orijini gibi seçenekleri ayarlıyoruz.
      arSessionManager!.onInitialize(
        showPlanes: true,
        showFeaturePoints: false,
        showWorldOrigin: true,
        customPlaneTexturePath: 'assets/triangle.png', // Opsiyonel: düzlem dokusu
      );
      arObjectManager!.onInitialize();
      
      LogManager().log("AR oturumu başarıyla başlatıldı.");
      
      // Oturum başladıktan sonra sayfa açılır açılmaz model yükleniyor.
      _addARModel();
    } catch (e, s) {
      LogManager().log("AR oturumu başlatılırken hata oluştu: $e, stack trace: $s");
      arSessionManager?.onError("AR oturumu başlatılırken bir hata oluştu.");
    }
  }
  
 Future<void> _addARModel() async {
  try {
    LogManager().log("Model ekleme işlemi başlatılıyor. Model yolu: ${widget.modelPath}");
    
    // Kamera önünde, 30 cm mesafede konumlandırmak için ARNode oluşturuluyor.
    final node = ARNode(
      type: NodeType.localGLTF2,
      uri: widget.modelPath,
      scale: Vector3(0.5, 0.5, 0.5),
      // Kamera önünde 30 cm uzaklık (-0.3 metre z ekseninde)
      position: Vector3(0.0, 0.0, -0.3),
      rotation: Vector4(0.0, 0.0, 0.0, 1.0),
    );
    
    LogManager().log("Oluşturulan ARNode: $node");
    
    // addNode işlemi try-catch bloğuna alındı
    bool didAdd;
                LogManager().log("addNode metodu baslıyor.");

    try {

      didAdd = await arObjectManager!.addNode(node) ?? false;
      LogManager().log("addNode metodu geriye $didAdd döndü.");
    } catch (e, stackTrace) {
      LogManager().log("addNode metodu çalışırken bir istisna oluştu: $e");
      LogManager().log("Stack Trace: $stackTrace");
      didAdd = false;
    }
    
    if (didAdd) {
      setState(() {
        modelNode = node;
      });
      LogManager().log("Model başarıyla yüklendi ve sahneye eklendi. Node detayları: $node");
    } else {
      LogManager().log("Model sahneye eklenemedi.");
      arSessionManager?.onError("3D model sahneye eklenemedi.");
    }
  } catch (e, stackTrace) {
    LogManager().log("Model eklenirken genel bir istisna oluştu: $e");
    LogManager().log("Stack Trace: $stackTrace");
    arSessionManager?.onError("3D model yükleme sırasında bir hata oluştu: $e");
  }
}

}
