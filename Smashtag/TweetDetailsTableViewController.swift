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
        add(TweetItemList(name: "Images", items: tweet.media))
        add(TweetItemList(name: "Hashtags", items: tweet.hashtags))
        add(TweetItemList(name: "URLs", items: tweet.urls))
        add(TweetItemList(name: "Mentions", items: tweet.userMentions))
      }
    }
  }
  
  // MARK: - Private Model
  
  private var tweetItemLists =  [TweetItemList]()
  
  // convenient helper method for adding TweetItemList only if is not nil
  private func add(tweetItemList: TweetItemList?) {
    if let itemList = tweetItemList { tweetItemLists.append(itemList) }
  }
  
  private enum TweetItem {
    case Text(String)
    case Image(url: NSURL?, aspectRatio: Double)
  }
  
  private struct TweetItemList {
    var tweetItems = [TweetItem]()
    var name: String
    var count: Int { return tweetItems.count }
    
    init?(name: String, items: [Tweet.IndexedKeyword]) {
      if items.count <= 0 { return nil }
      self.name = name
      for item in items { add(TweetItem.Text(item.keyword)) }
    }
    
    init?(name: String, items: [MediaItem]) {
      if items.count <= 0 { return nil }
      self.name = name
      for item in items { add(TweetItem.Image(url: item.url, aspectRatio: item.aspectRatio)) }
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
    
    // auto-sizing of row height
//    tableView.estimatedRowHeight = tableView.rowHeight
//    tableView.rowHeight = UITableViewAutomaticDimension
    
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
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let tweetItem = tweetItemLists[indexPath.section][indexPath.row]
    
    switch(tweetItem) {
    case .Text:
      return UITableViewAutomaticDimension
    case .Image(_, let aspectRatio):
       return (tableView.frame.size.width) / CGFloat(aspectRatio)
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let tweetItem = tweetItemLists[indexPath.section][indexPath.row]

    switch(tweetItem) {
      case .Text(let value):
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetItem", forIndexPath: indexPath)
        cell.textLabel?.text = value
        return cell
      case .Image(let url, _):
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetImageItem", forIndexPath: indexPath) as! ImageTableViewCell
        cell.imageURL = url
        return cell
    }
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
