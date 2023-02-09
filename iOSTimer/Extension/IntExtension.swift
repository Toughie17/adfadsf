//
//  IntExtension.swift
//  iOSTimer
//
//  Created by KimChoonSik on 2023/02/09.
//

import Foundation

protocol removeMagic {
    var zero: Int { get }
    var one: Int { get }
}

extension Int: removeMagic {
    var zero: Int {
        return 0
    }
    
    var one: Int {
        return 1
    }
}
