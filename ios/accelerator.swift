//
//  accelerator.swift
//  Runner
//
//  Created by Ekram Bhuiyan on 2020-09-03.
//

import Foundation
import CoreMotion

// prototype meant to define contact over different implementation for processing
// data that has been retreived
protocol rawDataProcessor {
  
  func processAccData(x: String, y: String, z: String) -> String

}

public class accProcessor :rawDataProcessor {
    
    
    public func processAccData(x: String, y: String, z: String) -> String {

            // 1. Process Acc Results
            // ...
        
            // 2. return processed results
            return x + "," + y + "," + z
      }

      init() {

      }
}
