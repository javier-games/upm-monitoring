//
//  PerformanceCalculatorAdapter.swift
//
//  Created by Francisco Javier García Gutiérrez on 2024/11/06.
//

import Foundation

@_cdecl("get_gpu_usage")
public func getGpuUsage() -> CFloat {
    return gpuUsage()
}

@_cdecl("get_ram_usage")
public func getRamUsage() -> CFloat {
    return ramUsage()
}

@_cdecl("get_cpu_usage")
public func getCpuUsage() -> CFloat {
    return cpuUsage()
}
