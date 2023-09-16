import XCTest
import os.log

@testable import ALog

final class ALoggerTests: XCTestCase {

    private var consoleALoggerMock: ConsoleALoggerMock!

    override func setUp() {
        super.setUp()
        ALog.setup(loggers: [])
        consoleALoggerMock = ConsoleALoggerMock()
    }
}

// MARK: - Tests

extension ALoggerTests {
    func testLog() throws {
        ALog.setup(loggers: [
            consoleALoggerMock
        ])

        let logLine = #line + 1
        ALog.log("It's a log", type: LogTypeMock(), category: "ALogTests_testLog")

        XCTAssertEqual(consoleALoggerMock.setups.count, 1)
        XCTAssertEqual(consoleALoggerMock.logs.count, 1)
        XCTAssertEqual(consoleALoggerMock.logs[0], "[ALogTests_testLog] • MM🔧 🔧 (ALogTests.swift:\(logLine) testLog(): It's a log")
    }

    func testDefaultOperations() throws {
        ALog.setup(loggers: [
            consoleALoggerMock
        ])

        let errorLogLine = #line + 1
        ALog.error("Something went wrong", category: "ALogTests_testDefaultOperations")

        let successLogLine = #line + 1
        ALog.success("It's a successful log", category: "ALogTests_testDefaultOperations")

        let infoLogLine = #line + 1
        ALog.information("It's a information log", category: "ALogTests_testDefaultOperations")

        let warningLogLine = #line + 1
        ALog.warning("It's a warning log", category: "ALogTests_testDefaultOperations")

        XCTAssertEqual(consoleALoggerMock.setups.count, 1)
        XCTAssertEqual(consoleALoggerMock.logs.count, 4)
        XCTAssertEqual(consoleALoggerMock.logs[0], "[ALogTests_testDefaultOperations] • M🚫 🚫 (ALogTests.swift:\(errorLogLine) testDefaultOperations(): Something went wrong")
        XCTAssertEqual(consoleALoggerMock.logs[1], "[ALogTests_testDefaultOperations] • M✅ ✅ (ALogTests.swift:\(successLogLine) testDefaultOperations(): It's a successful log")
        XCTAssertEqual(consoleALoggerMock.logs[2], "[ALogTests_testDefaultOperations] • Mℹ️ ℹ️ (ALogTests.swift:\(infoLogLine) testDefaultOperations(): It's a information log")
        XCTAssertEqual(consoleALoggerMock.logs[3], "[ALogTests_testDefaultOperations] • M⚠️ ⚠️ (ALogTests.swift:\(warningLogLine) testDefaultOperations(): It's a warning log")
    }
}

// MARK: - Mocks

struct LogTypeMock: ALogTypeProtocol {
    let identificator: String = "🔧"
    var mark: String { "M" + identificator }
    let osLogType: OSLogType = .default
}

class ConsoleALoggerMock: ALoggerProtocol {
    private(set) var setups: [ALogger.Trace] = []
    private(set) var logs: [String] = []

    func setup(trace: ALogger.Trace) {
        setups.append(trace)
    }

    func log(
        type: ALogTypeProtocol,
        message: String,
        trace: ALogger.Trace,
        subsystem: String,
        category: String
    ) {
        let log = "[\(category)] • M\(type.mark) \(type.identificator) (\(trace.file):\(trace.line) \(trace.function): \(message)"
        print(log)
        logs.append(log)
    }
}
