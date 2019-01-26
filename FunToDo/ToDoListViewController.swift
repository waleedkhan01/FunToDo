//
//  ViewController.swift
//  FunToDo
//
//  Created by Waleed Khan on 1/25/19.
//  Copyright © 2019 Waleed Khan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let item = ["Today", "Grocery List", "Reminders"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Mark - TableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = item[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(item[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }

}

