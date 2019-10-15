//
//  EntryListTableViewController.swift
//  CloudKitJournal
//
//  Created by Travis Wheeler on 10/14/19.
//  Copyright © 2019 Travis Wheeler. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        let entry = EntryController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToDetailVC" {
            let destinationVC = segue.destination as? EntryDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let entry = EntryController.shared.entries[indexPath.row]
            destinationVC?.entry = entry
        }
    }
}
