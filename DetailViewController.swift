//
//  DetailViewController.swift
//  MyNote
//
//  Created by Swift Mage on 04/09/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var textView: UITextView!
  var text:String = ""
  var masterViewController:ViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textView.text = text
    textView.becomeFirstResponder()
  }
  
  func setText(text: String) {
    
    self.text = text
    if isViewLoaded {
      textView.text = text
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    masterViewController.newRowText = textView.text
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
