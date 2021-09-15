//
//  RobotDemoTests.swift
//  RobotDemoTests
//
//  Created by Dominic Wood on 13/09/2021.
//

import XCTest
@testable import RobotDemo

class RobotDemoTests: XCTestCase {

    //Mars tests
    
    func testMarsOversizedX() throws {
        let testMars = Mars()
        XCTAssertFalse(testMars.setMarsSurfaceDimension(coords: (x: 51, y: 50)))
        
    }
    
    func testMarsOversizedY() throws {
        let testMars = Mars()
        XCTAssertFalse(testMars.setMarsSurfaceDimension(coords: (x: 50, y: 51)))
        
    }
    
    func testMarsWithinSize() throws {
        let testMars = Mars()
        XCTAssertTrue(testMars.setMarsSurfaceDimension(coords: (x: 24, y: 24)))
        
    }
    
    func testMarsPositionOffscreen() throws {
        let testMars = Mars()
        testMars.setMarsSurfaceDimension(coords: (x: 24, y: 24))
                                         
        XCTAssertTrue(testMars.isPositionOffscreen(coords: (x: 24, y: 0)))
        XCTAssertTrue(testMars.isPositionOffscreen(coords: (x: 0, y: 24)))
        XCTAssertTrue(testMars.isPositionOffscreen(coords: (x: -1, y: 0)))
        XCTAssertTrue(testMars.isPositionOffscreen(coords: (x: 0, y: -1)))
                                                                                                 
        XCTAssertFalse(testMars.isPositionOffscreen(coords: (x: 12, y: 12)))
    }
    
    func testScentPosition() throws {
        let testMars = Mars()
        testMars.setMarsSurfaceDimension(coords: (x: 24, y: 24))
        
        XCTAssertFalse(testMars.isPositionScented(coords: (x: 12 , y: 12)))
        testMars.markScentAtPosition(coords: (x: 12, y: 12))
        XCTAssertTrue(testMars.isPositionScented(coords: (x: 12 , y: 12)))
    }
    
    //Robot tests
    
    func testRobotLogPositionHeading() throws {
        let testRobot = Robot()
        testRobot.coords = (x: 1, y: 1)
        testRobot.heading = .north
        let log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "1 1 N")
    }
    
    func testRobotRotateRight() throws {
        let testRobot = Robot()
        testRobot.coords = (x: 1, y: 1)
        testRobot.heading = .north
        testRobot.rotateRight()
        var log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "1 1 E")
        testRobot.rotateRight()
        log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "1 1 S")
        testRobot.rotateRight()
        log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "1 1 W")
        testRobot.rotateRight()
        log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "1 1 N")
    }
    
    func testRobotRotateLeft() throws {
        let testRobot = Robot()
        testRobot.coords = (x: 1, y: 1)
        testRobot.heading = .north
        testRobot.rotateLeft()
        var log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "1 1 W")
        testRobot.rotateLeft()
        log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "1 1 S")
        testRobot.rotateLeft()
        log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "1 1 E")
        testRobot.rotateLeft()
        log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "1 1 N")
    }
    
    
    
    func testRobotForward() throws {
        let testRobot = Robot()
        let testMars = Mars()
        guard testMars.setMarsSurfaceDimension(coords: (x: 24, y: 24)) else {
            return
        }
        testRobot.planet = testMars
        
        testRobot.coords = (x: 6, y: 6)
        testRobot.heading = .east
        testRobot.moveForward()
        var log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "7 6 E")
        testRobot.heading = .south
        testRobot.moveForward()
        log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "7 5 S")
        testRobot.heading = .west
        testRobot.moveForward()
        log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "6 5 W")
        testRobot.heading = .north
        testRobot.moveForward()
        log = testRobot.logPositionHeading()
        XCTAssertEqual(log, "6 6 N")
        
    }
    

}
