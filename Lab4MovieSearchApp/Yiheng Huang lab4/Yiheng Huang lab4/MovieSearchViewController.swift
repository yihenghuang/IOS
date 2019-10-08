//
//  MovieSearchViewController.swift
//  Yiheng Huang lab4
//
//  Created by Botao Chen on 10/23/17.
//  Copyright © 2017 yihenghuang. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var searchTitle: UINavigationItem!
    @IBOutlet weak var searchCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    var movieArray: [Info] = []
    var imageCache: [UIImage] = []

    var imdbName: String!
    var input: String!
    
    var thePoster: UIImage!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieArray.removeAll()
        imageCache.removeAll()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped=true
        activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.gray
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchData(t: self.searchBar.text!)
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.searchCollection.reloadData()
            }
        }
    }
    
    private func fetchData(t:String){
        
        let newString = t.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        let json = getJSON(path: "https://api.themoviedb.org/3/search/movie?api_key=5088218d00a2d95c81d2adec92fe1632&query=\(newString)")
        
        for result in json["results"].arrayValue{
            
            var m = Info()
            m.picture = "https://image.tmdb.org/t/p/w500"+result["poster_path"].stringValue
            m.title = result["title"].stringValue
            m.date = result["release_date"].stringValue
            m.score = result["vote_average"].intValue
            m.language = result["original_language"].stringValue
            
            m.id = result["id"].stringValue
            
            movieArray.append(m)
            print(m.picture!)
            print(m.title!)
            //from the struct file - Info
        }
        catchImages()
    }
    
    
/*    private func catchImages() {
        
        for item in imageCache {
            
            if item.picture != "" {
                
                let image = UIImage(named: "noavailicon.png")
                imageCache.append(image!)
            }else{
                let url = URL(string: "https://image.tmdb.org/t/p/w500"+item.picture!)!
                let data = try? Data(contentsOf: url)
                let image = UIImage(data: data!)
                imageCache.append(image!)
            }
*/
    
    private func catchImages(){
        
        for item in movieArray{
            do{
                if item.picture != ""{
                    var url = URL(string: item.picture!)
                    if item.picture == "https://image.tmdb.org/t/p/w500" {
                        let image = UIImage (named: "noavailicon.png")
                        imageCache.append(image!)

                    }else{
                    let imagedata = try Data(contentsOf: url!)
                    let image = UIImage(data: imagedata)
                    imageCache.append(image!)
                    }
                }
            }catch{
                
                print("error")
            }
        
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! collectionCell
        
        cell.movieLabel.text = movieArray[indexPath.row].title
        cell.posterImage.image = imageCache[indexPath.row]
        
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCache.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! collectionCell
        
        imdbName = movieArray[indexPath.row].id
        thePoster = imageCache[indexPath.row]
        
        
        
        self.performSegue(withIdentifier: "imdb", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "imdb" {
            let destination = segue.destination as! ViewController
            destination.ID = imdbName
            destination.image = thePoster
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTitle.title="Movie"
        searchBar.delegate = self
        searchCollection.dataSource = self
        searchCollection.delegate = self


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getJSON(path: String) -> JSON {
        guard let url = URL(string: path) else { return JSON.null }
        do {
            let data = try Data(contentsOf: url)
            return try JSON(data: data)
        } catch {
            return JSON.null
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
