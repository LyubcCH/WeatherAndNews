

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class NewsTableViewController: UITableViewController {
    
    var news_info: News = News(results: [Results(url: "", title: "", published_date: "", media: [MediaObject(mediaMetadata: [MediaMetadataDetails(url: "")])])])
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
    }
    

   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news_info.results.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.newsTitleLabel.text = news_info.results[indexPath.row].title
        cell.datePublishedLabel.text = news_info.results[indexPath.row].published_date
        /*if news_info.results[indexPath.row].media[0].mediaMetadata[0].url != "" {
              cell.newsImageView.loadImageUsingCache(urlString: news_info.results[indexPath.row].media[0].mediaMetadata[0].url)
        }*/
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        page_url = news_info.results[indexPath.row].url
        performSegue(withIdentifier: "goToThePage", sender: self)
    }

    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let indexPath = getIndexPath(of: sender) {
            guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
            let article = Article(context: managedContext)
            article.name = news_info.results[indexPath.row].title
            article.url = news_info.results[indexPath.row].url
            article.date = news_info.results[indexPath.row].published_date
            let pic_url = URL(string: news_info.results[indexPath.row].media[0].mediaMetadata[0].url)
            if pic_url != nil {
                do {
                    let data = try Data(contentsOf: pic_url!)
                    article.picture = data
                } catch let error {
                    print(error)
                }
            }
            do {
                try managedContext.save()
                print("it worked")
            } catch {
                print("failed to save data: \(error.localizedDescription)")
            }
        } else {
            print("meh")
        }
    }
    
    // MARK: - Helper functions
    func getNews() {
        guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=GvdcbzKgMCanwvG55wH6Ko3A28JaG2hZ") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                self.news_info = try JSONDecoder().decode(News.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {print("didn't work")}
            }.resume()
    }

    private func getIndexPath(of element: Any) -> IndexPath?
    {
        if let view =  element as? UIView
        {
            let pos = view.convert(CGPoint.zero, to: self.tableView)
            return tableView.indexPathForRow(at: pos)
        }
        return nil
    }
 


   

}


