//
//  GameScene.swift
//  Test34-S19
//
//  Created by MacStudent on 2019-06-19.
//  Copyright © 2019 rabbit. All rights reserved.
//

import SpriteKit
import GameplayKit

class Level2: SKScene, SKPhysicsContactDelegate {
    
    var nextLevelButton:SKLabelNode!
    
    var lemming : SKSpriteNode!
    
    //    let sprite : SKSpriteNode?
    
    
    
    
    override func didMove(to view: SKView) {
        print("Loaded level 2")
        
        self.physicsWorld.contactDelegate = self
        
        self.nextLevelButton = self.childNode(withName: "nextLevelButton") as! SKLabelNode
        //        let redSpriteNode = SKSpriteNode(imageNamed: "red") // add sprite by code
        //        redSpriteNode.name = "red"
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        makeLemmings()
        
        lemming.position.x = lemming.position.x + 50
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if(nodeA!.name == "lemmings" && nodeB!.name == "exit")
        {
            
            print("player touch the exit")
            
        }
        if(nodeA!.name == "exit" && nodeB!.name == "lemmings")
        {
            
            print("player touch the exit")
            
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        let touch = touches.first
        if (touch == nil) {
            return
        }
        
        let location = touch!.location(in:self)
        let node = self.atPoint(location)
        
        
        
        
        // MARK: Switch Levels
        
        if (node.name == "nextLevelButton") {
            let scene = SKScene(fileNamed:"Level3")
            if (scene == nil) {
                print("Error loading level")
                return
            }
            else {
                scene!.scaleMode = .aspectFill
                view?.presentScene(scene!)
            }
        }
        
    }
    
    
    var lemmings:[SKSpriteNode] = []
    
    var movingEnemyRight = true
    
    func makeLemmings() {
        // lets add some enemies
        lemming = SKSpriteNode(imageNamed: "lemmings")
        
        
        // generate a random (x,y) for the cat
        let randX = 100
        let randY = 1200
        
        lemming.position = CGPoint(x:randX, y:randY)
        
        
        
        if lemmings.count < 6 {
            addChild(lemming)
            
            self.lemmings.append(lemming)
            //            lemming.position.x = lemming.position.x + 10
            
            let lemmingBodyTexture = SKTexture(imageNamed: "lemmings")
            lemming.physicsBody = SKPhysicsBody(texture: lemmingBodyTexture,
                                                size: lemmingBodyTexture.size())
            
            if lemming.position.x == 800 {
                lemming.physicsBody?.isDynamic = true
                lemming.physicsBody?.allowsRotation = false
            }
            
            
            
        }
        
        // for loop to move lemmings
        
        for (i, enemy) in self.lemmings.enumerated() {
//            print("Moving enemy : \(i)")
            if(movingEnemyRight == true)
            {
                let RightMoveAction = SKAction.scaleX(to: +1, duration: 0)
                self.lemmings[i].run(RightMoveAction)
                lemmings[i].position.x =     lemmings[i].position.x + 10;
                if(lemmings[i].position.x >= self.frame.width)
                {
                    movingEnemyRight = false
                }
            }
            else if (movingEnemyRight == false){
                
                let leftMoveAction = SKAction.scaleX(to: -1, duration: 0)
                self.lemmings[i].run(leftMoveAction)
                lemmings[i].position.x =     lemmings[i].position.x - 10;
                if(lemmings[i].position.x <= 0)
                {
                    movingEnemyRight = true
                }
            }
        }
        
        
        
    }
}
