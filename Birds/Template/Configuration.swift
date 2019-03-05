//
//  Configuration.swift
//  Birds
//
//  Created by Ant Milner on 05/03/2019.
//  Copyright © 2019 RUME Academy. All rights reserved.
//

import CoreGraphics

extension CGPoint
{
    static public func * (left: CGPoint, right: CGFloat) -> CGPoint
    {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
}
