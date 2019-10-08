//
//  webViewController.swift
//  Yiheng Huang lab4
//
//  Created by labuser on 10/24/17.
//  Copyright © 2017 yihenghuang. All rights reserved.
//

import UIKit

class webViewController: UIViewController {

    @IBOutlet weak var youtubePage: UIWebView!
    
    var nameOfMovie: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let input = nameOfMovie.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let youtubeUrl = URL(string: "https://www.youtube.com/results?search_query=\(input)")
        youtubePage.loadRequest(URLRequest(url: youtubeUrl!))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
