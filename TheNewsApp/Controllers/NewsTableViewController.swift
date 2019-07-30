//
//  NewsTableViewController.swift
//  TheNewsApp
//
//  Created by Lyub Chibukhchian on 7/24/19.
//  Copyright © 2019 Lyub Chibukhchian. All rights reserved.
//

import UIKit


class NewsTableViewController: UITableViewController {
    
    var news_info2: News = News(results: [Results(url: "", title: "", published_date: "", media: [MediaObject(mediaMetadata: [MediaMetadataDetails(url: "")])])])
    

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNews()
        
        
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
        return news_info2.results.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        cell.newsTitleLabel.text = news_info2.results[indexPath.row].title
        cell.datePublishedLabel.text = news_info2.results[indexPath.row].published_date
        let pic_url = URL(string: news_info2.results[indexPath.row].media[0].mediaMetadata[0].url)
        if pic_url != nil {
        do {
            let data = try Data(contentsOf: pic_url!)
            cell.newsImageView.image = UIImage(data: data)
        } catch let error {
            print(error)
        }
        }
        
        
        return cell
        
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        page_url = news_info2.results[indexPath.row].url
        performSegue(withIdentifier: "goToThePage", sender: self)

    }
    func getNews() {
        
        guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=GvdcbzKgMCanwvG55wH6Ko3A28JaG2hZ") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                self.news_info2 = try JSONDecoder().decode(News.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {print("didn't work")}
            }.resume()
        
    }

 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}


