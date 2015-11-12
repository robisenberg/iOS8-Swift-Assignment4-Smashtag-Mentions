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
        add(TweetItemList(name: Defaults.SectionName.Images, items: tweet.media))
        add(TweetItemList(name: Defaults.SectionName.Hashtags, items: tweet.hashtags))
        add(TweetItemList(name: Defaults.SectionName.URLs, items: tweet.urls, type: TweetItem.URL))
        add(TweetItemList(name: Defaults.SectionName.Mentions, items: tweet.userMentions))
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
    case URL(String)
    case Image(url: NSURL?, aspectRatio: Double)
  }
  
  private struct TweetItemList {
    var tweetItems = [TweetItem]()
    var name: String
    var count: Int { return tweetItems.count }
    
    init?(name: String, items: [Tweet.IndexedKeyword], type tweetItemConstructor: String -> TweetItem = TweetItem.Text) {
      guard items.count > 0 else { return nil }
      self.name = name
      for item in items { add(tweetItemConstructor(item.keyword)) }
    }
    
    init?(name: String, items: [MediaItem]) {
      guard items.count > 0 else { return nil }
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
  
  // MARK: - Constants
  
  private struct Defaults {
    struct SectionName {
      static let Images = "Images"
      static let Hashtags = "Hashtags"
      static let URLs = "URLs"
      static let Mentions = "Mentions"
    }
  }
  
  private struct StoryBoard {
    struct CellReuseIdentifier {
      static let Text = "TweetTextItem"
      static let URL = "TweetURLItem"
      static let Image = "TweetImageItem"
    }
    struct Segue {
      static let TweetSearch = "TweetSearch"
      static let ImageView = "ImageView"
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
    case .Text, .URL:
      return UITableViewAutomaticDimension
    case .Image(_, let aspectRatio):
       return (tableView.frame.size.width) / CGFloat(aspectRatio)
    }
  }
    
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let tweetItem = tweetItemLists[indexPath.section][indexPath.row]

    switch(tweetItem) {
      case .Text(let value):
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellReuseIdentifier.Text, forIndexPath: indexPath)
        cell.textLabel?.text = value
        return cell
      case .URL(let value):
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellReuseIdentifier.URL, forIndexPath: indexPath)
        cell.textLabel?.text = value
        return cell
      case .Image(let url, _):
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellReuseIdentifier.Image, forIndexPath: indexPath) as! ImageTableViewCell
        cell.imageURL = url
        return cell
    }
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let tweetItem = tweetItemLists[indexPath.section][indexPath.row]
    
    switch(tweetItem) {
      case .URL(let urlString):
        guard let url = NSURL(string: urlString) else { return }
        UIApplication.sharedApplication().openURL(url)
      default:
        return
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
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let identifier = segue.identifier else { return }
    
    switch identifier {
    case StoryBoard.Segue.TweetSearch:
      guard let destination = segue.destinationViewController as? TweetSearchViewController else { return }
      guard let tableViewCell = sender as? UITableViewCell else { return }

      destination.searchText = tableViewCell.textLabel?.text
    case StoryBoard.Segue.ImageView:
      guard let destination = segue.destinationViewController as? ImageViewController else { return }
      guard let tableViewCell = sender as? ImageTableViewCell else { return }
      
      destination.image = tableViewCell.mainImageView?.image
    default:
      return
    }
  }
  
}
