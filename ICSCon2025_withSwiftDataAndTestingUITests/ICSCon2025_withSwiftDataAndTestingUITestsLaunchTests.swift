//
//  ICSCon2025_withSwiftDataAndTestingUITestsLaunchTests.swift
//  ICSCon2025_withSwiftDataAndTestingUITests
//
//  Created by Steve Spigarelli on 8/12/25.
//

import XCTest

final class ICSCon2025_withSwiftDataAndTestingUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
