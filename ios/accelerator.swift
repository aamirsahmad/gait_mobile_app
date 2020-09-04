//
//  accelerator.swift
//  Runner
//
//  Created by Ekram Bhuiyan on 2020-09-03.
//

import Foundation
import CoreMotion

protocol persistanceRecorder {
  
  func storeData(data: String) -> Int

}

public class AccManager : persistanceRecorder {
      
      func storeData(data: String) -> Int {
        return 0
      }
    
    func getAccData() -> String {
        // 1. Create local instance of motion manager
        let motionManager = CMMotionManager()
        
        // 2. Check to see if accelerometer data is availible for access
        if !motionManager.isAccelerometerActive {
            // return a message indicating what failed as part of the process to get acceleromater data s
            return "OPERATION-ERROR -1 : The acceleromter system is not availible for use."
        }
        
        // 3. Retreive data from accelerometer system using the motion manager interface
        
            // Define the sampling rate over the device
        motionManager.accelerometerUpdateInterval = 0.1
            // Define call back logic for handling what to do when a sample is taken
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let acceleromterData = data {
                // For now the logic is just to print the accelerometer data
                print(acceleromterData)
            }
        }
       
        // 4. Return result (currently a placeholder)
        return "x: 0.00000 y: 0.00000 z: 0.00000 @509093.787878"
        
    }

      public func processAccData(accResults rawResults: FlutterError) -> FlutterError{
            // 1. Process Acc Results
            return rawResults
      }

      init() {

      }
}
