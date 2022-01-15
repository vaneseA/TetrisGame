//
//  GameScene.swift
//  TetrisGame
//
//  Created by DK on 2022/01/09.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var leftButton : LeftButton?
    override func didMove(to view: SKView) {
        Variables.scene = self
        _ = BackGround()
        _ = BrickGenerator()
   
         leftButton = LeftButton()
        
    }
    
    func checkBrick(){
        let array = Variables.backarrays
        for item in array{
            print(item)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        let node = nodes(at: location!)
        for item in node{
            if item.name == "left"{
                leftButton?.brickMoveLeft()
            }
        }
    }
}

