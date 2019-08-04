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

class FavouritesTableViewController: UITableViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFata()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favourites.count
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
        cell.newsTitleLabel.text = favourites[indexPath.row].name
        cell.datePublishedLabel.text = favourites[indexPath.row].date
        cell.newsImageView.image = UIImage(data: favourites[indexPath.row].picture!)
       

        return cell
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
