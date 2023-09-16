//
//  ALogType.swift
//
//  Created by Vyacheslav Ansimov on 2023.
//

import os.log

struct ALogTypeDebug: ALogTypeProtocol {
    public let identificator: String = "🔨"
    public var mark: String { identificator }
    public let osLogType: OSLogType = .debug
}

struct ALogTypeWarning: ALogTypeProtocol {
    public let identificator: String = "⚠️"
    public var mark: String { identificator }
    public let osLogType: OSLogType = .default
}

struct ALogTypeInfo: ALogTypeProtocol {
    public let identificator: String = "ℹ️"
    public var mark: String { identificator }
    public let osLogType: OSLogType = .info
}

struct ALogTypeSuccess: ALogTypeProtocol {
    public let identificator: String = "✅"
    public var mark: String { identificator }
    public let osLogType: OSLogType = .info
}

struct ALogTypeError: ALogTypeProtocol {
    public let identificator: String = "🚫"
    public var mark: String { identificator }
    public let osLogType: OSLogType = .error
}
