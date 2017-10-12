//
//  ViewController.swift
//  MyNote
//
//  Created by Swift Mage on 04/09/2017.
//  Copyright © 2017 Swift Mage. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var backgroundView: UIImageView!
  
  var data: [String] = []
  var file:String!
  var selectedRow: Int = -1
  var newRowText:String = ""
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if selectedRow == -1 {
      return
    }
    data[selectedRow] = newRowText
    if newRowText == "" {
      data.remove(at: selectedRow)
    }
    tableView.reloadData()
    save()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    backgroundView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background.jpg"))
    tableView.delegate = self
    self.title = "Notes"
    let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
    self.navigationItem.rightBarButtonItem = addButton
    self.navigationItem.leftBarButtonItem = editButtonItem
    // creating a file in document directory to save data
    let docsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
    file = docsDir[0].appending("notes.txt")
    load()
  }
  
  @objc func addNote() {
    let name:String = "Data \(data.count + 1)"
    data.insert(name, at: 0)
    let indexPath:IndexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    performSegue(withIdentifier: "detail", sender: nil)
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    navigationItem.rightBarButtonItem?.isEnabled = editing ? false : true
    tableView.setEditing(editing, animated: animated)
  }
  
  func save() {
//    UserDefaults.standard.set(data, forKey: "notes")
//    UserDefaults.standard.synchronize()
    let newData:NSArray = NSArray(array: data)
    newData.write(toFile: file, atomically: true)
  }
  
  func load() {
//    if let loadedData = UserDefaults.standard.value(forKey: "notes") as? [String] {
//      data = loadedData
//      tableView.reloadData()
//    }
    
    if let loadedData = NSArray(contentsOfFile: file) as? [String] {
      data = loadedData
      tableView.reloadData()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detail" {
      let detailViewController = segue.destination as! DetailViewController
      selectedRow = tableView.indexPathForSelectedRow!.row
      detailViewController.masterViewController = self
      detailViewController.setText(text: data[selectedRow])
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


// MARK: - Data Source Methods
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
    cell.textLabel?.text = data[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    data.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
    save()
  }
  
}

// MARK: - Delegate Methods

extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "detail", sender: nil)
    
  }
}

