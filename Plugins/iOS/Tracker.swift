//
//  Tracker.swift
//  monitoring
//
//  Created by Francisco Javier García Gutiérrez on 2024/03/25.
//

import Foundation

var frameRate = 30

class Tracker {
    var isTracking: Bool = false
    var logFilePath: String = ""
    var timer: Timer?

    func startTracking() {
        guard !isTracking else { return }
        isTracking = true

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        let currentDateTime = dateFormatter.string(from: Date())

        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let logsFolder = (documentsPath as NSString).appendingPathComponent("logs")

        do {
            try FileManager.default.createDirectory(atPath: logsFolder, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating logs folder: \(error.localizedDescription)")
            return
        }

        logFilePath = (logsFolder as NSString).appendingPathComponent("log_\(currentDateTime).txt")

        FileManager.default.createFile(atPath: logFilePath, contents: nil, attributes: nil)
        timer = Timer.scheduledTimer(
            timeInterval: TimeInterval(1/frameRate),
            target: self,
            selector: #selector(update),
            userInfo: nil,
            repeats: true
        )
    }

    @objc func update() {
        guard isTracking else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss:SSS"
        let currentTime = dateFormatter.string(from: Date())
        appendTextToFile(logFilePath, text: currentTime + " CPU:" + String(cpuUsage()) + " GPU:" + String(gpuUsage()) + " RAM:" + String(ramUsage()) )
    }

    private func appendTextToFile(_ filePath: String, text: String) {
        if let fileHandle = FileHandle(forWritingAtPath: filePath) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(text.data(using: .utf8)!)
            fileHandle.write("\n".data(using: .utf8)!)
            fileHandle.closeFile()
        } else {
            print("Error writing to file at path: \(filePath)")
        }
    }
    
    public func stopTracking() -> String {
        guard isTracking else { return "" }

        timer?.invalidate()
        timer = nil
        isTracking = false
        return logFilePath
    }
}
