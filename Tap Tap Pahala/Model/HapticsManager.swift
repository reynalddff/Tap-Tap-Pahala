//
//  File.swift
//  Tap Tap Pahala
//
//  Created by Reynald Daffa Pahlevi on 03/05/21.
//

import UIKit

final class HapticManagers {
    static let shared = HapticManagers()
    
    private init() {}
    
    func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.prepare()
            selectionFeedbackGenerator.selectionChanged()

        }
    }
    
    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
}
