//
//  ViewController.swift
//  Yelp
//
//  Created by Tuze on 4/7/17.
//  Copyright © 2017 Tugce Keser. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource {

    var searchController : UISearchController!
    var restaurants: [Restaurant]!
    
    @IBOutlet weak var resultsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.barTintColor = UIColor(red: 180/255, green: 0/255, blue: 0/255, alpha: 1)
        setActionBarOnTop()
        resultsTable.delegate=self
        resultsTable.dataSource=self
        
        Restaurant.searchWithTerm(term: "Thai", completion: { (restaurantList: [Restaurant]?, error: Error?) -> Void in
            
            self.restaurants = restaurantList
            if let restaurantList = restaurantList {
                for restaurant in restaurantList {
                    print(restaurant.restaurantName!)
                    print(restaurant.restaurantAddress!)
                }
            }
            
           }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setActionBarOnTop(){
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchController.searchBar
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        
        if let searchText = searchController.searchBar.text {
            /*filteredNowPlayingMovies = searchText.isEmpty ? nowPlayingMovies : nowPlayingMovies.filter({ (movie:Movie) -> Bool in
                movie.title?.lowercased().range(of:searchText.lowercased()) != nil
            });
            
            nowPlayingCollection.reloadData()
            nowPlayingTableView.reloadData()*/
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.restaurants == nil {
            return 0
        }
        return restaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableCell", for: indexPath) as! ResultsTableCell
        cell.resturant = restaurants[indexPath.row]
        return cell
    }
 

}

