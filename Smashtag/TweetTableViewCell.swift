//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Rob Isenberg on 10/11/2015.
//  Copyright © 2015 Rob Isenberg. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet weak var profilePictureImageView: UIImageView!

  @IBOutlet weak var headingTextLabel: UILabel!
  
  @IBOutlet weak var bodyTextLabel: UILabel!

  // MARK: - Model
  
  var tweet: Tweet? = nil {
    didSet {
      updateUI()
    }
  }
  
  // MARK: - View Controller Lifecycle
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - Private API
  
  private func updateUI() {
    resetCell()
    
    if let tweet = self.tweet {
      bodyTextLabel?.attributedText = TweetStringDecorator(tweet: tweet).attributedString()
      headingTextLabel?.text = "\(tweet.user)" // tweet.user.description
      displayProfileImage()
    }
  }
  
  private func resetCell() {
    profilePictureImageView?.image = nil
    headingTextLabel?.attributedText = nil
    bodyTextLabel?.text = nil
  }
  
  // currently blocks main thread!
  // try using something like NSUrlSessionDataTask
  private func displayProfileImage() {
    if let tweet = self.tweet {
      
      if let profileImageURL = tweet.user.profileImageURL {
        
        if let imageData = NSData(contentsOfURL: profileImageURL) {
          profilePictureImageView?.image = UIImage(data: imageData)
        }
      }
    }
  }
}
