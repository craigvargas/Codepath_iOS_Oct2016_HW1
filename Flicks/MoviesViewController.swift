//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Craig Vargas on 10/14/16.
//  Copyright © 2016 Cvar. All rights reserved.
//

import UIKit
import Foundation
import AFNetworking
import MBProgressHUD



class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    

    //UI bindings
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var networkErrorView: UIView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var listGridSegCtrl: UISegmentedControl!
    
    //Instance Variables
    var movies: [NSDictionary]?
    var moviePosterUrl: URL = URL(string: "www.google.com")!
    var selectedIndexPath: IndexPath = IndexPath()
    let basePosterUrl = "https://image.tmdb.org/t/p/w500"
    var posterPath: String = ""
    var apiEndPoint: String = "now_playing"
    
    let listIndex: Int = 0
    let gridIndex: Int = 1
    
    let refreshControl = UIRefreshControl()
    let refreshControlTable = UIRefreshControl()
    
    //*
    //MARK - Lifecycle overrides
    //*
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionViewFlowLayout.scrollDirection = .vertical
        moviesCollectionViewFlowLayout.minimumLineSpacing = 6
        moviesCollectionViewFlowLayout.minimumInteritemSpacing = 3
        moviesCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(6, 6, 6, 6)
        
//        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(MoviesViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        refreshControlTable.addTarget(self, action: #selector(MoviesViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        self.moviesTableView.insertSubview(refreshControlTable, at: 0)
        self.moviesCollectionView.insertSubview(refreshControl, at: 0)
        
        refreshMovieData()
        displayListOrGrid()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //*
    //MARK - Tableview protocol
    //*
    
    //Called when user selects a row in the table
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //For some reason this seems to be passing in the indexPath of the previous selection
        moviesTableView.deselectRow(at: indexPath, animated: true)
        print("Selected row \(indexPath.row) // IndexPath: \(indexPath)")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies{
            return movies.count
        }else{
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies![(indexPath as NSIndexPath).row]
//        let title = movie["title"] as! String
        if let title = movie["title"] as? String{
            cell.titleLabel.text = title
        }

//        let overview = movie["overview"] as! String
        if let overview = movie["overview"] as? String{
            cell.overviewLabel.text = overview
        }
        
//        let posterPath = movie["poster_path"] as! String
        if let posterPath = movie["poster_path"] as? String{
            if let posterUrl = URL(string: self.basePosterUrl + posterPath){
                cell.posterImageView.setImageWith(posterUrl)
            }
        }
        
//        let posterUrl = URL(string: self.basePosterUrl + posterPath)
        
//        cell.titleLabel.text = title
//        cell.overviewLabel.text = overview
//        cell.posterImageView.setImageWith(posterUrl!)
        
        return cell
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        refreshMovieData()
    }
    

    @IBAction func onListGridToggle(_ sender: UISegmentedControl) {
        displayListOrGrid()
    }
    
    func displayListOrGrid(){
        let hideGrid: Bool = listGridSegCtrl.selectedSegmentIndex == self.listIndex
        self.moviesTableView.isHidden = !hideGrid
        self.moviesCollectionView.isHidden = hideGrid
        
//        if listGridSegCtrl.selectedSegmentIndex == self.listIndex{
//            self.moviesTableView.isHidden = false
//            self.moviesCollectionView.isHidden = true
//        }else{
//            self.moviesTableView.isHidden = true
//            self.moviesCollectionView.isHidden = false
//        }
    }
    
    
    //*
    // MARK: - Collection view protocol
    //*
    
    // MARK: - UICollectionViewDataSource
//    extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        //1
//        func numberOfSections(in collectionView: UICollectionView) -> Int {
//            if let movies = movies{
//                return movies.count
//            }else{
//                return 0
//            }
//        }
    
        //2
        func collectionView(_ collectionView: UICollectionView,
                                     numberOfItemsInSection section: Int) -> Int {
            if let movies = movies{
                print("In \(apiEndPoint) collection movies not nil: \(movies.count)")
                return movies.count
            }else{
                print("In \(apiEndPoint) collection movies nil")
                return 0
            }
        }
        
        //3
        func collectionView(_ collectionView: UICollectionView,
                                     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieThumb",
                                                          for: indexPath) as! MovieCollectionViewCell
            
            let movie = movies![(indexPath as NSIndexPath).row]
            if let posterPath = movie["poster_path"] as? String{
                if let posterUrl = URL(string: self.basePosterUrl + posterPath){
                    cell.moviePosterImageView.setImageWith(posterUrl)
                }
            }
            
            return cell
        }
//    }
    
    //******************
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if let tableViewCell = sender as? UITableViewCell {
            self.selectedIndexPath = moviesTableView.indexPath(for: tableViewCell)!
            moviesTableView.deselectRow(at: self.selectedIndexPath, animated: true)
            print("indexpath.row inside of prepare: \(self.selectedIndexPath.row)")
        }else if let collectionViewCell = sender as? UICollectionViewCell{
            self.selectedIndexPath = moviesCollectionView.indexPath(for: collectionViewCell)!
            moviesCollectionView.deselectItem(at: self.selectedIndexPath, animated: true)
            print("indexpath.row inside of prepare: \(self.selectedIndexPath.row)")
        }
        
            let destinationViewController = segue.destination as! MovieDetailViewController
            
//            self.selectedIndexPath = moviesTableView.indexPath(for: sender as! UITableViewCell)!
            self.posterPath = movies![(self.selectedIndexPath as NSIndexPath).row]["poster_path"] as! String
            self.moviePosterUrl = URL(string: self.basePosterUrl + self.posterPath)!
        
            destinationViewController.moviePosterUrl = self.moviePosterUrl
        
//            let cell = sender as! UITableViewCell
//            let indexPath = moviesTableView.indexPath(for: cell)!
            let movie = movies![self.selectedIndexPath.row]
            let dvc2 = segue.destination as! MovieDetailViewController
            dvc2.movie = movie
            dvc2.basePosterUrlString = self.basePosterUrl
        
//            moviesTableView.deselectRow(at: indexPath, animated: true)
//
//            print("indexpath.row inside of prepare: \(indexPath.row)")
    }
    
    //*
    //MARK: - Helper functions
    //*
    
    func refreshMovieData(){
        self.networkErrorView.isHidden = true
        print("refresh started")
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(apiEndPoint)?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        //Force the data to clear
//        self.movies = [[:]]
//        self.moviesTableView.reloadData()
        
        //Display progress icon
        self.refreshControl.beginRefreshing()
        MBProgressHUD.showAdded(to: self.view, animated: true)
//        MBProgressHUD.showAdded(to: self.moviesTableView, animated: true)
//        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task : URLSessionDataTask = session.dataTask(with: request, completionHandler:{(dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary =
                    try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
//                        print("response: \(responseDictionary)")
                        //***May need to change to as!
                        self.movies = responseDictionary["results"] as? [NSDictionary]
                        self.moviesTableView.reloadData()
                        self.moviesCollectionView.reloadData()
                        self.refreshControl.endRefreshing()
                        self.refreshControlTable.endRefreshing()
                        print("refresh finished")
                        MBProgressHUD.hide(for: self.view, animated: true)
                }
            }else{
                self.networkErrorView.isHidden = false
                self.refreshControl.endRefreshing()
                self.refreshControlTable.endRefreshing()
                print("refresh finished")
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        });
        task.resume()
    }

}
