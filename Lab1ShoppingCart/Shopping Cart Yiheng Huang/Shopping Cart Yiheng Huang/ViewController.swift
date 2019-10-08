//
//  ViewController.swift
//  Shopping Cart Yiheng Huang
//
//  Created by labuser on 9/12/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var op = 0.0
    var dr = 0.0
    var tr = 0.0
    var fp = 0.0
    var ms = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var appTitle: UILabel!

    @IBOutlet weak var originalPrice: UILabel!
    
    @IBOutlet weak var discountRate: UILabel!
    
    @IBOutlet weak var taxRate: UILabel!
    
    @IBOutlet weak var finalPrice: UILabel!
    
    @IBOutlet weak var fPrice: UILabel!

    @IBAction func priceText(_ sender: UITextField) {
        if (op == nil){
            op=0
        }else{
            op = Double(sender.text!)!
        }
        let fp = op*(1.0-dr)*(1.0+tr)
        fPrice.text = "$\(String(format: "%.2f", fp))"
    }
    
    
    @IBAction func discountText(_ sender: UITextField) {
        if (dr == nil){
            dr=0
        }else{
            dr = Double(sender.text!)!/100
        }
        let fp = op*(1.0-dr)*(1.0+tr)
        fPrice.text = "$\(String(format: "%.2f", fp))"
    }

    @IBAction func taxText(_ sender: UITextField) {
        if (tr == nil){
            tr=0
        }else{
            tr = Double(sender.text!)!/100
        }
        let fp = op*(1.0-dr)*(1.0+tr)
        fPrice.text = "$\(String(format: "%.2f", fp))"
    }
    
    @IBOutlet weak var mSaved: UILabel!
    
    @IBAction func moneySaved(_ sender: UIButton) {
        ms = op*(1.0+tr)-op*(1.0-dr)*(1.0+tr)
        mSaved.text = "$\(String(format: "%.2f", ms))"
    }
}
