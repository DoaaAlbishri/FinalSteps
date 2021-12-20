//
//  ViewController.swift
//  Final Steps
//
//  Created by admin on 15/12/2021.
//

import UIKit

struct PeopleInfo{
    var name : String
    var gender : String
    var birthYear : String
    var mass : String
}


class PeopleViewController: UITableViewController {

    // Hardcoded data for now
          var people = [PeopleInfo]()
         
       override func viewDidLoad() {
               super.viewDidLoad()
           //test
           //people.append(PeopleInfo(name: "hi", gender: "String", birthYear: "String", mass: "String"))
           StarWarsModel.getAllPeople(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
                      data, response, error in
                          do {
                              // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                              if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                  if let results = jsonResult["results"] as? NSArray {
                                      for person in results {
                                          let personDict = person as! NSDictionary
                                          let name = personDict["name"]! as! String
                                          let gender = personDict["gender"]! as! String
                                          let birthYear = personDict["birth_year"]! as! String
                                          let mass = personDict["mass"]! as! String
                                          let obj = PeopleInfo(name: name, gender: gender, birthYear: birthYear, mass: mass)
                                          self.people.append(obj)
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
              return people.count
          }
          override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              // Create a generic cell
              let cell = UITableViewCell()
              // set the default cell label to the corresponding element in the people array
              cell.textLabel?.text = people[indexPath.row].name
              // return the cell so that it can be rendered
              return cell
          }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "peopleSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let des = segue.destination as! DetailsViewController
            let indexPath = sender as! NSIndexPath
   let name = people[indexPath.row].name
   let gender = people[indexPath.row].gender
   let birth = people[indexPath.row].birthYear
   let mass = people[indexPath.row].mass
        des.label1t = "Name: "+name
        des.label2t = "Gender: "+gender
        des.label3t = "Birth year: "+birth
        des.label4t = "Mass: "+mass
}

}


/*
 //        let cell = UITableViewCell()
 //        // set the default cell label to the corresponding element in the people array
 //        cell.detailTextLabel?.text = "gender:\(people[indexPath.row].gender), birh year:\(people[indexPath.row].birthYear), mass:\(people[indexPath.row].mass)"
 */
