//
//  DrawView.swift
//  YihengHuangLab3
//
//  Created by labuser on 10/2/17.
//  Copyright © 2017 wustl. All rights reserved.
//

import UIKit

class DrawView: UIView {
/*    var lines: [Line] = []
    var lastPoint: UITouch!
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        lastPoint = touches.anyObject().locationInView(self)
//        lastPoint = touches.first!
        guard let touchPoint = touches.first?.location(in: ) else { return }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        var newPoint = touches.anyObject().locationInView(self)
        var newPoint = touches.first!
        lines.append(Line(start: lastPoint, end: newPoint))
        lastPoint = newPoint
        
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        let path = CGMutablePath()
        let context = UIGraphicsGetCurrentContext()
        
        //CGcontextBeginPath(context)
    
        for line in lines {
//            CGContextMoveToPoint(context, line.startX, line.startY)
//            CGContextAddLineToPoint(context, line.endX, line.endY)
            
            path.move(to: CGPoint(x: line.startX, y: line.startY))
            path.addLine(to: CGPoint(x: line.endX, y: line.endY))
            context!.strokePath()
            CGLineCap.round
            context!.setStrokeColor(red: 1,green: 0,blue: 0,alpha: 1)
            context!.setLineWidth(5)
            
        }
//        CGContextSetLineCap(context,KCGLineCapRound)
//        CGLineCap.round
//        context!.setStrokeColor(red: 1,green: 0,blue: 0,alpha: 1)
//        context!.setLineWidth(5)
       //CGContextStrokePath(context)
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
 */
    
    var line:[CGPoint]?{
        didSet{
            setNeedsDisplay()
        }
    }

    var width: CGFloat?
    var color: UIColor?
    
    init(frame:CGRect, f: CGFloat, c: UIColor){
        super.init(frame:frame)
        width=f
        color=c
        self.backgroundColor=UIColor.clear
    }

   required init?(coder aDecoder:NSCoder){
        super.init(coder : aDecoder)!
       // self.backgroundColor=UIColor.black
    }
/*
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

*/


    override func draw(_ rect: CGRect){
        var path = UIBezierPath()
        
        if line?.count == 1{
            path.addArc(withCenter: (line?[0])!, radius: width!/2, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        }
        else{
            // if val of line == nill return
            // if not draw the path
            guard let pointList = line else {
                return
            }
            
            path = createQuadPath(points: pointList)
            
        }
        
        color!.setStroke()
        path.lineWidth=CGFloat(width!)
        path.stroke()
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        let xC: CGFloat = (first.x+second.x)/2.0
        let yC: CGFloat = (first.y+second.y)/2.0
        let midPoint = CGPoint(x:xC, y:yC)
        
        return midPoint
    }
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
}
