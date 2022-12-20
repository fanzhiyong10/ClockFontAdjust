//
//  ContentView.swift
//  ClockFontAdjust
//
//  Created by 范志勇 on 2022/12/20.
//

import SwiftUI

struct ContentView: View {
    /// device orientation
    @State private var isPortrait:Bool = (UIScreen.main.bounds.height > UIScreen.main.bounds.width)
    
    /// orientation change
    private let orientationPublisher = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)

    var body: some View {
        Group{
            if self.isPortrait {
                HStack(spacing: 0){
                    Text("\(Date().formatted(date: .omitted, time: .standard))")
                        .font(.system(size: UIScreen.main.bounds.width / 6, weight: .bold))
                        .padding()
                }
            } else {
                VStack(spacing: 0){
                    Text("\(Date().formatted(date: .omitted, time: .standard))")
                        .font(.system(size: UIScreen.main.bounds.width / 6, weight: .bold))
                        .padding()
                }
            }
        }
        .onReceive(orientationPublisher) { _ in
            switch (UIDevice.current.orientation){
            case .portrait:
                self.isPortrait = true
            case .landscapeLeft, .landscapeRight:
                self.isPortrait = false
            default:
                break
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
