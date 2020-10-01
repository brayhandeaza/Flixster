//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Brayhan De Aza on 10/1/20.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    var movie : [String:Any]!
    
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let  backdroBaseUrl = "https://image.tmdb.org/t/p/w780"
        
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        let backdroPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: backdroBaseUrl + backdroPath)
        
        backdrop.af_setImage(withURL: backdropUrl!)
        posterView.af_setImage(withURL: posterUrl!)
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsiLabel.text = movie["overview"] as? String
        synopsiLabel.sizeToFit()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
