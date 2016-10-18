//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by Craig Vargas on 10/14/16.
//  Copyright © 2016 Cvar. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //UI Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieDetailScrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    //Instance Variables
    var basePosterUrlString: String = ""
    var moviePosterUrl: URL = URL(string: "www.google.com")!
    
    var movie: NSDictionary = [:];

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.moviePosterImageView.setImageWith(self.moviePosterUrl)
        print(movie)
        refreshMovieDetailView()
        
        //Define view sizing
        self.titleLabel.sizeToFit()
        self.titleLabel.frame.origin.x = self.infoView.frame.width/2 - self.titleLabel.frame.width/2
//        self.infoView.insertSubview(self.overviewLabel, belowSubview: self.titleLabel)
        self.overviewLabel.sizeToFit()
        self.infoView.sizeToFit()
        movieDetailScrollView.contentSize = CGSize(width: movieDetailScrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function setup the view
    func refreshMovieDetailView(){
        //        let title = movie["title"] as! String
        if let title = movie["title"] as? String{
            self.titleLabel.text = title
        }
        
        //        let overview = movie["overview"] as! String
        if let overview = movie["overview"] as? String{
            self.overviewLabel.text = overview
        }
        
        //        let posterPath = movie["poster_path"] as! String
        if let posterPath = movie["poster_path"] as? String{
            if let posterUrl = URL(string: self.basePosterUrlString + posterPath){
                self.moviePosterImageView.setImageWith(posterUrl)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
