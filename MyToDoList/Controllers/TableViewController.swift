//
//  TableViewController.swift
//  MyToDoList
//
//  Created by doyun on 2021/08/18.
//

import UIKit
import RealmSwift
import SwipeCellKit

class TableViewController: UITableViewController,SwipeTableViewCellDelegate {
    
    var items:Results<Item>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
        tableView.rowHeight = 80
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = items?[indexPath.row].title ?? "title"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            if let deleteItem = self.items?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(deleteItem)
                    }
                } catch {
                    print("Error deleting item,\(error)")
                }
            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destinationVC = segue.destination as! DetailViewController
            if let selectedIndex = tableView.indexPathForSelectedRow {
                destinationVC.selectedItem = items?[selectedIndex.row]
            }
        } else if segue.identifier == "goToRegister" {
            if let destinationVC = segue.destination as? RegisterViewController {
                destinationVC.delegate = self
            }
        }
    }
    @IBAction func registerButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
    func loadItem(){
        items = realm.objects(Item.self)
        tableView.reloadData()
    }
}

//MARK: - Adopt ItemDelegate

extension TableViewController : ItemDelegate{
    func call() {
        items = realm.objects(Item.self)
        tableView.reloadData()
    }
}
