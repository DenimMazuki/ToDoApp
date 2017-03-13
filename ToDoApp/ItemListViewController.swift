//
//  ItemListViewController.swift
//  ToDoApp
//
//  Created by Denim Mazuki on 3/2/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate & ItemManagerSettable)!
    
    let itemManager = ItemManager()
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        
        dataProvider.itemManager = itemManager
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController") as? InputViewController {
            
            nextViewController.itemManager = self.itemManager
            
            present(nextViewController, animated: true, completion: nil)
        }
        
    }
    
}
