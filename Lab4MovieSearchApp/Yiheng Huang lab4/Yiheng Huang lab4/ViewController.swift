//
//  ViewController.swift
//  Yiheng Huang lab4
//
//  Created by Yiheng Huang on 10/22/17.
//  Copyright © 2017 yihenghuang. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    var ID:String!
    
    var finalName: String!
    var image: UIImage!
    
    var finalDate: String!
    var finalScore: String!
    var finalLanguage: String!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    
    @IBAction func shareButton(_ sender: Any) {
        let alert = UIAlertController(title: "Share!", message: "Share the Movie!", preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "Share on Facebook", style: .default) {(action) in
            if SLComposeViewController.isAvailable(forServiceType:  SLServiceTypeFacebook){
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                post.setInitialText(self.finalName)
                post.setInitialText(self.finalScore)
                post.setInitialText(self.finalLanguage)
                post.add(self.image)
                
                self.present(post, animated: true, completion: nil)
            }else{
                self.showAlert(service: "Facebook")
            }
        }
        let actionTwo = UIAlertAction(title: "Share on Twitter", style: .default) {(action) in
            if SLComposeViewController.isAvailable(forServiceType:  SLServiceTypeTwitter){
                let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                post.setInitialText(self.finalName)
                post.setInitialText(self.finalScore)
                post.setInitialText(self.finalLanguage)
                post.add(self.image)
                
                self.present(post, animated: true, completion: nil)
            }else{
                self.showAlert(service: "Twitter")
            }
        }
        
        let actionThree = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        alert.addAction(actionThree)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(service: String){
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }



    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var language: UILabel!
    
    @IBOutlet weak var movieName: UINavigationItem!
    @IBOutlet weak var moviePicture: UIImageView!

    @IBAction func addToLike(_ sender: Any) {
        if(UserDefaults.standard.stringArray(forKey: "fav") != nil){
            var array = UserDefaults.standard.stringArray(forKey: "fav") ?? [String]()
            
            if (!array.contains(finalName)) {
                array.append(finalName)
                UserDefaults.standard.set(array,forKey:"fav")
            }
            else {
                let favAlert = UIAlertController(title: "Oops!", message:
                    "It's already existed!", preferredStyle: UIAlertControllerStyle.alert)
                favAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                self.present(favAlert, animated: true, completion: nil)
            }
        }
        else{
            var array = [String]()
            array.append(finalName)
            UserDefaults.standard.set(array,forKey:"fav")
        }
        
        let myAlert = UIAlertController(title: "Great!", message:
            "Successfully Added to Likes!", preferredStyle: UIAlertControllerStyle.alert)
        myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(myAlert, animated: true, completion: nil)
    }

    @IBAction func addToDislike(_ sender: Any) {
        if(UserDefaults.standard.stringArray(forKey: "dis") != nil){
            var array = UserDefaults.standard.stringArray(forKey: "dis") ?? [String]()
            if (!array.contains(finalName)) {
                array.append(finalName)
                UserDefaults.standard.set(array,forKey:"dis")
            }
            else {
                let favAlert = UIAlertController(title: "Oops!", message:
                    "It's already existed!", preferredStyle: UIAlertControllerStyle.alert)
                favAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                self.present(favAlert, animated: true, completion: nil)
            }
        }
        else{
            var array = [String]()
            array.append(finalName)
            UserDefaults.standard.set(array,forKey:"dis")
        }
        
        let myAlert = UIAlertController(title: "OK!", message:
            "Successfully Added to Dislikes", preferredStyle: UIAlertControllerStyle.alert)
        myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(myAlert, animated: true, completion: nil)
    }
    
    private func fetchData(){
    
        print(ID)
        
        let json = getJSON(path: "https://api.themoviedb.org/3/movie/\(ID!)?api_key=5088218d00a2d95c81d2adec92fe1632")
        
        finalName = json["original_title"].stringValue
        finalDate = json["release_date"].stringValue
        finalScore = json["vote_average"].stringValue
        finalLanguage = json["original_language"].stringValue
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        movieName.title = finalName
        self.moviePicture.image = self.image
        date.text = "Released: \(finalDate!)"
        score.text = "Score: \(finalScore!)/10"
        language.text = "Language: \(finalLanguage!)"
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Movie" {
            let destination = segue.destination as! webViewController
            destination.nameOfMovie = finalName
        }
    }

    
}

