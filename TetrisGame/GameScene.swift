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
        
        let bg = BackGround()
        checkBrick()
    }
    
    func checkBrick(){
        let array = Variables.backarrays
        for item in array{
            print(item)
        }
    }
}
