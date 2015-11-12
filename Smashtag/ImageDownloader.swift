//
//  ImageDownloader.swift
//  Smashtag
//
//  Created by Rob Isenberg on 12/11/2015.
//  Copyright © 2015 Rob Isenberg. All rights reserved.
//

import UIKit

struct ImageDownloader {
  
  static func fetchThenHandleOnMainQueue(imageURL: NSURL, handler: NSData -> Void) {

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
      guard let imageData = NSData(contentsOfURL: imageURL) else { return }
      
      dispatch_async(dispatch_get_main_queue()) { handler(imageData) }
    }
  }
}