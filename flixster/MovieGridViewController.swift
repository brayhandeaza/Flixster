//
//  MovieGridViewController.swift
//  flixster
//
//  Created by Brayhan De Aza on 9/30/20.
//

import UIKit
import AlamofireImage


class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    var movies = [[String:Any]]()
   
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        
        collectionview.delegate = self
        collectionview.dataSource = self
        
        let layout = collectionview.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2 ) / 3
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        print((view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
              let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
              let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
              let task = session.dataTask(with: request) { (data, response, error) in
                 // This will run when the network request returns
                 if let error = error {
                    print(error.localizedDescription)
                 } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                  
                    self.movies = dataDictionary["results"] as! [[String:Any]]
                    self.collectionview.reloadData()
                    
                 }
              }
              task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.item]
       let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
