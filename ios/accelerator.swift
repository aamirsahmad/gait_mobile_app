//
//  accelerator.swift
//  Runner
//
//  Created by Ekram Bhuiyan on 2020-09-03.
//

import Foundation

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
