//
//  ImageViewController.swift
//  DrawingLines
//
//  Created by 정지현 on 2021/04/05.
//

import UIKit

class ImageCanvas: UIImageView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.setStrokeColor(UIColor.systemYellow.cgColor)
        context.setAlpha(0.3)
        context.setLineWidth(20)
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


class ImageViewController: UIViewController {

    let canvas = ImageCanvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.image = UIImage(named: "samepleText")
        
        view.addSubview(canvas)
        canvas.backgroundColor = .white
        canvas.frame = view.bounds
        //view.sendSubviewToBack(canvas)
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
