//
//  UsersTableViewController.swift
//  RandomUser
//
//  Created by San on 16.04.18.
//  Copyright © 2018 San. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    var usersList : [UserModel] = []
    var usersOriginList : [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager().getUser { [weak self] (users) in
            self?.usersOriginList = users
            self?.usersList = users
            self?.createNationalitySet()
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterOptions()
    }
    
    func createNationalitySet() {
        let natSet: NSMutableSet = []
        usersOriginList.forEach { user in
            natSet.add(user.nat ?? "")
        }
        FilterManager.sharedManager.nationals = natSet
    }
    
    func filterOptions() {
        if FilterManager.sharedManager.isFiltered == true {
            sortedGender()
            filterCoutry()
            self.tableView.reloadData()
        }
    }
    
    func sortedGender() {
        if FilterManager.sharedManager.gender == true {
            usersList = usersOriginList.sorted(by: { $0.gender! > $1.gender! })
        }else {
            usersList = usersOriginList
        }
    }
    
    func filterCoutry() {
        if let country = FilterManager.sharedManager.nationality {
            usersList = usersList.filter( {$0.nat == country})
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = usersList[indexPath.row] as UserModel
        cell.textLabel?.text = user.name.first + " " + user.name.last
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? UserInfoController {
            if let indexPath = tableView.indexPathForSelectedRow {
                controller.user = usersList[indexPath.row] as UserModel
            }
        }
    }
    
}
