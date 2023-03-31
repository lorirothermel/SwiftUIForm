//
//  TextFieldFormView.swift
//  SwiftUIForm
//
//  Created by Lori Rothermel on 3/30/23.
//

import SwiftUI

struct TextFieldFormView: View {
    @State private var text = ""
    @State private var error: ValidationError?
    
    @EnvironmentObject var contentBuilder: FormContentBuilderImpl
        
    let component: TextFormComponent
    
        
    var body: some View {
        
        VStack(alignment: .leading) {
            TextField(component.placeholder, text: $text)
                .frame(maxWidth: .infinity, minHeight: 44, alignment: .center)
                .padding(.leading, 5)
                .keyboardType(component.keyboardType)
                .background(
                              RoundedRectangle(cornerRadius: 10)
                                .stroke(error == nil ? Color.gray.opacity(0.25) : Color.red)
                )
            
            Text(error?.errorDescription ?? "")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.red)
            
        }  // VStack
        .onChange(of: text) { newValue in
            contentBuilder.update(text, in: component)
            
            // Perform validation
            error = component.validations.compactMap {$0.validate(text)}.first
        }
    }  // some View
}  // TextFieldFormView

struct TextFieldFormView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldFormView(component: .init(id: .firstName, placeholder: ""))
            .environmentObject(FormContentBuilderImpl())
            .previewLayout(.sizeThatFits)
            .padding(.horizontal)
            
    }
}
