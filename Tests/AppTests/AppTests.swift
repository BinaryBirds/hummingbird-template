import Hummingbird
import HummingbirdXCT
import XCTest
@testable import App

final class AppTests: XCTestCase {

    struct TestArguments: AppArguments {
        
    }

    func testHealth() throws {

        let args = TestArguments()
        let app = HBApplication(testing: .live)
        try app.configure(args)

        try app.XCTStart()
        defer { XCTAssertNoThrow(app.XCTStop()) }

        try app.XCTExecute(uri: "/health", method: .GET) { response in
            XCTAssertEqual(response.status, .ok)
        }
    }

    func testHelloWorld() throws {

        let args = TestArguments()
        let app = HBApplication(testing: .live)
        try app.configure(args)

        try app.XCTStart()
        defer { XCTAssertNoThrow(app.XCTStop()) }

        try app.XCTExecute(uri: "/", method: .GET) { response in
            XCTAssertEqual(response.status, .ok)

            let expectation = "Hello, world!"
            let res = response.body.map { String(buffer: $0) }
            XCTAssertEqual(res, expectation)
        }
    }
}
