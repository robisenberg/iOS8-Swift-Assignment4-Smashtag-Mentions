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
  
  // MARK: - Private
  
  private func updateUI() {
    resetCell()
    guard let tweet = self.tweet else { return }

    bodyTextLabel?.attributedText = TweetStringDecorator(tweet: tweet).attributedString()
    headingTextLabel?.text = "\(tweet.user)" // tweet.user.description
    displayProfileImage()
  }
  
  private func resetCell() {
    profilePictureImageView?.image = nil
    headingTextLabel?.attributedText = nil
    bodyTextLabel?.text = nil
  }
  
  private func displayProfileImage() {
    guard let tweet = self.tweet else { return }
    guard let profileImageURL = tweet.user.profileImageURL else { return }
    
    ImageDownloader.fetchThenHandleOnMainQueue(profileImageURL) { (imageData) -> Void in
      guard self.tweet?.user.profileImageURL == profileImageURL else { return }
      self.profilePictureImageView?.image = UIImage(data: imageData)
    }
  }
}
