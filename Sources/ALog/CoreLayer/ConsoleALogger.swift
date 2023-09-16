//
//  ConsoleALogger.swift
//
//  Created by Vyacheslav Ansimov on 2023.
//

import Foundation
import os.log

public final class ConsoleALogger {

    private var isEnabled = false
    private lazy var isOSActivityDisabled: Bool = {
        ProcessInfo.processInfo.environment["OS_ACTIVITY_MODE"] == "disable"
    }()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    public init() {}
}

extension ConsoleALogger: ALoggerProtocol {

    public func setup(trace: ALogger.Trace) {
        #if DEBUG
        isEnabled = true
        #else
        isEnabled = !isOSActivityDisabled
        #endif
    }

    public func log(
        type: ALogTypeProtocol,
        message: String,
        trace: ALogger.Trace,
        subsystem: String,
        category: String
    ) {
        guard isEnabled else { return }

        if isOSActivityDisabled {
            let date = dateFormatter.string(from: Date())
            print(
                "[\(category)] • \(date) \(type.mark) (\(trace.file):\(trace.line) \(trace.function): \(message)"
            )
        } else {
            let log = OSLog(subsystem: subsystem, category: category)

            os_log(
                "[%{public}@] • %{public}@ (%{private}@:%{private}d) %{private}@: %{public}@",
                log: log,
                type: type.osLogType,
                category,
                type.mark,
                trace.file,
                trace.line,
                trace.function,
                message
            )
        }
    }
}
