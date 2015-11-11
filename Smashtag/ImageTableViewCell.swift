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
  
//  private var aspectRatioConstraint: NSLayoutConstraint? {
//    willSet {
//      if let existingConstraint = aspectRatioConstraint {
//        mainImageView.removeConstraint(existingConstraint)
//      }
//    }
//    didSet {
//      if let newConstraint = aspectRatioConstraint {
//        mainImageView.addConstraint(newConstraint)
//      }
//    }
//  }
//  
//  private var mainImage: UIImage? {
//    get {
//      return mainImageView.image
//    }
//    set {
//      mainImageView.image = newValue
//      if let constrainedView = mainImageView {
//        if let newImage = newValue {
//          let aspectRatio = newImage.size.width / newImage.size.height
//          
//          aspectRatioConstraint =
//            NSLayoutConstraint(
//              item: constrainedView, attribute: .Width,
//              relatedBy: .Equal,
//              toItem: constrainedView, attribute: .Height,
//              multiplier: aspectRatio,
//              constant: 0
//          )
//        } else {
//          aspectRatioConstraint = nil
//        }
//      }
//    }
//  }
  
  @IBOutlet weak var mainImageView: UIImageView!
  
  // MARK: - Private API
  
  private func updateUI() {
    if let imageURL = imageURL {
      // TODO: This is blocking the main thread!
      mainImageView?.image = UIImage(data: NSData(contentsOfURL: imageURL)!)
//      mainImage = UIImage(data: NSData(contentsOfURL: imageURL)!)
    }
  }
  
  // MARK: - View Controller Lifecycle
  
//  override func prepareForReuse() {
//    super.prepareForReuse()
//    aspectRatioConstraint = nil
//  }
  
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
