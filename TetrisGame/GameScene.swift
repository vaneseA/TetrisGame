//
//  GameScene.swift
//  TetrisGame
//
//  Created by DK on 2022/01/09.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    override func didMove(to view: SKView) {
        Variables.scene = self
        let bg = BackGround()
        let generator = BrickGenerator() 
        checkBrick()
    }
    
    func checkBrick(){
        let array = Variables.backarrays
        for item in array{
            print(item)
        }
    }
}
