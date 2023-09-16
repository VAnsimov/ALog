//
//  ALog.swift
//
//  Created by Vyacheslav Ansimov on 2023.
//

import Foundation

/// ALog
/// Initialization:
///
/// ```swift
/// ALog.setup()
///
/// // OR
/// // ALog.setup(loggers: [ConsoleALogger(), MyCustomALogger()])
/// ```
///
/// Example:
///
/// ```swift
/// ALog.error("Something went wrong")
/// ALog.success("It's a successful log")
/// ALog.information("It's a information log")
/// ALog.warning("It's a warning log")
///
/// // OR
/// // ALog.log("Something went wrong", type: MyLogType())
/// ```
public class ALog {

    private static var loggers: [ALoggerProtocol] = []
}

// MARK: - Public

public extension ALog {

    /// Initial setup of loggers
    /// Should be called on start of application
    static func setup(
        loggers: [ALoggerProtocol] = [ConsoleALogger()],
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        Self.loggers = loggers
        let trace = ALogger.Trace(filePath: file, function: function, line: line)
        Self.loggers.forEach { $0.setup(trace: trace) }
    }

    static func log(
        _ message: String,
        type: ALogTypeProtocol,
        category: String = .defaultLogCategory,
        bundle: Bundle = .main,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        log(
            type: type,
            message: message,
            trace: .init(filePath: file, function: function, line: line),
            bundle: bundle,
            category: category
        )
    }

    /// 🔨 Log message with Debug type.
    /// Using for debugging information.
    /// Would NOT be attached to remote logs.
    static func debug(
        _ message: String,
        category: String = .defaultLogCategory,
        bundle: Bundle = .main,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        log(
            type: ALogTypeDebug(),
            message: message,
            trace: .init(filePath: file, function: function, line: line),
            bundle: bundle,
            category: category
        )
    }

    /// ⚠️ Log message with Warning type.
    /// Using for debugging information.
    /// Would be attached to remote logs.
    static func warning(
        _ message: String,
        category: String = .defaultLogCategory,
        bundle: Bundle = .main,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        log(
            type: ALogTypeWarning(),
            message: message,
            trace: .init(filePath: file, function: function, line: line),
            bundle: bundle,
            category: category
        )
    }

    /// ℹ️ Log message with Info type.
    /// Using for debugging information.
    /// Would be attached to remote logs.
    static func information(
        _ message: String,
        category: String = .defaultLogCategory,
        bundle: Bundle = .main,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        log(
            type: ALogTypeInfo(),
            message: message,
            trace: .init(filePath: file, function: function, line: line),
            bundle: bundle,
            category: category
        )
    }

    /// ✅ Log message with Success type.
    /// Used for logging important success events.
    /// Would be attached to remote logs.
    static func success(
        _ message: String,
        category: String = .defaultLogCategory,
        bundle: Bundle = .main,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        log(
            type: ALogTypeSuccess(),
            message: message,
            trace: .init(filePath: file, function: function, line: line),
            bundle: bundle,
            category: category
        )
    }

    /// 🚫 Log message with Success type.
    /// Would be attached to remote logs.
    static func error(
        _ message: String,
        category: String = .defaultLogCategory,
        bundle: Bundle = .main,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        log(
            type: ALogTypeError(),
            message: message,
            trace: .init(filePath: file, function: function, line: line),
            bundle: bundle,
            category: category
        )
    }
}

// MARK: - Private

private extension ALog {

    static func log(
        type: ALogTypeProtocol,
        message: String?,
        trace: ALogger.Trace,
        bundle: Bundle,
        category: String
    ) {
        ALog.loggers.forEach {
            $0.log(
                type: type,
                message: message ?? .init(),
                trace: trace,
                subsystem: bundle.bundleIdentifier!,
                category: category
            )
        }
    }
}

// MARK: - Constants

public extension String {
    static var defaultLogCategory: String { "Application" }
}
