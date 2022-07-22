//
//  ContentView.swift
//  Calculator
//
//  Created by Fidiana Mujaj on 7/19/22.
//

import SwiftUI

/* Buttons to be displayed. */
enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case subtract = "-"
    case add = "+"
    case divide = "/"
    case multiply = "x"
    case sin = "sin"
    case cos = "cos"
    case tan = "tan"
    case decimal = "."
    case equal = "="
    case clear = "AC"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .sin, .cos, .tan, .equal, .divide, .clear:
            return .black
        default:
            return mainColor
        }
    }
}

// the color blue color
let mainColor = Color.init(red: 0, green: 116/255, blue: 178/255, opacity: 1.0)


struct ContentView: View {
    
    // Variables for input and output
    @State var input = "0"
    @State var output = "0"
    
    let buttons: [[CalcButton]] = [
        [.clear, .subtract, .add, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .sin],
        [.one, .two, .three, .cos],
        [.zero, .decimal, .equal, .tan]
    ]
    
    var body: some View {
        //stacks its children on top of one another
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Text(output)
                        .bold()
                        .font(.system(size: 46))
                        .foregroundColor(mainColor)
                }
                .padding(.trailing)
                
                
                Divider()
                
                
                HStack() {
                    Spacer()
                    Text(input)
                        .bold()
                        .font(.system(size: 46))
                        .foregroundColor(.white)
                }
                .padding(.trailing)
                
                /* Display buttons */
                VStack {
                    ForEach(buttons, id: \.self) {row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) {item in
                                Button(action: {
                                    
                                }, label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 30))
                                        .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                        .background(item.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(self.buttonWidth(item: item)/2)
                                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(mainColor, lineWidth: 1))
                                })
                                
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
            }
            Spacer()
        }
    }
    func buttonWidth(item: CalcButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
