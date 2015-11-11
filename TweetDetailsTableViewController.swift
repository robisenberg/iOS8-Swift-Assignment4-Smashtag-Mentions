//
//  TweetDetailsTableViewController.swift
//  Smashtag
//
//  Created by Rob Isenberg on 11/11/2015.
//  Copyright © 2015 Rob Isenberg. All rights reserved.
//

import UIKit

class TweetDetailsTableViewController: UITableViewController {

  // MARK: - Public Model
  
  var tweet: Tweet? {
    didSet {
      if let tweet = self.tweet {
        if let itemList = TweetItemList(name: "Hashtags", type: TweetItem.Hashtag, items: tweet.hashtags) {
          tweetItemLists.append(itemList)
        }
        
        if let itemList = TweetItemList(name: "URLs", type: TweetItem.URL, items: tweet.urls) {
          tweetItemLists.append(itemList)
        }
        
        if let itemList = TweetItemList(name: "Mentions", type: TweetItem.Mention, items: tweet.userMentions) {
          tweetItemLists.append(itemList)
        }
        
        if let itemList = TweetItemList(name: "Images", type: TweetItem.Image, items: tweet.media) {
          tweetItemLists.append(itemList)
        }
      }
    }
  }
  
  // MARK: - Private Model
  
  private var tweetItemLists =  [TweetItemList]()
  
  private enum TweetItem {
    case Mention(String)
    case Hashtag(String)
    case URL(String)
    case Image(NSURL?)
  }
  
  private struct TweetItemList {
    var tweetItems = [TweetItem]()
    var name: String
    var count: Int { return tweetItems.count }
    
    init?(name: String, type: String -> TweetItem, items: [Tweet.IndexedKeyword]) {
      if items.count <= 0 { return nil }
      self.name = name
      for item in items { add(type(item.keyword)) }
    }
    
    init?(name: String, type: NSURL -> TweetItem, items: [MediaItem]) {
      if items.count <= 0 { return nil }
      self.name = name
      for item in items { add(type(item.url!)) }
    }
    
    mutating func add(tweetItem: TweetItem) {
      tweetItems.append(tweetItem)
    }
    
    subscript(i: Int) -> TweetItem {
      return tweetItems[i]
    }
  }
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - UITableViewDataSource
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return tweetItemLists.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweetItemLists[section].count
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return tweetItemLists[section].name
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetItem", forIndexPath: indexPath)

    let tweetItem = tweetItemLists[indexPath.section][indexPath.row]
    switch(tweetItem) {
      case .Mention(let value):
        cell.textLabel?.text = value
      case .URL(let value):
        cell.textLabel?.text = value
      case .Hashtag(let value):
        cell.textLabel?.text = value
      case .Image(let url):
        if let url = url {
          cell.imageView?.image = UIImage(data: NSData(contentsOfURL: url)!)
          cell.textLabel?.text = ""
        }
    }

    return cell
  }
  
  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return false if you do not want the specified item to be editable.
  return true
  }
  */
  
  /*
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  if editingStyle == .Delete {
  // Delete the row from the data source
  tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
  } else if editingStyle == .Insert {
  // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
  }
  */
  
  /*
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
  
  }
  */
  
  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return false if you do not want the item to be re-orderable.
  return true
  }
  */
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
