//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Rob Isenberg on 09/11/2015.
//  Copyright © 2015 Rob Isenberg. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController {
  
  // MARK: - Public API
  
  var searchText: String? = "#stanford" {
    didSet {
      reset()
      searchBar?.text = searchText
      refresh()
    }
  }
  
  // MARK: - Outlets
  
  @IBOutlet weak var searchBar: UISearchBar! {
    didSet {
      searchBar?.delegate = self
      searchBar?.text = searchText
    }
  }
  
  // MARK: - Actions
  
  @IBAction func refresh(sender: UIRefreshControl?) {
    if searchText == nil { sender?.endRefreshing(); return }
    
    if let request = nextRequestToAttempt {
      request.fetchTweets { (tweets) -> Void in
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          if tweets.count > 0 {
            self.tweets.insert(tweets, atIndex: 0)
            self.tableView?.reloadData()
          }
          
          sender?.endRefreshing()
        })
      }
    }
  }
  
  // MARK: - Private
  
  private struct StoryBoard {
    static let ReuseIdentifier = "Tweet"
  }
  
  private var tweets = [[Tweet]]()
  
  private var lastSuccessfulRequest: TwitterRequest?
  
  private var nextRequestToAttempt: TwitterRequest? {
    if lastSuccessfulRequest != nil { return lastSuccessfulRequest?.requestForNewer }
    
    return searchText != nil ? TwitterRequest(search: searchText!, count: 100) : nil
  }
  
  private func reset() {
    lastSuccessfulRequest = nil
    tweets.removeAll()
    tableView.reloadData()
  }
  
  private func refresh() {
    refreshControl?.beginRefreshing()
    refresh(refreshControl)
  }
  
  // MARK: - UIViewController Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // auto-sizing of row height
    tableView.estimatedRowHeight = tableView.rowHeight
    tableView.rowHeight = UITableViewAutomaticDimension
    
    refresh()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
    if segue.identifier == "TweetDetails" {
      if let destination = segue.destinationViewController as? TweetDetailsTableViewController {
        if let tweet = (sender as? TweetTableViewCell)?.tweet {
          destination.tweet = tweet
        }
      }
    }
  }
  
  // MARK: - UITableViewDataSource
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return tweets.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets[section].count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.ReuseIdentifier, forIndexPath: indexPath) as! TweetTableViewCell
    cell.tweet = tweets[indexPath.section][indexPath.row]
    return cell
  }
  
}

// MARK: - UISearchBarDelegate

extension TweetTableViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
    if searchBar == self.searchBar {
      
      searchBar.resignFirstResponder()
      
      if searchBar.text != nil {
        searchText = searchBar.text!
      }
      
    }
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    if searchBar == self.searchBar {
      searchBar.resignFirstResponder()
    }
  }
}
