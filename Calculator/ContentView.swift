//
//  ContentView.swift
//  Calculator
//
//  Created by Fidiana Mujaj on 7/19/22.
//

import SwiftUI
import Foundation

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

enum Operation {
    case add, subtract, divide, multiply, none
}

// the color blue color
let mainColor = Color.init(red: 0, green: 116/255, blue: 178/255, opacity: 1.0)


struct ContentView: View {
    
    // Variables for input and output
    @State var input = "0"
    @State var output = "0"
    
    @State var runningNum = 0
    @State var currentOp: Operation = .none
    
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
                                    self.compute(button: item)
                                }, label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 30))
                                        .frame(width: self.buttonHeight(), height: self.buttonHeight())
                                        .background(item.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(self.buttonHeight()/2)
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
    
    func compute(button: CalcButton) {
        switch button {
        case .add, .subtract, .divide, .multiply, .sin, .cos, .tan, .equal:
            doOperation(button: button)
        case .clear:
            self.input = "0"
            self.output = "0"
        case .decimal:
            break
        default:
            let number = button.rawValue
            //if self.runningNum != 0 {
               // self.input = number
           // }
            if self.input == "0" {
                self.input = number
            }
            else {
                self.input = "\(self.input)\(number)"
            }
        }
    }
    func doOperation(button: CalcButton) {
        if button == .add {
            self.currentOp = .add
            self.runningNum = Int(self.input) ?? 0
        }
        else if button == .subtract {
            self.currentOp = .subtract
            self.runningNum = Int(self.input) ?? 0
        }
        else if button == .divide {
            self.currentOp = .divide
            self.runningNum = Int(self.input) ?? 0
        }
        else if button == .multiply {
            self.currentOp = .multiply
            self.runningNum = Int(self.input) ?? 0
        }
        else if button == .sin {
            let input = Double(self.input) ?? 0.0
            self.output = "\(sin(input))"
        }
        else if button == .cos {
            let input = Double(self.input) ?? 0.0
            self.output = "\(cos(input))"
        }
        else if button == .tan {
            let input = Double(self.input) ?? 0.0
            self.output = "\(tan(input))"
        }
        else if button == .equal {
            let runningInput = self.runningNum
            let currentInput = Int(self.input) ?? 0
            switch self.currentOp {
            case .add: self.output = "\(runningInput + currentInput)"
            case .subtract: self.output = "\(runningInput - currentInput)"
            case .divide: self.output = "\(runningInput / currentInput)"
            case .multiply: self.output = "\(runningInput * currentInput)"
            case .none:
                break
            }
            self.runningNum = 0
            
        }
        
        
        if button != .equal {
            self.input = "0"
        }
        
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
