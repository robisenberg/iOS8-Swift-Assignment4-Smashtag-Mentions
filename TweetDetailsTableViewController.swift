//
//  TweetDetailsTableViewController.swift
//  Smashtag
//
//  Created by Rob Isenberg on 11/11/2015.
//  Copyright © 2015 Rob Isenberg. All rights reserved.
//

import UIKit

class TweetDetailsTableViewController: UITableViewController {
  
  var tweet: Tweet?
  
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
    return 3
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var result = 0
    switch(section) {
    case 0:
      result = tweet?.userMentions.count ?? 0
    case 1:
      result = tweet?.hashtags.count ?? 0
    case 2:
      result = tweet?.urls.count ?? 0
    default:
      break
    }

    return result
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch(section) {
    case 0:
      return "User Mentions"
    case 1:
      return "Hashtags"
    case 2:
      return "URLs"
    default:
      return nil
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetItem", forIndexPath: indexPath)

    switch(indexPath.section) {
    case 0:
        if let items = tweet?.userMentions {
          cell.textLabel?.text = items[indexPath.row].keyword
        }
      case 1:
        if let items = tweet?.hashtags {
          cell.textLabel?.text = items[indexPath.row].keyword
        }
      case 2:
        if let items = tweet?.urls {
          cell.textLabel?.text = items[indexPath.row].keyword
        }
      default:
        break
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
