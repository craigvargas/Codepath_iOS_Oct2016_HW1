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
    @IBOutlet weak var MovieImageView: UIImageView!
    
    //Instance Variables
    var moviePosterUrl: URL = URL(string: "www.google.com")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieImageView.setImageWith(self.moviePosterUrl)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
