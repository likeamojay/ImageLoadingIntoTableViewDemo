//
//  UserTableViewController.swift
//  ImageLoadingIntoTableViewDemo
//  Main Table View Controller for showing cells containg info about StackOverflow users + a header about me
//  Created by James Lane on 11/13/21.

import UIKit
import PKHUD

class UserTableViewController: UITableViewController {
    
    // MARK: Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.showProgress()
        
        // Load the JSON Data if needed
        UsersService.shared.downloadUsers { success in
            
            print("Data Loaded " + (success ? "successfully" : "unsuccessfully"))
            
            // Hide the progress HUD regardless if it was successful or not
            self.hideProgess()
            
            // If successful then tell the table to reload
            if success {
                self.tableView.reloadData()
            }
            else
            {
                // Otherwise show an error HUD
                 self.flashDownloadError(seconds: 8.0)
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableCellId) as! UserTableViewCell
        
        if let users = UsersService.shared.users{
            cell.SetupCellFor(user: users[indexPath.row])
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let users = UsersService.shared.users {
            return users.count
        }
        else {
            return 0
        }
    }
}

