//
//  ViewController.swift
//  YihengHuangLab3
//
//  Created by labuser on 10/2/17.
//  Copyright © 2017 wustl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currLine: [CGPoint]=[]
    var drawview: DrawView?
    var width: CGFloat = 10
    var color: UIColor = UIColor.black
    

    
    @IBOutlet var drawFrame: UIView!
    @IBOutlet var red: UIButton!
    @IBOutlet var orange: UIButton!
    @IBOutlet var yellow: UIButton!
    @IBOutlet var green: UIButton!
    @IBOutlet var blue: UIButton!
    @IBOutlet var purple: UIButton!
    @IBOutlet var magenta: UIButton!
    @IBOutlet var eraser: UIButton!
    
    @IBOutlet var widthLabel: UILabel!
    @IBOutlet var transparencyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorButton(btn: red,color:UIColor.red)
        colorButton(btn: orange,color:UIColor.orange)
        colorButton(btn: yellow,color:UIColor.yellow)
        colorButton(btn: green,color:UIColor.green)
        colorButton(btn: blue,color:UIColor.blue)
        colorButton(btn: purple,color:UIColor.purple)
        colorButton(btn: magenta,color:UIColor.magenta)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func colorButton(btn:UIButton,color:UIColor){
        btn.backgroundColor=color
        btn.layer.cornerRadius=btn.frame.height/2.0
    }

    
    
    
    @IBAction func widthAdj(_ sender: UISlider) {
        let v : CGFloat=CGFloat(sender.value)
        if(v == 0){
            width=1
        }
        else{
            width = v*50
        }

    }
    @IBAction func transparencyAdj(_ sender: UISlider) {
        color=color.withAlphaComponent(CGFloat(sender.value))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clear() {
        for view in drawFrame.subviews{
            view.removeFromSuperview()
        }
    }
    
    @IBAction func undo(_ sender: UIBarButtonItem) {
        let pv=drawFrame.subviews.endIndex
        if(pv >= 1){
            drawFrame.subviews[pv-1].removeFromSuperview()
        }
    }
    
    @IBAction func changeRed() {
        color=UIColor.red
    }
    
    @IBAction func changeOrange() {
        color=UIColor.orange
    }
    
    @IBAction func changeYellow() {
        color=UIColor.yellow
    }
    
    @IBAction func changeGreen() {
        color=UIColor.green
    }
    
    @IBAction func changeBlue() {
        color=UIColor.blue
    }
    
    @IBAction func changePurple() {
        color=UIColor.purple
    }
    
    @IBAction func changeMagenta() {
        color=UIColor.magenta
    }
    
    @IBAction func erase() {
        color=UIColor.white

    }
    
    @IBAction func redBack(_ sender: UIButton) {
        drawview?.backgroundColor = UIColor.red
    }
    @IBAction func orangeBack(_ sender: UIButton) {
        drawview?.backgroundColor = UIColor.orange
    }
    @IBAction func yellowBack(_ sender: UIButton) {
        drawview?.backgroundColor = UIColor.yellow
    }
    @IBAction func greenBack(_ sender: UIButton) {
        drawview?.backgroundColor = UIColor.green
    }
    @IBAction func blueBack(_ sender: UIButton) {
        drawview?.backgroundColor = UIColor.blue
    }
    @IBAction func purpleBack(_ sender: UIButton) {
        drawview?.backgroundColor = UIColor.purple
    }
    @IBAction func magentaBack(_ sender: UIButton) {
        drawview?.backgroundColor = UIColor.magenta
    }
    @IBAction func whiteBack(_ sender: UIButton) {
        drawview?.backgroundColor = UIColor.white
    }
    
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touchPoint = touches.first?.location(in: drawFrame) else { return }
            currLine.append(touchPoint)
            let myframe = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            drawview = DrawView(frame: myframe, f: width, c:color)
            
            drawview?.line = currLine
            drawFrame.addSubview(drawview!)
            
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touchPoint = touches.first?.location(in: drawFrame) else { return }
            
            currLine.append(touchPoint)
            drawview?.line = currLine
            
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            currLine.removeAll()
            
        }



}

