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
    
    let gameCamera = SKCameraNode()                 //add camera property to gamescene clas
    var panRecognizer = UIPanGestureRecognizer()    //new property UI Pinch Gesture
    
    override func didMove(to view: SKView)
    {
        addCamera()
        setupGestureMethod()
    }
    
    func setupGestureMethod()
    {
        guard  let view = view else { return }
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        view.addGestureRecognizer(panRecognizer)
    }
        
    func addCamera()                                //custom method to add the camera
    {
        guard let view = view else { return }       //fixes error - this checks the view property contains a value and binds to local view constant that is non-optional
        addChild(gameCamera)
        gameCamera.position = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2) //bottom left edge of scene
        camera = gameCamera                         //Set the camera to GameCamera
    }
        
}

extension GameScene
{
    //all extras for gesture recogniser
    @objc func pan(sender: UIPanGestureRecognizer)
    {
        guard let view = view else { return }
        let translation = sender.translation(in: view)
        gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y) //adding +/- translation allows scrolling of screen (panning) left and right
        sender.setTranslation(CGPoint.zero, in: view)
    }
}
   

