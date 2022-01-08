//
//  Brick.swift
//  TetrisGame
//
//  Created by DK on 2022/01/09.
//

import Foundation
import SpriteKit

class Brick {
    
    struct Bricks {
        var color = UIColor()
        var points = Array<CGPoint>()
        let brickSize = 35
        let zPosition = CGFloat(1)
        var brickName = String()
    }
    func bricks() -> Bricks{
        var bricks = [Bricks]()
        
        var brick1 = [CGPoint]()
        brick1.append(CGPoint(x: 0, y: 0))
        brick1.append(CGPoint(x: 1, y: 0))
        brick1.append(CGPoint(x: -1, y: 0))
        brick1.append(CGPoint(x: 0, y: 1))
        bricks.append(Bricks(color:  .red, points: brick1, brickName: "brick1"))
    }
}
