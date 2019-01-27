//
//  ViewController.swift
//  FunToDo
//
//  Created by Waleed Khan on 1/25/19.
//  Copyright © 2019 Waleed Khan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var items = ["Today", "Grocery List", "Reminders"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Mark - TableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    //MARK - Add New Items
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var text = UITextField()
        let alert = UIAlertController(title: "Add New Item To Do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            print(text.text!)
            self.items.append(text.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Task To Do"
            text = UITextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

