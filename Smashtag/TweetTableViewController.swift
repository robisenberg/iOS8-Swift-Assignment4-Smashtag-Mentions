//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Rob Isenberg on 09/11/2015.
//  Copyright © 2015 Rob Isenberg. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController {
  
  var tweets = [[Tweet]]()
  var searchText: String? = "stanford" {
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
  
  // MARK: - Private
  
  private func reset() {
    tweets.removeAll()
    tableView.reloadData()
  }
  
  private func refresh() {
    if searchText != nil {
      let request = TwitterRequest(search: "#\(searchText!)", count: 100)
      request.fetchTweets { (tweets) -> Void in
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          if tweets.count > 0 {
            self.tweets.insert(tweets, atIndex: 0)
            self.tableView?.reloadData()
          }
        })
      }
    }

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
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
  // MARK: - UITableViewDataSource
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return tweets.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets[section].count
  }
  
  private struct StoryBoard {
    static let ReuseIdentifier = "Tweet"
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
