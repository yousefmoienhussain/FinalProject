//
//  ContentView.swift
//  FINAL PROJECT 1
//
//  Created by Mac on 05/04/2022.
//

import SwiftUI
import Combine

var ShakeMessenger = PassthroughSubject<Void, Never>()

struct ContentView: View {
 @State var number = 1
    
    var body: some View {
        GeometryReader { geometry in
            ShakeHandlerRepresentable()
            
            VStack {
                Spacer()
                
                Image("\(number)")
                    .resizable()
                    .frame(width: 150.0, height: 150.0)
                
            Text("\(number)")
               .font(.largeTitle)
               .bold()
                .padding()
                .foregroundColor(.white)
                
                Spacer()
                
                Button {
                   roll()
                } label: {
                    Text("ROLL")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.red)
                        .padding(.vertical)
                }
                .frame(width: geometry.size.width * 0.8)
                .background(Color.orange)
                .cornerRadius(30)
                .padding(.bottom,50)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(LinearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom))
                        }
        .ignoresSafeArea()
        .onReceive(ShakeMessenger) { _ in roll()
    }
    }
        func roll() {
        number = .random(in: 1...6)
    }
        }

struct ShakeHandlerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ShakeHandler {
        ShakeHandler()
    }
    func updateUIViewController(_ uiViewController: ShakeHandler, context: Context) {
    }
}

class ShakeHandler: UIViewController {
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            ShakeMessenger.send()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
