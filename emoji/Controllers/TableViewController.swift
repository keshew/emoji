//
//  TableViewController.swift
//  emoji
//
//  Created by Артём Коротков on 28.09.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var objects = [
        Emoji(emoji: "👄", name: "Lips", description: "Kiss me", isFavourite: true),
        Emoji(emoji: "🖕🏼", name: "Fuck", description: "Fuck you", isFavourite: false),
        Emoji(emoji: "🦵🏼", name: "Legs", description: "Go there", isFavourite: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Emoji"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - MainCode
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else {return}
        let sourceVC = segue.source as! SecondTableViewController
        let emoji = sourceVC.emoji
        
        if let selectedIP = tableView.indexPathForSelectedRow {
            objects[selectedIP.row] = emoji
            tableView.reloadRows(at: [selectedIP], with: .fade)
        } else {
            let newIP = IndexPath(row: objects.count, section: 0)
            objects.append(emoji)
            tableView.insertRows(at: [newIP], with: .fade)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "redact" else {return}
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let secondTV = navigationVC.topViewController as! SecondTableViewController
        secondTV.emoji = emoji
        secondTV.title = "Edit"
    }
    
    
    
    // MARK: - Table view data source
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let object = objects[indexPath.row]
        cell.set(with: object)
        
        return cell
    }
    
    // MARK: - Editing
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedRow = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedRow, at: destinationIndexPath.row)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = doneAction(at: indexPath)
        let favAction = favAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [doneAction, favAction])
    }

    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "delete") { action, view, completion in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        action.backgroundColor = .systemRed
        action.image = UIImage(systemName: "delete.left")
        return action
    }
    
    func favAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "fav") { action, view, completion in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.image = UIImage(systemName: "heart.square")
        action.backgroundColor = object.isFavourite ? .systemBlue : .systemGray
        return action
    }

}
