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
    
    @IBOutlet var dataProvider: UITableViewDataSource!
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
    }
}
