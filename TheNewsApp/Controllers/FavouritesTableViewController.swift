//
//  FavouritesTableViewController.swift
//  TheNewsApp
//
//  Created by Lyub Chibukhchian on 8/2/19.
//  Copyright © 2019 Lyub Chibukhchian. All rights reserved.
//

import UIKit
import CoreData

var favourites: [Article] = []


class FavouritesTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var filteredTableData = [Article]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFata()
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.hidesNavigationBarDuringPresentation = false
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        tableView.reloadData()
        
    }
    
    // MARK: - Table view data source and Search Results Updating
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return favourites.count
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        let array = favourites.filter {
            
            return $0.name?.lowercased().range(of: searchText.lowercased()) != nil ||
                $0.date?.range(of: searchText) != nil
        }
        filteredTableData = array
        self.tableView.reloadData()
    }
    
    
    func fetchFata() {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        do {
            favourites = try managedContext.fetch(request) as! [Article]
        } catch {
            print("unable to fetch data \(error.localizedDescription)")
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouritesCell", for: indexPath) as! NewsTableViewCell
        if (resultSearchController.isActive) {
            cell.newsTitleLabel.text = filteredTableData[indexPath.row].name
            cell.datePublishedLabel.text = filteredTableData[indexPath.row].date
            cell.newsImageView.image = UIImage(data: filteredTableData[indexPath.row].picture!)
            return cell
            
        }
        else {
            cell.newsTitleLabel.text = favourites[indexPath.row].name
            cell.datePublishedLabel.text = favourites[indexPath.row].date
            cell.newsImageView.image = UIImage(data: favourites[indexPath.row].picture!)
            return cell
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        page_url = favourites[indexPath.row].url!
        performSegue(withIdentifier: "goToThePage", sender: self)
        
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
            guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
            managedContext.delete(favourites[indexPath.row])
            do {
                try managedContext.save()
                print("it worked")
            } catch {
                print("failed to save data: \(error.localizedDescription)")
            }
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
            do {
                favourites = try managedContext.fetch(request) as! [Article]
            } catch {
                print("unable to fetch data \(error.localizedDescription)")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
}

