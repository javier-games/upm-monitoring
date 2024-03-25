//
//  TrackerAdapter.swift
//  monitoring
//
//  Created by Francisco Javier García Gutiérrez on 2024/03/25.
//

import Foundation

var instance: Tracker?

@_cdecl("set_frame_rate")
public func setFrameRate(newFrameRate: CInt) {
    frameRate = Int(newFrameRate)
}

@_cdecl("start_tracking")
public func startTracking() {
    if instance != nil { return }
    instance = Tracker()
    instance?.startTracking()
}

@_cdecl("stop_tracking")
public func stopTracking() -> UnsafeMutablePointer<CChar>? {
    let stringResult = instance?.stopTracking() ?? ""
    instance = nil;
    return strdup(stringResult)
}

@_cdecl("flush")
public func flush() {
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let logsFolder = (documentsPath as NSString).appendingPathComponent("logs")

    do {
        let fileManager = FileManager.default
        let logFiles = try fileManager.contentsOfDirectory(atPath: logsFolder)

        for file in logFiles {
            let filePath = (logsFolder as NSString).appendingPathComponent(file)
            try fileManager.removeItem(atPath: filePath)
        }
    } catch {
        print("Error removing log files: \(error.localizedDescription)")
    }
}
