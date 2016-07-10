//
//  GameScene.swift
//  Gravity
//
//  Created by Brian Wang on 6/27/16.
//  Copyright (c) 2016 Brian Wang. All rights reserved.
//

import SpriteKit
let MAX_NUM_PLANETS:Int = 10
let GLOW_WIDTH:CGFloat = 2
let PLAYER_SIZE:CGFloat = 10
let MAX_LIVES:CGFloat = 3

let LOWERBOUND_DISTANCE_BETWEEN:CGFloat = 20
let UPPERBOUND_DISTANCE_BETWEEN:CGFloat = 80

let LOWERBOUND_PLANET_SIZE:CGFloat = 20
let UPPERBOUND_PLANET_SIZE:CGFloat = 50

let dt:CGFloat = 1.0 / 60.0 //Delta Time
let period:CGFloat = 1.25 //Number of seconds it takes to complete 1 orbit.
let pi:CGFloat = CGFloat(M_PI)

let gameCamera = SKCameraNode()

class GameScene: SKScene {
    
    var queue:[Planet] = [] {
        didSet {
            if queue.count > MAX_NUM_PLANETS {
                let lastPlanet = queue[queue.count - 1]
                lastPlanet.removeFromParent()
                lastPlanet.nextPlanet.previousPlanet = nil
                queue.removeLast()
            }
        }
    }
    
    var currentRotationDirection:RotationDirection = .Clock
    var currentPlanet:Planet! {
        didSet {
            let action = SKAction.moveTo(currentPlanet.position, duration: 0.5)
            action.timingMode = .EaseOut
            gameCamera.runAction(action)
        }
    }
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    var lives:Int = 0 {
        didSet {
            livesLabel.text = "\(lives)"
        }
    }
    var currentPlayer:Player!
    var angularDistance:CGFloat = 0
    var touchReceived:Bool = false
    var scoreLabel:SKLabelNode!
    var livesLabel:SKLabelNode!
    var loops:Int = 0
    
    override func didMoveToView(view: SKView) {
        view.backgroundColor = SKColor.blackColor()
        self.backgroundColor = SKColor.blackColor()
        self.physicsWorld.gravity = CGVectorMake(0,0)
        self.camera = gameCamera
        self.addChild(gameCamera)
        scoreLabel = SKLabelNode(text: String(score))
        scoreLabel.position = CGPointMake(-20 , frame.height/2 - 50)
        gameCamera.addChild(scoreLabel)
        livesLabel = SKLabelNode(text: String(lives))
        livesLabel.position = CGPointMake(20, frame.height/2 - 50)
        gameCamera.addChild(livesLabel)
        
        generatePlanet()
        currentPlanet = queue.last!
        initializePlayer(playerOfRadius: PLAYER_SIZE)
        generateHalfPlanets()
    }
   
    override func update(currentTime: CFTimeInterval) {
        updatePlayer()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let nextPlanet = currentPlanet.nextPlanet
        let currentDisp = nextPlanet.position - currentPlayer.position
        let currentDistanceBetween = currentDisp.length() - nextPlanet.radius - currentPlayer.radius
        if (currentDistanceBetween < 1.2 * nextPlanet.distanceBetweenPlayer) {
            angularDistance = nextPlanet.entryDirection.toPi()
            currentPlanet = nextPlanet
            self.currentRotationDirection = self.currentRotationDirection.opposite()
            score += 1
            self.generatePlanet()
        } else {
            if (lives <= 0) {
                gameOver()
            } else {
                lives -= 1
            }
        }
    }
    
    func updatePlayer() {
        let orbitCenter = currentPlanet.position //Point to orbit.
        let orbitRadius = currentPlanet.radius + currentPlayer.radius + currentPlanet.distanceBetweenPlayer
        
        currentPlayer.position = CGPoint(x: orbitCenter.x + CGFloat(sin(angularDistance)) * orbitRadius,
                                         y: orbitCenter.y + CGFloat(cos(angularDistance)) * orbitRadius)
        if (currentRotationDirection == .Clock) {
            angularDistance += (pi * 2.0) / period * dt
            if (fabs(angularDistance) >= pi * 2.0){
                angularDistance = 0
            }
            
        } else {
            angularDistance -= (pi * 2.0) / period * dt
            if (angularDistance <= 0) {
                angularDistance = pi * 2.0
            }
            
        }
    }
    
    func generateHalfPlanets() {
        while queue.count < MAX_NUM_PLANETS / 2 {
            generatePlanet()
        }
    }
    
    func generatePlanet() {
        let radius = randomInt(lower: LOWERBOUND_PLANET_SIZE, upper: UPPERBOUND_PLANET_SIZE)
        let planet = Planet(circleOfRadius: radius)
        planet.radius = radius
        planet.fillColor = SKColor.whiteColor()
        planet.glowWidth = GLOW_WIDTH
        planet.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        planet.physicsBody!.dynamic = false
        queue.insert(planet, atIndex: 0)
        if !(queue.count == 1) {
            let previousPlanet = queue[1]
            previousPlanet.nextPlanet = planet
            planet.previousPlanet = previousPlanet
            planet.entryDirection = previousPlanet.exitDirection.oppositeDirection()
            let distance = randomInt(lower: LOWERBOUND_DISTANCE_BETWEEN, upper: UPPERBOUND_DISTANCE_BETWEEN)
            planet.distanceBetweenPlayer = distance
            let disp = previousPlanet.radius + previousPlanet.distanceBetweenPlayer + (2 * currentPlayer.radius) + planet.distanceBetweenPlayer + planet.radius
            let vectorFromPrev = CGPointMake(sin(previousPlanet.exitDirection.toPi()) * disp, cos(previousPlanet.exitDirection.toPi()) * disp)
            planet.position = previousPlanet.position + vectorFromPrev
        } else {
            //first planet, set to the middle
            let distance = randomInt(lower: LOWERBOUND_DISTANCE_BETWEEN, upper: UPPERBOUND_DISTANCE_BETWEEN)
            planet.distanceBetweenPlayer = distance
            planet.position = CGPointMake(frame.midX, frame.midY)
        }
        if let entryDirection = planet.entryDirection {
            planet.exitDirection = entryDirection.randomExitDirection()
        } else {
            planet.exitDirection = PlanetDirection(rawValue: randomInt(lower: 0, upper: 7) * 0.25)
        }
        self.addChild(planet)
        
    }
    
    func initializePlayer(playerOfRadius radius:CGFloat) {
        let player = Player(circleOfRadius: radius)
        currentPlayer = player
        player.radius = radius
        let distance = randomInt(lower: LOWERBOUND_DISTANCE_BETWEEN, upper: UPPERBOUND_DISTANCE_BETWEEN)
        player.position = currentPlanet.position + CGPointMake(0, currentPlanet.radius + currentPlayer.radius + distance)
        player.fillColor = SKColor.whiteColor()
        player.glowWidth = GLOW_WIDTH
        player.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        
        self.addChild(player)
    }
    
    func movePlanets(planet:Planet!, toPoint point:CGPoint) {
        var index = 0
        let positionChange = point - planet.position
        let action = SKAction.moveBy(CGVector(point: positionChange), duration: 0.5)
        action.timingMode = .EaseOut
        while (index < self.queue.count) {
            let planetPointer = queue[index]
            planetPointer.runAction(action)
            index += 1
        }
    }
    
    func gameOver() {
        //TODO: GAMEOVER
    }
}
