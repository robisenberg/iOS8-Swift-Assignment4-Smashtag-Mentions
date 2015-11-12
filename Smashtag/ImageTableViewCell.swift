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
      updateUI()
    }
  }
  
  @IBOutlet weak var mainImageView: UIImageView!
  
  // MARK: - Private API
  
  private func updateUI() {
    if let imageURL = imageURL {
      // TODO: This is blocking the main thread!
      mainImageView?.image = UIImage(data: NSData(contentsOfURL: imageURL)!)
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
