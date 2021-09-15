//
//  Robot.swift
//  RobotDemo
//
//  Created by Dominic Wood on 13/09/2021.
//

import Foundation

enum Heading: String {
    case north = "N"
    case east = "E"
    case south = "S"
    case west = "W"
}

protocol RobotProtocol {
    var planet: MarsProtocol {get}
    var coords: (x: Int, y: Int) {get set}
    var heading: Heading {get set}
    var isLost: Bool {get set}
    var output: String {get set}
   
    func processCommand(input: String)
    func rotateLeft()
    func rotateRight()
    func moveForward()
    func logPositionHeading() -> String
}

class Robot: RobotProtocol {
    
    var planet: MarsProtocol = Mars()
    
    var coords = (x: 0, y: 0)
    
    var heading = Heading.north
    
    var isLost: Bool = false
    
    var output: String = ""
    
    func processCommand(input: String) {
        output = ""
        isLost = false
        let lines = input.components(separatedBy: "\n")
        
        let dimensionsCommand = lines[0]
        let positionHeadingCommand = lines[1]
        let movementCommand = lines[2]
        
        //set Mars surface
        guard let dimensions = commandToCoords(command: dimensionsCommand) else {
            print("Can't construct planet from command")
            return
        }
        
        guard planet.setMarsSurfaceDimension(coords: dimensions) else {
            print("Planet dimensions incorrect")
            return
        }
        
        //set initial Robot coordds and heading
        guard let initialCoords = commandToCoords(command: positionHeadingCommand) else {
            print("Error in initial coords")
            return
        }
        
        let headingCharacter = Array(positionHeadingCommand)[4]
        guard let initialHeading = characterToHeading(headingCharacter: headingCharacter) else {
            print("Illegal heading")
            return
        }
        
        coords = initialCoords
        heading = initialHeading
        
        //parse the movement commands
        
        for char in movementCommand {
            switch char {
            case "F":
                moveForward()
            case "L":
                rotateLeft()
            case "R":
                rotateRight()
            default:
                print("Error in command")
            }
        }

        output = logPositionHeading()
        if isLost {
            output = output + "LOST"
        }
        print(output)
    }
    
    func logPositionHeading() -> String {
        var log = String(coords.x) + " "
        log = log + String(coords.y) + " "
        log = log + heading.rawValue
        return log
    }
    
    private func commandToCoords(command: String) -> (x: Int, y: Int)? {
        if let x = command.first?.wholeNumberValue, let y = Array(command)[2].wholeNumberValue {
            return (x: x, y: y)
        }
        return nil
    }
    
    private func characterToHeading(headingCharacter: String.Element) -> Heading? {
       
        switch headingCharacter {
        case "N":
            return .north
        case "E":
            return .east
        case "S":
            return .south
        case "W":
            return .west
        default:
            return nil
        }
    }
    
    func rotateLeft() {
        switch heading {
        case .north:
            heading = .west
        case .east:
            heading = .north
        case .south:
            heading = .east
        case .west:
            heading = .south
        }
    }
    
    func rotateRight() {
        switch heading {
        case .north:
            heading = .east
        case .east:
            heading = .south
        case .south:
            heading = .west
        case .west:
            heading = .north
        }
    }
    
    func moveForward() {
        var newCoords = coords
        
        switch heading {
        case .north:
            newCoords.y += 1
        case .east:
            newCoords.x += 1
        case .south:
            newCoords.y -= 1
        case .west:
            newCoords.x -= 1
        }
        
        //test new Coords if off screen
        if planet.isPositionOffscreen(coords: newCoords) {
            
            if planet.isPositionScented(coords: coords) {
                //already scented so don't move off surface
            } else {
                //mark current square and fall off
                planet.markScentAtPosition(coords: coords)
                isLost = true
            }
        } else {
            //only update if not off screen
            coords = newCoords
        }
    }
    
    private func moveTo(newCoords: (x: Int, y: Int)) {
        coords = newCoords
    }
    
}
