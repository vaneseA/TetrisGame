//
//  Variables.swift
//  TetrisGame
//
//  Created by DK on 2022/01/09.
//

import Foundation
import SpriteKit
struct Variables {
    static var backarrays = [[Int]]()
    static var scene = SKScene()
    static var brickValue = Brick().bricks()
    static var dx = 4
    static var dy = 2
    static let gab = 1
    static var startPoint = CGPoint()
    static var brickArrays = Array<CGPoint>()
    static var brickNode = Array<SKSpriteNode>()
    static var blockedArray = Array<SKSpriteNode>()
    static var isPause = false
    static var nodeGroup = [[SKSpriteNode]]()
    static var newBrickArrays = [Brick.Bricks]()
    static let row = 10
    static let col = 20
    
}
