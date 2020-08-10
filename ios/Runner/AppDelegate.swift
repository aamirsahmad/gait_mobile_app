import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  private func receiveAccelerometerData(result: FlutterResult) {
      result(FlutterError(code: "UNAVAILABLE",
                          message: "accelerometer info unavailable",
                          details: nil))
  }

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let accelerometerDataChannel = FlutterMethodChannel(name: "flutter.prod/accelerometerData",
                                              binaryMessenger: controller.binaryMessenger)

    accelerometerDataChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        // Note: this method is invoked on the UI thread
        if (call.method == "getAccelerometerData") {
          self?.receiveAccelerometerData(result: result)
          return
        }
        result(FlutterMethodNotImplemented)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

