//
//  BackGround.swift
//  TetrisGame
//
//  Created by DK on 2022/01/09.
//

import Foundation
import SpriteKit

class BackGround {
    
    let row = 10
    let col = 20
    
    init() {
        Variables.backarrays = Array(repeating: Array(repeating: 0, count: row), count: col)
    }
}
