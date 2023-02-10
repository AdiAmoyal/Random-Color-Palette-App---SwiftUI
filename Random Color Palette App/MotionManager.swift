//
//  MotionManager.swift
//  Random Color Palette App
//
//  Created by Adi Amoyal on 10/02/2023.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    var motion = CMMotionManager()
    @Published var isShaking: Bool = false
    
    init() {
        isShaking = false
        startMonitoringShakes()
    }
    
    func startMonitoringShakes() {
        guard motion.isAccelerometerAvailable else { return }

        motion.accelerometerUpdateInterval = 0.1
        motion.startAccelerometerUpdates(to: .main) { [self] (data, error) in
            guard let data = data else { return }

            let acceleration = data.acceleration
            let threshold = 2.0

            if (acceleration.x > threshold || acceleration.x < -threshold ||
                acceleration.y > threshold || acceleration.y < -threshold ||
                acceleration.z > threshold || acceleration.z < -threshold) {
                self.isShaking = true
            } else {
                self.isShaking = false
            }
        }
    }
}
