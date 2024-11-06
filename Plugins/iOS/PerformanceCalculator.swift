//
//  PerformanceCalculator.swift
//  monitoring
//
//  Created by Francisco Javier García Gutiérrez on 2024/03/25.
//

import Foundation
import Metal
import UIKit
    
public func gpuUsage() -> Float {
    
    guard let mtlDevice = MTLCreateSystemDefaultDevice()
    else { return 0 }
    
    let totalMemory: Float
    if #available(iOS 16.0, *) {
        totalMemory = Float(mtlDevice.recommendedMaxWorkingSetSize)
    } else {
        totalMemory = getApproximateGPUMemory() * 1000000
    }
    
    return Float(mtlDevice.currentAllocatedSize) / totalMemory
}

public func ramUsage() -> Float {
    
    var vmInfo = task_vm_info_data_t()
    var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
    
    let result: kern_return_t = withUnsafeMutablePointer(to: &vmInfo) {
        $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
            task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
        }
    }
    
    if result != KERN_SUCCESS { return 0 }
    
    return Float(vmInfo.phys_footprint) / Float(ProcessInfo.processInfo.physicalMemory)
}
 
public func cpuUsage() -> Float {
    var totalUsage: Float = 0.0
    var threadsArray: thread_act_array_t?
    var threadsCount = mach_msg_type_number_t(0)
    
    let threadsResult = task_threads(mach_task_self_, &threadsArray, &threadsCount)
    
    guard threadsResult == KERN_SUCCESS, let threads = threadsArray else {
        return totalUsage
    }
    
    defer {
        vm_deallocate(mach_task_self_, vm_address_t(UInt(bitPattern: threadsArray)), vm_size_t(Int(threadsCount) * MemoryLayout<thread_t>.stride))
    }
    
    for index in 0..<Int(threadsCount) {
        var threadInfo = thread_basic_info()
        var threadInfoCount = mach_msg_type_number_t(THREAD_INFO_MAX)
        let threadInfoResult = withUnsafeMutablePointer(to: &threadInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                thread_info(threads[index], thread_flavor_t(THREAD_BASIC_INFO), $0, &threadInfoCount)
            }
        }
        
        guard threadInfoResult == KERN_SUCCESS else {
            continue
        }
        
        let threadBasicInfo = threadInfo as thread_basic_info
        if threadBasicInfo.flags & TH_FLAGS_IDLE == 0 {
            totalUsage += Float(threadBasicInfo.cpu_usage) / Float(TH_USAGE_SCALE)
        }
    }
    
    return totalUsage
}

private func getApproximateGPUMemory() -> Float {
    switch UIDevice.current.model {
    case "iPhone1,1",
        "iPhone1,2",
        "iPhone2,1",
        "iPad1,1":
        return 128
    case "iPad2,1",
        "iPad2,2",
        "iPad2,3",
        "iPad2,4":
        return 256
    case "iPhone3,1",
        "iPhone3,2",
        "iPhone3,3",
        "iPhone4,1",
        "iPad3,1",
        "iPad3,2",
        "iPad3,3":
        return 512
    case "iPad3,4",
        "iPad3,5",
        "iPad3,6":
        return 1024
    case "iPhone5,1",
        "iPhone5,2",
        "iPhone5,3",
        "iPhone5,4",
        "iPhone6,1",
        "iPhone6,2",
        "iPhone7,2",
        "iPhone8,1",
        "iPhone8,4",
        "iPhone9,1",
        "iPhone9,3",
        "iPhone9,2",
        "iPhone9,4",
        "iPhone10,1",
        "iPhone10,4",
        "iPhone10,2",
        "iPhone10,5",
        "iPhone10,3",
        "iPhone10,6",
        "iPhone11,2",
        "iPhone11,8",
        "iPhone12,1",
        "iPad6,11",
        "iPad6,12",
        "iPad7,5",
        "iPad7,6",
        "iPad7,11",
        "iPad7,12":
        return 2048
    case "iPad11,1",
        "iPad11,2":
        return 3072
    case "iPhone11,6",
        "iPhone12,3",
        "iPhone12,5",
        "iPhone12,8",
        "iPad11,3",
        "iPad11,4":
        return 4096
    case "iPad13,1",
        "iPad13,2":
        return 5120
    case "iPad13,4",
        "iPad13,5",
        "iPad13,6",
        "iPad13,7":
        return 8192
    default:
        return 0 // Unknown device model
    }
}
