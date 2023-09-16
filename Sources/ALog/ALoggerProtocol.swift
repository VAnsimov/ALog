//
//  ALoggerProtocol.swift
//
//  Created by Vyacheslav Ansimov on 2023.
//

import Foundation

public protocol ALoggerProtocol {
    func setup(trace: ALogger.Trace)
    func log(
        type: ALogTypeProtocol,
        message: String,
        trace: ALogger.Trace,
        subsystem: String,
        category: String
    )
}
