//
//  Mars.swift
//  RobotDemo
//
//  Created by Dominic Wood on 13/09/2021.
//

import Foundation

enum SurfaceAttribute {
    case clear
    case scented
}

protocol MarsProtocol {
    var xDimension: Int {get}
    var yDimension: Int {get}
    
    func setMarsSurfaceDimension(coords: (x: Int, y: Int)) -> Bool
    func isPositionOffscreen(coords: (x: Int, y: Int)) -> Bool
    func isPositionScented(coords: (x: Int, y: Int)) -> Bool
    func markScentAtPosition(coords: (x: Int, y: Int))
}

// used class instead of struct as its likely it maybe sub classed in future

class Mars: MarsProtocol {
    var xDimension: Int = 0
    var yDimension: Int = 0
    var surface = [[SurfaceAttribute]]()
    
    func setMarsSurfaceDimension(coords: (x: Int, y: Int)) -> Bool {
        guard coords.x <= 50 else {
            return false
        }
        guard coords.y <= 50 else {
            return false
        }
        xDimension = coords.x
        yDimension = coords.y
        
        surface = Array(repeating: Array(repeating: .clear, count: yDimension), count: xDimension)
        return true
    }
    
    func isPositionOffscreen(coords: (x: Int, y: Int)) -> Bool {
        guard coords.x >= 0 else {
            return true
        }
        guard coords.x < xDimension else {
            return true
        }
        guard coords.y >= 0 else {
            return true
        }
        guard coords.y < yDimension else {
            return true
        }
        return false
    }
    
    func isPositionScented(coords: (x: Int, y: Int)) -> Bool {
        surface[coords.x][coords.y] == .scented
    }
    
    func markScentAtPosition(coords: (x: Int, y: Int)) {
        surface[coords.x][coords.y] = .scented
    }

}
