//
//  accelerator.swift
//  Runner
//
//  Created by Ekram Bhuiyan on 2020-09-03.
//

import Foundation
import CoreMotion

// prototype meant to define contact over different implementation for storing
// data that has been retreived
protocol persistanceRecorder {
  
  func storeAccData(data: String) -> Int

}

public class AccManager : persistanceRecorder {
    
    
      func storeAccData(data: String) -> Int {
        // Return result indicating success (logic for processes data storage doesn't exist
        return 0
      }
    
    func getAccData() -> Int {
        // 1. Create local instance of motion manager
        let motionManager = CMMotionManager()
        
        // 2. Check to see if accelerometer data is availible for access
        if !motionManager.isAccelerometerActive {
            // return a message indicating what failed as part of the process to get acceleromater data s
            print("OPERATION-ERROR -1 : The acceleromter system is not availible for use.")
            return -1
        }
        
        // 3. Retreive data from accelerometer system using the motion manager interface
        
            // Define the sampling rate over the device
        motionManager.accelerometerUpdateInterval = 0.1
            // Define call back logic for handling what to do when a sample is taken
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            // For now the logic is just to print dummy the accelerometer data
            print("x: 0.00000 y: 0.00000 z: 0.00000 @509093.787878")
           
        }
       
        // 4. Return result indicating success
        return 0
        
    }

      public func _processAccData(accResults rawResults: FlutterError) -> FlutterError{
            // 1. Process Acc Results
            // ...
        
            // 2. return processed results
            return rawResults
      }

      init() {

      }
}
