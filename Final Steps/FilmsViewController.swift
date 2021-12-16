//
//  FilmsViewController.swift
//  Final Steps
//
//  Created by admin on 15/12/2021.
//

import UIKit

struct FilmsInfo{
    var title : String
    var releaseDate : String
    var director : String
    var openingCrawl : String
}

class FilmsViewController: UITableViewController {
    // Hardcoded data for now
          var films = [FilmsInfo]()
         
       override func viewDidLoad() {
               super.viewDidLoad()
           //test
//           films.append(FilmsInfo(title: "String", releaseDate: "String", director: "", openingCrawl: "String"))
           StarWarsModel.getAllFilms(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
                               data, response, error in
                                   do {
                                       // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                                       if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                           if let results = jsonResult["results"] as? NSArray {
                                               for film in results {
                                                   let filmDict = film as! NSDictionary
                                                   let title = filmDict["title"]! as! String
                                                   let releaseDate = filmDict["releaseDate"]! as! String
                                                   let director = filmDict["director"]! as! String
                                                   let openingCrawl = filmDict["openingCrawl"]! as! String
                                                   let obj = FilmsInfo(title: title, releaseDate: releaseDate, director: director, openingCrawl: openingCrawl)
                                                   self.films.append(obj)
                                               }
                                           }
                                       }
                                       DispatchQueue.main.async {
                                           self.tableView.reloadData()
                                       }
                                   } catch {
                                       print("Something went wrong")
                                   }
                           })
                }


                   override func didReceiveMemoryWarning() {
                       super.didReceiveMemoryWarning()
                   }
                   override func numberOfSections(in tableView: UITableView) -> Int {
                       // if we return - sections we won't have any sections to put our rows in
                       return 1
                   }
                   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                       // return the count of people in our data array
                       return films.count
                   }
                   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                       // Create a generic cell
                       let cell = UITableViewCell()
                       // set the default cell label to the corresponding element in the people array
                       cell.textLabel?.text = films[indexPath.row].title
                       // return the cell so that it can be rendered
                       return cell
                   }
             override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                 performSegue(withIdentifier: "filmsSegue", sender: indexPath)
             }
             
             override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                     let des = segue.destination as! DetailsViewController
                     let indexPath = sender as! NSIndexPath
            let title = films[indexPath.row].title
            let releasedate = films[indexPath.row].releaseDate
            let director = films[indexPath.row].director
            let openingcrawl = films[indexPath.row].openingCrawl
                 des.label1t = title
                 des.label2t = releasedate
                 des.label3t = director
                 des.label4t = openingcrawl
        }
    }




/*
 //                 let cell = UITableViewCell()
 //                 // set the default cell label to the corresponding element in the people array
 //                 cell.detailTextLabel?.text = "release date:\(films[indexPath.row].releaseDate), director:\(films[indexPath.row].director), opening crawl:\(films[indexPath.row].openingCrawl)"
 */
