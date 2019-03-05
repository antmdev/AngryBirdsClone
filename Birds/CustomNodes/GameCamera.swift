//
//  GameCamera.swift
//  Birds
//
//  Created by Ant Milner on 04/03/2019.
//  Copyright © 2019 RUME Academy. All rights reserved.
//

import SpriteKit

class GameCamera: SKCameraNode
{
    
    func setConstraints(with scene: SKScene, and frame:CGRect, to node: SKNode?)
    {
        let scaledSize = CGSize(width: scene.size.width * xScale, height: scene.size.height * yScale)
        let boardContentRect = frame            //dont see anything after edges
        
    //creates a new rectangle that keeps the cmaera constrain within this rectangle
    //distance to boarder of map will alsways be at least half the cameras frame so we should never see it
        let xInset = min(scaledSize.width / 2, boardContentRect.width / 2)
        let yInset = min(scaledSize.height / 2, boardContentRect.height / 2)
        let insentContentRect = boardContentRect.insetBy(dx: xInset, dy: yInset)
        
        let xRange = SKRange(lowerLimit: insentContentRect.minX, upperLimit: insentContentRect.maxX)
        let yRange = SKRange(lowerLimit: insentContentRect.minY, upperLimit: insentContentRect.maxY)
        
        let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        
        constraints = [levelEdgeConstraint]
    }

}

