//
//  TweetStringDecorator.swift
//  Smashtag
//
//  Created by Rob Isenberg on 10/11/2015.
//  Copyright © 2015 Rob Isenberg. All rights reserved.
//

import UIKit

struct TweetStringDecorator {
  
  init(tweet: Tweet) {
    self.tweet = tweet
    self._attributedString = NSMutableAttributedString(string: tweet.text)
  }
  
  func attributedString() -> NSAttributedString {
    decorateUserMentions()
    decorateUrls()
    decorateHashTags()
    addImageIcons()

    let immutableCopy = _attributedString as NSAttributedString
    return immutableCopy
  }
  
  // MARK: - Private

  private var tweet: Tweet
  private var _attributedString: NSMutableAttributedString
  
  private struct Defaults {
    struct Colors {
      static let UserMentions = UIColor.redColor()
      static let Urls = UIColor.blueColor()
      static let HashTags = UIColor(red: 1.0, green: 0.84, blue: 0, alpha: 1.0)
    }
  }
  
  private func decorateUserMentions() {
    decorateTweetItems(tweet.userMentions, color: Defaults.Colors.UserMentions)
  }

  private func decorateUrls() {
    decorateTweetItems(tweet.urls, color: Defaults.Colors.Urls)
  }
  
  private func decorateHashTags() {
    decorateTweetItems(tweet.hashtags, color: Defaults.Colors.HashTags)
  }
  
  private func decorateTweetItems(items: [Tweet.IndexedKeyword], color: UIColor) {
    for item in items {
      _attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: item.nsrange)
    }
  }
  
  private func addImageIcons() {
    for _ in tweet.media {
      _attributedString.appendAttributedString(NSAttributedString(string: " 📷"))
    }
  }
  
}