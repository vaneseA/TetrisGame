//
//  DownButton.swift
//  TetrisGame
//
//  Created by DK on 2022/01/16.
//

import Foundation
import SpriteKit

class DownButton{
    
    let btn = SKSpriteNode()
    init() {
        btn.texture = SKTexture(imageNamed: "down_btn1")
        btn.size = CGSize(width: 30, height: 30)
        btn.name = "down"
//        btn.zPosition = 1 //머지 이거 뺐는데 잘댐 레프트버튼에는 없음
        let point1 = Int(Variables.scene.frame.width) / 2
        let point2 = -50
        let xValue = (point1 - point2) / 2
        btn.position = CGPoint(x: xValue, y: -Int(Variables.scene.frame.height) + 50)
        Variables.scene.addChild(btn)
    }
    func anim(){
        var textures = Array<SKTexture>()
        for i in 1...15{
            let name = "down_btn\(i)"
            let texture = SKTexture(imageNamed:  name)
            textures.append(texture)
        }
        let action = SKAction.animate(with: textures, timePerFrame: 0.03)
        btn.run(action)
    }
    
    func brickDown() {
        if isbrickDownable(){
            possibleDown()
        }else{
            impossibleDown()
        }
    }
    // 블럭이 아래로 내려갈수 있을떄
    func possibleDown(){
        Variables.dy += 1
        var action = SKAction()
        for (i, item) in Variables.brickArrays.enumerated(){
            let x = Int(item.x) + Variables.dx
            let y = Int(item.y) + Variables.dy
            
            Variables.backarrays[y - 1][x] -= 1
            Variables.backarrays[y][x] += 1
            action = SKAction.moveBy(x: 0, y: -CGFloat(Variables.brickValue.brickSize), duration: 0.1)
            Variables.brickNode[i].run(action)
        }
        
    }
    
    // 블럭이 아래로 내려갈수 없을떄
    func impossibleDown(){
        //값을 2로 변경
        for item in Variables.brickArrays{
            let x = Int(item.x) + Variables.dx
            let y = Int(item.y) + Variables.dy
            Variables.backarrays[y][x] = 2
            //새로운 블럭 생성
            let blocked = SKSpriteNode()
            blocked.color = .gray
            blocked.size = CGSize(width: Variables.brickValue.brickSize - Variables.gab, height: Variables.brickValue.brickSize - Variables.gab)
            blocked.name = "blocked"
            let xValue = x * Variables.brickValue.brickSize + Int(Variables.startPoint.x)
            let yValue = y * Variables.brickValue.brickSize + Int(Variables.startPoint.y)
            blocked.position = CGPoint(x: xValue, y: -yValue)
            Variables.scene.addChild(blocked)
            Variables.blockedArray.append(blocked)
        }
        //기존 블럭 삭제
        for item in Variables.brickNode{
            item.removeFromParent()
        }
        //데이터체크
        for item in Variables.backarrays{
            print(item)
        }
        checkDelete()
    }
    func checkDelete(){
        // 블럭에서 중복된 y 값을 제거
        var set = Set<Int>()
        for item in Variables.brickArrays{
            let y = Int(item.y) + Variables.dy
            set.insert(y)
        }
        //가져온 y 값으로 행 체크
        for y in set.sorted(){
            let yValue = y * Variables.brickValue.brickSize + Int(Variables.startPoint.y)
            //체크한 행이 0이 포함되어 있지 않으면 실행
            if !Variables.backarrays[y].contains(0){
                Variables.backarrays.remove(at: y)
                
                var rowArray = Array<Int>()
                for i in 0..<Variables.row{
                    rowArray.append(0)
                }
                rowArray[rowArray.startIndex] = 2
                rowArray[rowArray.endIndex - 1] = 2
                Variables.backarrays.insert(rowArray, at: 1)
                print("삭제됨")
                print(rowArray)
                //삭제 효과음
                Variables.blockedArray.first?.run(SKAction.playSoundFileNamed("delete.wav", waitForCompletion: false))
                //삭제효과 에미터
                fire(position: CGPoint(x: Int(Variables.scene.frame.width) / 2, y: -yValue))
                     
                for item in Variables.blockedArray{
                    //같은 라인에 있는 경우
                    if Int(item.position.y) == -yValue{
                        if let removeItem = Variables.blockedArray.firstIndex(of: item){
                            Variables.blockedArray.remove(at: removeItem)
                            var action = SKAction()
                            action = SKAction.fadeOut(withDuration: 0.1)
                            item.run(action){
                                item.removeFromParent()
                            }
                        }
                    }
                    //현재 라인 보다 위에 있을 경우
                    if Int(item.position.y) > -yValue{
                        var action = SKAction()
                        action = SKAction.moveBy(x: 0, y: -CGFloat(Variables.brickValue.brickSize), duration: 0.5)
                        item.run(action)
                    }
                }
            }
        }
        if isGameOver(deadLine: Variables.dy){
        //블록 새생성
            NextBricks().nextBrickMoveLeft()
        _ = BrickGenerator()
        }
    }
    func isbrickDownable() -> Bool{
        for item in Variables.brickArrays{
            let x = Int(item.x) + Variables.dx
            let y = Int(item.y) + Variables.dy
            if Variables.backarrays[y+1][x] == 2{
                return false
            }
        }
        return true
    }
    func isGameOver(deadLine : Int) ->Bool{
        if deadLine > 2 {
            return true
        }else{
            if let scene = GameOver(fileNamed: "GameOver"){
                let transition = SKTransition.moveIn(with: .right, duration: 1)
                Variables.scene.view?.presentScene(scene, transition: transition)
            }
            return false
        }
    }
    func fire(position : CGPoint){
        let fire = SKEmitterNode(fileNamed: "Fire.sks")
        fire?.particlePosition = position
        fire?.particlePositionRange = CGVector(dx: Int(Variables.scene.frame.width) - Variables.brickValue.brickSize * 2, dy: Variables.brickValue.brickSize)
        Variables.scene.addChild(fire!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            fire?.removeFromParent()
        }
    }
}
