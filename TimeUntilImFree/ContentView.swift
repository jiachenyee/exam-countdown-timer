//
//  ContentView.swift
//  TimeUntilImFree
//
//  Created by Jia Chen Yee on 14/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var started = false
    @State private var endTime = Date.now
    @State private var timeIntervalTillEnd = 0.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if !started {
            Form {
                DatePicker("End Time", selection: $endTime, displayedComponents: [.hourAndMinute, .date])
                
                Button {
                    started = true
                } label: {
                    Text("Start")
                }
            }
        } else {
            VStack {
                Text("Time until end of test")
                    .font(.headline)
                Text("\(timeIntervalTillEnd)s")
                    .contentTransition(.numericText())
                    .monospacedDigit()
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .onReceive(timer, perform: { date in
                withAnimation {
                    timeIntervalTillEnd = endTime.timeIntervalSinceNow
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
