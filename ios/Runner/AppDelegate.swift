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
        switch call.method {
          case "accessAccelerometerData" :
            // 1. Check to see if the accelerometer device is availible for access
            if !self.motionManager.isAccelerometerActive {
                print("OPERATION-ERROR -1: Unable to access acceleromter")
                result(FlutterError(code: "UNAVAILABLE",
                    message: "accelerometer info unavailable",
                    details: nil))
            }
            
            // 2. Retreive, process and store acceleromter data from the active device
            self.motionManager.accelerometerUpdateInterval = 1.0
            self.motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                // 1. Process and store availible acc data
                if let data = self.motionManager.accelerometerData
                {
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
                    
                    self.accReadings.append(self.processor.processAccData(x:String(x), y:String(y), z:String(z)))
                }
                 
            }
            
            // 3. Return result indicating success case
            result(String(0))
            
          case "storeAccelerometerData" :
            // 1. Stop retreiving updates from the acceleromter device
            self.motionManager.stopAccelerometerUpdates()
            // 2. Return a message back to the user
            result("This device sampled " + String(self.accReadings.count) + " records.")
          default:
            // 1. Stop retreiving updates from the acceleromter device
            self.motionManager.stopAccelerometerUpdates()
            // 2. Indicate that the message sent over the channel was unable to be read
            result("Data collection failed")
        }
        
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

