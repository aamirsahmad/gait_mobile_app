import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  // These are the references for managers handling how to retreive the results required by a client
  
  // 1. Accelerometer manager which processes raw accelerometer results retreived from a device
  let accManager = AccManager()
  
  // 2.
  // ....


  override func application (
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Logic backing the computed property that determines the truthiness of if the Swift application was
    // launched is defined here:

    // 1. Set up main ViewController and accelerometer data channel to receive from
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let accDataChannel = FlutterMethodChannel(name: "flutter.dev/accelerometerData",
                                              binaryMessenger: controller.binaryMessenger)
  
    // 2. Define event handler to process any queued messages that can now be received
    // with a channel reference being defined

    accDataChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if (call.method == "getAccelerometerData") {
          return
        }
        // 1. Run the logic to access the raw results returned from accessing the sensors on
        // the device (currently the value type assigned to raw results is just a placeholder)
        let rawResults = FlutterError(code: "UNAVAILABLE",
                              message: "accelerometer info unavailable",
                              details: nil)

         // 2. Manage and process all the raw results that have now been returned
        result(self.accManager.processAccData(accResults: rawResults))
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


protocol persistanceRecorder {
  
  func storeData(data: String) -> Int

}

public class AccManager : persistanceRecorder {
      
      func storeData(data: String) -> Int {
        return 0
      }

      public func processAccData(accResults rawResults: FlutterError) -> FlutterError{
            // 1. Process Acc Results
            return rawResults
      }

      init() {

      }
}