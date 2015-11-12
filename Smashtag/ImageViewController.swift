//
//  ImageViewController.swift
//  Smashtag
//
//  Created by Rob Isenberg on 12/11/2015.
//  Copyright © 2015 Rob Isenberg. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
  
  // MARK: - Public Model
  
  var image: UIImage? {
    didSet {
      imageView.image = image
      imageView.sizeToFit()
      updateUI()
    }
  }
  
  // MARK: - Outlets
  
  @IBOutlet weak var scrollView: UIScrollView! {
    didSet {
      scrollView.delegate = self
      scrollView.maximumZoomScale = 2
    }
  }
  
  // MARK: - Private
  
  private var imageView = UIImageView()
  
  private var zoomScaleForImageToFillScrollView: CGFloat {
    return image == nil ? 1.0 : view.frame.width / image!.size.width
  }
  
  private func updateUI() {
    scrollView?.minimumZoomScale = zoomScaleForImageToFillScrollView
    scrollView?.zoomScale = zoomScaleForImageToFillScrollView
    scrollView?.contentSize = imageView.frame.size
  }
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.addSubview(imageView)
    updateUI()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}

extension ImageViewController: UIScrollViewDelegate {
  
  func viewForZoomingInScrollView(sender: UIScrollView) -> UIView? {
    return imageView
  }

}