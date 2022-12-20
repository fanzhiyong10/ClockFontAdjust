//
//  ContentView.swift
//  ClockFontAdjust
//
//  Created by 范志勇 on 2022/12/20.
//

import SwiftUI

///Text font size will change if device orientation change.
struct ContentView: View {
    //MARK: device orientation
    @State private var isPortrait:Bool = (UIScreen.main.bounds.height > UIScreen.main.bounds.width)
    
    //MARK: Notification: orientation change
    private let orientationPublisher = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
    
    //MARK: timer
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //MARK: current time
    @State var str_current_time = "\(Date().formatted(date: .omitted, time: .standard))"

    var body: some View {
        Group{
            if self.isPortrait {
                HStack(spacing: 0){
                    Text(str_current_time)
                        .font(.system(size: UIScreen.main.bounds.width / 6, weight: .bold))
                        .padding()
                        .onReceive(timer) { time in
                            self.str_current_time = "\(Date().formatted(date: .omitted, time: .standard))"
                        }
                }
            } else {
                VStack(spacing: 0){
                    Text(str_current_time)
                        .font(.system(size: UIScreen.main.bounds.width / 6, weight: .bold))
                        .padding()
                        .onReceive(timer) { time in
                            self.str_current_time = "\(Date().formatted(date: .omitted, time: .standard))"
                        }
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
