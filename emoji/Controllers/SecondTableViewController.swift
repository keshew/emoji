//
//  SecondTableViewController.swift
//  emoji
//
//  Created by Артём Коротков on 28.09.2022.
//

import UIKit

class SecondTableViewController: UITableViewController {

    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)
    
    
    @IBOutlet weak var descTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emojiTF: UITextField!
    @IBOutlet weak var save: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton()
        updateUI()
    }
    
    private func updateUI() {
        emojiTF.text = emoji.emoji
        nameTF.text = emoji.name
        descTF.text = emoji.description
    }
    
    private func saveButton() {
        let emojiText = emojiTF.text ?? ""
        let nameText = nameTF.text ?? ""
        let descText = descTF.text ?? ""
        
        save.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descText.isEmpty
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return}
        let emoji = emojiTF.text ?? ""
        let name = nameTF.text ?? ""
        let desc = descTF.text ?? ""
        
        self.emoji = Emoji(emoji: emoji, name: name, description: desc, isFavourite: self.emoji.isFavourite)
    }
    
    
    @IBAction func endEditing(_ sender: UITextField) {
        saveButton()
    }
    
    
}
