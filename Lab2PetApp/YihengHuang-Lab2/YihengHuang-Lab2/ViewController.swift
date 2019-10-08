//
//  ViewController.swift
//  YihengHuang-Lab2
//
//  Created by labuser on 9/24/17.
//  Copyright © 2017 Yiheng Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dog = Pet(happy:0,food:0)
    var cat = Pet(happy:0,food:0)
    var bunny = Pet(happy:0,food:0)
    var fish = Pet(happy:0,food:0)
    var bird = Pet(happy:0,food:0)
    var pet = Pet(happy:0,food:0)
    
    @IBOutlet weak var hBar: DisplayView!
    
    @IBOutlet weak var fBar: DisplayView!
    
    @IBOutlet weak var petBackground: UIView!
    
    @IBOutlet weak var petView: UIImageView!
    
    @IBOutlet weak var notice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pet = cat
        petView.image = #imageLiteral(resourceName: "cat")
        hBar.color = UIColor.blue
        fBar.color = UIColor.blue
        hLevel.text = "Played: " + String(0)
        fLevel.text = "Fed: " + String(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        if(pet.foo > 0){
            pet.play()
            renewHappy(cur:pet)
            renewFood(cur:pet)
        }
    }
    
    @IBAction func feed(_ sender: UIButton) {
        pet.feed()
        renewFood(cur:pet)
    }
    func renewHappy(cur:Pet) {
        hBar.animateValue(to: CGFloat(Double(cur.hap)/10.0))
        hLevel.text = "Played: " + String(cur.hapAct)
        fLevel.text = "Fed: " + String(cur.fooAct)
        giveNotice(cur:cur)
    }
    
    func renewFood(cur:Pet) {
        fBar.animateValue(to: CGFloat(Double(cur.foo)/10.0))
        hLevel.text = "Played: " + String(cur.hapAct)
        fLevel.text = "Fed: " + String(cur.fooAct)
        giveNotice(cur:cur)
    }
    
    func change(cur:Pet){
        hBar.value = CGFloat(Double(cur.hap)/10.0)
        fBar.value = CGFloat(Double(cur.foo)/10.0)
        hLevel.text = "Played: " + String(cur.hapAct)
        fLevel.text = "Fed: " + String(cur.fooAct)
        giveNotice(cur:cur)
    }

    @IBOutlet weak var happiness: UILabel!
    @IBOutlet weak var food: UILabel!

    
    @IBOutlet weak var hLevel: UILabel!
    @IBOutlet weak var fLevel: UILabel!
    
    class Pet {
        
        var hap: Int = 0
        var foo: Int = 0
        var hapAct: Int = 0
        var fooAct: Int = 0
        
        func play(){
            
            hap += 1
            foo -= 1
            hapAct += 1
            if hap > 10{
                hap = 10
            }
        }
        
        func feed(){
            foo += 1
            fooAct += 1
            if foo >= 10 {
                foo = 10
            }
        }
        
        init(happy: Int, food: Int) {
            
            self.hap = happy
            self.foo = food
        }
    }
    
    @IBAction func dog(_ sender: UIButton) {
        pet = dog
        petView.image = #imageLiteral(resourceName: "dog")
        petBackground.backgroundColor = UIColor.red
        hBar.color = UIColor.red
        fBar.color = UIColor.red
        change(cur: pet)
    }
    
    @IBAction func cat(_ sender: UIButton) {
        pet = cat
        petView.image = #imageLiteral(resourceName: "cat")
        petBackground.backgroundColor = UIColor.blue
        hBar.color = UIColor.blue
        fBar.color = UIColor.blue
        change(cur: pet)
    }
    
    @IBAction func bird(_ sender: UIButton) {
        pet = bird
        petView.image = #imageLiteral(resourceName: "bird")
        petBackground.backgroundColor = UIColor.yellow
        hBar.color = UIColor.yellow
        fBar.color = UIColor.yellow
        change(cur: pet)
    }
    
    @IBAction func bunny(_ sender: UIButton) {
        pet = bunny
        petView.image = #imageLiteral(resourceName: "bunny")
        petBackground.backgroundColor = UIColor.cyan
        hBar.color = UIColor.cyan
        fBar.color = UIColor.cyan
        change(cur: pet)

    }
    
    @IBAction func fish(_ sender: UIButton) {
        pet = fish
        petView.image = #imageLiteral(resourceName: "fish")
        petBackground.backgroundColor = UIColor.purple
        hBar.color = UIColor.purple
        fBar.color = UIColor.purple
        change(cur: pet)
    }
    
    func giveNotice(cur:Pet){
        if(cur.foo <= 5){
            notice.text = "FEED!"
        }
        if(cur.foo > 5){
            notice.text = nil
        }
        if(cur.hap <= 5 && cur.foo > 5 ){
            notice.text = "PLAY!"
        }
        
    }
    
}
