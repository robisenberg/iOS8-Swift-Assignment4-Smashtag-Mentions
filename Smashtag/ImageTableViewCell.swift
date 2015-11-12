//
//  ImageTableViewCell.swift
//  Smashtag
//
//  Created by Rob Isenberg on 11/11/2015.
//  Copyright © 2015 Rob Isenberg. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
  
  // MARK: - Public API
  
  var imageURL: NSURL? {
    didSet {
      fetchImage()
    }
  }
  
  @IBOutlet weak var mainImageView: UIImageView!
  
  // MARK: - Private API
  
  private func fetchImage() {
    if let url = imageURL {
      dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
        
        let imageData = NSData(contentsOfURL: url)!
        
        dispatch_async(dispatch_get_main_queue()) {
          if self.imageURL == url {
            self.mainImageView?.image = UIImage(data: imageData)
          }
        }
      }
    }
  }
  
  // MARK: - View Controller Lifecycle
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
