//
//  ViewController.swift
//  DrawingLines
//
//  Created by 정지현 on 2021/04/04.
//

import UIKit

class Canvas: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // dummy line
        //let startPoint = CGPoint(x: 0, y: 0)
        //let endPoint = CGPoint(x: 100, y: 100)
        //context.move(to: startPoint)
        //context.addLine(to: endPoint)
        
        context.setStrokeColor(UIColor.systemTeal.cgColor)
        //context.setAlpha(0.3)
        context.setLineWidth(5)
        context.setLineCap(.round)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                // i: indexes, p: every points on the line
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        context.strokePath()
        
    }
    
    //var line = [CGPoint]()
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    // track the finger as we move across screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        //print(point)
        //line.append(point)
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
}

class ViewController: UIViewController {
    
    let canvas = Canvas()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        
        canvas.backgroundColor = .white
        canvas.frame = view.frame
        view.sendSubviewToBack(canvas)
    }


}

