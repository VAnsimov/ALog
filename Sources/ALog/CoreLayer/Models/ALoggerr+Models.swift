//
//  ALogger+Models.swift
//  
//  Created by Vyacheslav Ansimov on 2023.
//

import Foundation

public enum ALogger {}

public extension ALogger {
    struct Trace {
        public let file: String
        public let function: String
        public let line: UInt

        init(
            filePath: String,
            function: String,
            line: UInt
        ) {
            self.file = URL(fileURLWithPath: filePath).lastPathComponent
            self.function = function
            self.line = line
        }
    }
}
