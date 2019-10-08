//
//  dislikeViewController.swift
//  Yiheng Huang lab4
//
//  Created by Botao Chen on 10/24/17.
//  Copyright © 2017 yihenghuang. All rights reserved.
//

import UIKit

class dislikeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var finalData: [String] = []
    var deleteMovieIndexPath: NSIndexPath? = nil

    @IBOutlet weak var dislikeTitle: UINavigationItem!
    @IBOutlet weak var dislikeTable: UITableView!
    @IBAction func sortButton(_ sender: Any) {
        finalData.sort()
        dislikeTable.reloadData()
    }
    
    private func setupTableView() {
        dislikeTable.dataSource = self
        dislikeTable.delegate = self
        dislikeTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteMovieIndexPath = indexPath as NSIndexPath?
            let movieToDelete = finalData[indexPath.row]
            confirmDelete(planet: movieToDelete)
            
            finalData.remove(at: indexPath.row)
            var diso = UserDefaults.standard.stringArray(forKey: "dis") ?? [String]()
            
            diso.remove(at: indexPath.row)
            tableView.reloadData()
            UserDefaults.standard.set(diso,forKey:"dis")
        }
    }
    
    func confirmDelete(planet: String) {
        let alert = UIAlertController(title: "Delete Movie", message: "Do you really want to delete \(planet)?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeletePlanet)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeletePlanet)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    var deletePlanetIndexPath: NSIndexPath? = nil
    
    func handleDeletePlanet(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deletePlanetIndexPath {
            dislikeTable.beginUpdates()
            
            finalData.remove(at: indexPath.row)
            
            dislikeTable.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            
            deletePlanetIndexPath = nil
            
            dislikeTable.endUpdates()
        }
    }
    
    func cancelDeletePlanet(alertAction: UIAlertAction!) {
        deletePlanetIndexPath = nil
    }
    
    
    private func fetchData(){
        
        let array = UserDefaults.standard.stringArray(forKey: "dis")
        
        if ( array != nil){
            finalData = array!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = finalData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalData.count
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        dislikeTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dislikeTitle.title = "Dislikes"
        setupTableView()

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
