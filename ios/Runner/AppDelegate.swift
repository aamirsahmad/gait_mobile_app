import UIKit
import Flutter
import CoreMotion

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  // These are the references for managers and resources that handle how to retreive the results required by a client
  
  // 1. Library to retrieve raw acceleromter results from the device
  let motionManager = CMMotionManager();
  
  // 2. processor to convert which processes raw accelerometer results retreived from a device
  let processor = accProcessor()
  
  
  // ....
  
  var accReadings = [String]()

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
        // 1. Run the logic to access the raw results returned from accessing the sensors on
        // the device (currently the value type assigned to raw results is just a placeholder)
        switch call.method {
          case "accessAccelerometerData" :
            self.motionManager.accelerometerUpdateInterval = 1.0
            self.motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
              // For now the logic is just to print dummy the accelerometer data
                if self.motionManager.isAccelerometerAvailable {
                    if let data = self.motionManager.accelerometerData 
                    {
                        let x = data.acceleration.x
                        let y = data.acceleration.y
                        let z = data.acceleration.z
                        
                        self.accReadings.append(self.processor.processAccData(x:String(x), y:String(y), z:String(z)))
                        print(self.accReadings.count)
                    // Use the accelerometer data in your app.
                    }
              }     
            }
            result(String(0))
          case "storeAccelerometerData" :
            self.motionManager.stopAccelerometerUpdates()
            result("This device sampled " + String(self.accReadings.count) + " records.")
          default:
            self.motionManager.stopAccelerometerUpdates()
            result("Data collection failed")
        }
        
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

