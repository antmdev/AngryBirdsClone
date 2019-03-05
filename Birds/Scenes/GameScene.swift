//
//  GameScene.swift
//  Angry Birds
//
//  Created by Ant Milner on 04/03/2019.
//  Copyright © 2019 Ant Milner. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    
    var mapNode = SKTileMapNode()
    let gameCamera = GameCamera()                 //add camera Class to gamescene class
    var panRecognizer = UIPanGestureRecognizer()    //new property UI Pinch Gesture
    var pinchRecognizer = UIPinchGestureRecognizer()    //set up pinch recognizer
    var maxScale: CGFloat = 0
    
    override func didMove(to view: SKView)
    {
//        addCamera()
        setupLevel()
        setupGestureRecognisers()
        
    }
    
    func setupGestureRecognisers()
    {
        guard let view = view else { return }
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        view.addGestureRecognizer(panRecognizer)
        
        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        view.addGestureRecognizer(pinchRecognizer)
    }
    
    func setupLevel()
    {
        if let mapNode = childNode(withName: "Tile Map Node") as? SKTileMapNode
        {
            self.mapNode = mapNode
            maxScale = mapNode.mapSize.height/frame.size.height //stops pinching from zooming past edge of screen
        }
        
        addCamera()
    }
        
    func addCamera()                                //custom method to add the camera
    {
        guard let view = view else { return }       //fixes error - this checks the view property contains a value and binds to local view constant that is non-optional
        addChild(gameCamera)
        gameCamera.position = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2) //bottom left edge of scene
        camera = gameCamera                         //Set the camera to GameCamera
        gameCamera.setConstraints(with: self, and: mapNode.frame, to: nil)
    }
        
}

extension GameScene
{
    //all extras for gesture recogniser
    @objc func pan(sender: UIPanGestureRecognizer)
    {
        guard let view = view else { return }
        let translation = sender.translation(in: view) * gameCamera.yScale  //config function fixes point * float multiply
        gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y) //adding +/- translation allows scrolling of screen (panning) left and right
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer)
    {
        guard let view = view else { return }
        if sender.numberOfTouches == 2
        {
            let locationInView = sender.location(in: view)
            let location = convertPoint(fromView: locationInView)
            if sender.state == .changed
            {
                let convertedScale = 1/sender.scale
                let newScale = gameCamera.yScale*convertedScale
                if newScale < maxScale && newScale > 0.5
                {
                    gameCamera.setScale(newScale)
                }
                
                
                let locationAfterScale = convertPoint(fromView: locationInView)
                let locationDelta = CGPoint(x: location.x - locationAfterScale.x, y: location.y - locationAfterScale.y)
                let newPosition = CGPoint(x: gameCamera.position.x + locationDelta.x, y: gameCamera.position.y + locationDelta.y)
                gameCamera.position = newPosition
                sender.scale = 1.0                                   //avoids jumps in scaling
                gameCamera.setConstraints(with: self, and: mapNode.frame, to: nil)
            }
        }
    }
}
   

