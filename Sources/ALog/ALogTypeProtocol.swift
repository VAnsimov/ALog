//
//  ALogTypeProtocol.swift
//
//  Created by Vyacheslav Ansimov on 2023.
//

import os.log

public protocol ALogTypeProtocol {
    var mark: String { get }
    var identificator: String { get }
    var osLogType: OSLogType { get }
}
