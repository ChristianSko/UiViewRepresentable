//
//  ContentView.swift
//  UiViewRepresentable
//
//  Created by Christian Skorobogatow on 11/8/22.
//

import SwiftUI
import UIKit

struct UIViewRepresentableExample: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            
            Text(text)
                .padding()
            
            HStack {
                Text("SwiftUI: ")
                
                TextField("Type here...",
                          text: $text)
                    .padding()
                    .frame(height: 55)
                    .background(.gray)
            }
            .padding()
            
            
            
            
            HStack {
                Text("UIKIT: ")
                UITextFieldViewRepresentable(text: $text)
                    .updatePlaceholder("New placeholder")
                    .padding()
                    .frame(height: 55)
                    .background(.gray)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentableExample()
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    var placeholder: String
    @Binding var text: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String = "Default placeholder...", placeholderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    
    func makeUIView(context: Context) -> UITextField {
        let texfield = getTextfield()
        texfield.delegate = context.coordinator
        
        return texfield
    }
    
    //Sends Data from SwiftUI to UIKIT
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextfield() -> UITextField {
        let textfield = UITextField(frame: .zero)
        let placeholder = NSAttributedString(string: placeholder,
                                             attributes: [.foregroundColor : placeholderColor])
        
        textfield.attributedPlaceholder = placeholder
        textfield.delegate = makeCoordinator()
        
        return textfield
    }
    
    func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable{
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    //Sends from UIKIT to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>){
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}


struct BasicUIViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
}
