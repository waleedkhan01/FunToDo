//
//  ViewController.swift
//  FunToDo
//
//  Created by Waleed Khan on 1/25/19.
//  Copyright © 2019 Waleed Khan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    //var items = ["Today", "Grocery List", "Reminders"]
    var items = [Item]()
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
        
        loadItems()
        if(items == nil){
            initializeItems()
        }
//        if let storedItems = defaults.array(forKey: "ToDoListArray") as? [Item]{
//            items = storedItems
//        }
        
    }
    
    //Mark - TableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = items[indexPath.row].title
        
        let currItem = items[indexPath.row]
        
        cell.accessoryType = currItem.complete == true ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
        let currItem = items[indexPath.row]
        currItem.complete = !currItem.complete
        
        tableView.cellForRow(at: indexPath)?.accessoryType = currItem.complete ? .checkmark : .none
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var text = UITextField()
        let alert = UIAlertController(title: "Add New Item To Do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            
            var newItem = Item()
            newItem.title = text.text!
            
            self.items.append(newItem)
            
            self.saveItems()
            
            
            print(newItem.title)
            print(self.items)
//            self.defaults.set(self.items, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Task To Do"
            text = UITextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            
            let data = try encoder.encode(self.items)
            try data.write(to: self.dataFilePath!)
            
        }
        catch{
            print("Error encoding item array")
        }
        
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                items = try decoder.decode([Item].self, from: data)
            }
            catch{
                print("Error occured loading items")
            }
        }
        
        
    }
    func initializeItems(){
        var tmpItem = Item()
        tmpItem.title = "Today"

        var tmpItem2 = Item()
        tmpItem2.title = "Grocery List"
        var tmpItem3 = Item()
        tmpItem3.title = "Reminders"

        items.append(tmpItem)
        items.append(tmpItem2)
        items.append(tmpItem3)
    }
    
}

